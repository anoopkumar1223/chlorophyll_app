import 'package:flutter/material.dart';

void push(
    {@required BuildContext context, @required String screen, Map arguments}) {
  Navigator.pushNamed(context, screen, arguments: arguments);
}

void pushReplacement(
    {@required BuildContext context, @required String screen, Map arguments}) {
  Navigator.pushReplacementNamed(context, screen, arguments: arguments);
}
