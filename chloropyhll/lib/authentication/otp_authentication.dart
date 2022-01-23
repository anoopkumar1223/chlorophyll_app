import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future loginUser(String phone, BuildContext context, Function success,
    Function failure, Function timeout, Function codeSentToUser) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  _auth.verifyPhoneNumber(
    phoneNumber: '+91' + phone,
    timeout: Duration(seconds: 60),
    verificationCompleted: (AuthCredential credential) async {
      await verificationComplete(credential, context, success);
    },
    verificationFailed: (AuthException exception) {
      verificationFailed(exception, context, failure);
    },
    codeSent: (String verificationId, [int forceResendingToken]) {
      codeSentToUser(context);
    },
    codeAutoRetrievalTimeout: (value) {
      timeout(context);
    },
  );
}

Future verificationComplete(
    credential, BuildContext context, Function success) async {
  success(context);
  //This callback would gets called when verification is done automatically
}

void verificationFailed(
    AuthException exception, BuildContext context, Function failure) {
  failure(context);
}
