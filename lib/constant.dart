import 'package:flutter/material.dart';

const backgroundColor = Color.fromRGBO(25, 23, 32, 1.0);
const dotColor = Color(0xFF00C898);
const signInBtnColor = Color.fromRGBO(36, 35, 43, 1.0);

class Constants {
  static const String AccountSettings = 'Account Settings';
  static const String PasswordSettings = 'Password Settings';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[
    AccountSettings,
    PasswordSettings,
    SignOut
  ];
}
