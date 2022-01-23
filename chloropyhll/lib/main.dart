import 'package:flutter/material.dart';
import 'package:chloropyhll/screens/login_screen.dart';
import 'package:chloropyhll/screens/splash_screen.dart';
import 'package:chloropyhll/screens/HomePage.dart';
import 'package:chloropyhll/screens/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/signupScreen': (context) => SignupScreen(),
        '/loginScreen': (context) => LoginScreen(),
        '/homeScreen': (context) => Home(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
