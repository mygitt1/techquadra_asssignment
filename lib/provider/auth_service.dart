import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount user;

  Future googleSignUp() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future signUp(String phone, String name, String email) async {
    final url = 'http://3.16.11.45:8000/customer_sign_up/';
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    Map mapData = {
      "name": name,
      "mobile_no": phone,
      "email": email,
      "password": '',
      "sign_up_method": "google"
    };
    try {
      http.Response response = await http
          .post(
        Uri.parse(url),
        body: jsonEncode(mapData),
        headers: header,
      )
          .catchError((err) {
        print('Error $err');
      }).whenComplete(() => print('In when complete block'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
