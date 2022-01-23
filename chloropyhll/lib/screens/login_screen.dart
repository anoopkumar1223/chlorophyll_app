import 'package:chloropyhll/resources/routes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:chloropyhll/Resources/Constants.dart';
import 'package:chloropyhll/authentication/otp_authentication.dart';
import 'package:chloropyhll/resources/images.dart';
import 'package:chloropyhll/resources/colors.dart';
import 'package:chloropyhll/resources/navigations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:chloropyhll/resources/strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedRadio = -1;
  static String userType;
  static TextEditingController phoneController = TextEditingController();


  Function codeSentToUser = (BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(Strings.autoDetect),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                SpinKitFadingCircle(
                  color: MyColors.lightGreen,
                  size: 50.0,
                ),
              ],
            ),
          );
        });
  };

  Function success = (BuildContext context) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    await databaseReference
        .child('users')
        .child(phoneController.text)
        .once()
        .then((DataSnapshot snapshot) {
      Navigator.of(context).pop();
      if (snapshot.value == null) {
        pushReplacement(context: context, screen: Routes.signupScreen, arguments: {
          'phone' : phoneController.text,
          'userType' : userType,
        });
      } else {
        pushReplacement(context: context, screen: Routes.homeScreen);
      }
    });
  };

  Function failure = (BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(Strings.internet),
            actions: <Widget>[
              FlatButton(
                  child: Text("OK"),
                  textColor: Colors.white,
                  color: MyColors.lightGreen,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  };

  Function timeout = (BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
                "Verification timeout. Make sure the number ${phoneController.text} is in your device."),
            actions: <Widget>[
              FlatButton(
                  child: Text("Retry"),
                  textColor: Colors.white,
                  color: MyColors.lightGreen,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'image',
                    child: Image.asset(
                      MyImages.loginpageImage,
                      width: 250,
                      height: 250,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Radio(
                        activeColor: MyColors.lightGreen,
                        value: 0,
                        groupValue: selectedRadio,
                        onChanged: ((value) {
                          setState(() {
                            selectedRadio = value;
                            userType = 'Farmer';
                          });
                        }),
                      ),
                      Text(
                        'Farmer',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      Radio(
                        activeColor: MyColors.lightGreen,
                        value: 1,
                        groupValue: selectedRadio,
                        onChanged: ((value) {
                          setState(() {
                            selectedRadio = value;
                            userType = 'Customer';
                          });
                        }),
                      ),
                      Text(
                        'Customer',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Radio(
                        activeColor: MyColors.lightGreen,
                        value: 2,
                        groupValue: selectedRadio,
                        onChanged: ((value) {
                          setState(() {
                            selectedRadio = value;
                            userType = 'Manufacturer';
                          });
                        }),
                      ),
                      Expanded(
                        child: Text(
                          'Manufacturer',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    cursorColor: MyColors.lightGreen,
                    buildCounter: (BuildContext context,
                            {int currentLength,
                            int maxLength,
                            bool isFocused}) =>
                        null,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    decoration: kInputDecoration,
                    controller: phoneController,
                  ),
                  SizedBox(height: 10),
                  FlatButton(
                    onPressed: () async {
                      if (phoneController.text.length < 10) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            Strings.validPhone,
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: MyColors.lightGreen,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                          elevation: 6,
                        ));
                      } else
                        loginUser(phoneController.text, context, success,
                            failure, timeout, codeSentToUser);
                    },
                    child: Text('Login'),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: MyColors.lightGreen,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
