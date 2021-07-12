import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:techquadra_asssignment/provider/auth_service.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff393939),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(double.infinity, 60),
            ),
            onPressed: () {
              final provider = Provider.of<AuthService>(context, listen: false);
              provider.googleSignUp();
            },
            icon: FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            label: Text('Sign Up with Google'),
          ),
        ),
      ),
    );
  }
}
