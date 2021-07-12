import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
}
