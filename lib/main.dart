import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techquadra_asssignment/Screen/auth_screen.dart';
import 'package:techquadra_asssignment/Screen/home_Screen.dart';
import 'package:techquadra_asssignment/provider/auth_service.dart';
import 'package:techquadra_asssignment/provider/dataprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (ctx) => AuthService(),
        ),
        ChangeNotifierProvider<DataProvider>(
          create: (ctx) => DataProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<Object>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return HomeScreen();
              } else if (snapshot.hasError) {
                return Center(child: Text('Somthing went wrong'));
              } else {
                return AuthScreen();
              }
            }),
      ),
    );
  }
}
