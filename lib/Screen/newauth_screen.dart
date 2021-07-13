import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:techquadra_asssignment/Screen/home_Screen.dart';
import 'package:techquadra_asssignment/provider/auth_service.dart';

class NewAuthScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthService>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name : ${user.displayName}',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              'Email : ${user.email}',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            TextField(
              maxLength: 10,
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Enter your number',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await provider.signUp(
                    phoneController.text, user.displayName, user.email);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: Text('SignUp'),
            )
          ],
        ),
      ),
    );
  }
}
