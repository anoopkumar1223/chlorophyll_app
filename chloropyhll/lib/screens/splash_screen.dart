import 'dart:async';
import 'package:chloropyhll/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chloropyhll/resources/images.dart';
import 'package:chloropyhll/resources/navigations.dart';
import 'package:chloropyhll/resources/routes.dart';
import 'package:chloropyhll/resources/strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 6);
    return Timer(duration, route);
  }

  void route() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      pushReplacement(context: context, screen: Routes.loginScreen);
    } else
      pushReplacement(context: context, screen: Routes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              MyImages.splashScreenImage,
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  MyImages.chrolophyllLogo,
                  width: 80,
                  height: 80,
                ),
                Text(
                  Strings.company,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Strings.developer,
              ),
              Image.asset(
                MyImages.nixbeesLogo,
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
