import 'package:chloropyhll/resources/navigations.dart';
import 'package:flutter/material.dart';
import 'package:chloropyhll/Resources/Constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:chloropyhll/resources/images.dart';
import 'package:chloropyhll/resources/routes.dart';
import 'package:chloropyhll/resources/colors.dart';
import 'package:chloropyhll/resources/strings.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String name, address, aadhar, pan;
  Map argument = {};
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    argument = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Hero(
                tag: 'image',
                child: Image.asset(
                  MyImages.singuppageImage,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 40),
              Text(
                Strings.details,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    TextField(
                      cursorColor: MyColors.lightGreen,
                      buildCounter: (BuildContext context,
                              {int currentLength,
                              int maxLength,
                              bool isFocused}) =>
                          null,
                      textAlign: TextAlign.center,
                      decoration: kInputDecoration.copyWith(hintText: 'Name'),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    SizedBox(height: 15),
                    TextField(
                      cursorColor: Colors.lightGreen,
                      buildCounter: (BuildContext context,
                              {int currentLength,
                              int maxLength,
                              bool isFocused}) =>
                          null,
                      textAlign: TextAlign.center,
                      decoration:
                          kInputDecoration.copyWith(hintText: 'Address'),
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                    SizedBox(height: 15),
                    TextField(
                      cursorColor: Colors.lightGreen,
                      buildCounter: (BuildContext context,
                              {int currentLength,
                              int maxLength,
                              bool isFocused}) =>
                          null,
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      textAlign: TextAlign.center,
                      decoration:
                          kInputDecoration.copyWith(hintText: 'Aadhar Number'),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    SizedBox(height: 15),
                    TextField(
                      cursorColor: Colors.lightGreen,
                      buildCounter: (BuildContext context,
                              {int currentLength,
                              int maxLength,
                              bool isFocused}) =>
                          null,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration:
                          kInputDecoration.copyWith(hintText: 'Pan Number'),
                      maxLength: 10,
                      onChanged: (value) {
                        pan = value;
                      },
                    ),
                    SizedBox(height: 15),
                    FlatButton(
                      child: Text('Submit'),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return SpinKitFadingCircle(
                              color: Colors.lightGreen,
                              size: 80,
                            );
                          },
                        );
                        await databaseReference
                            .child("users")
                            .child(argument['phone'])
                            .set({
                          'name': name,
                          'address': address,
                          'aadhar number': aadhar,
                          'pan number': pan,
                          'user type': argument['userType'],
                        });
                        Navigator.of(context).pop();
                        pushReplacement(
                            context: context, screen: Routes.homeScreen);
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: MyColors.lightGreen,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
