import 'package:flutter/material.dart';

class MyThemes {
  static const primary = Colors.pink;
  static final primaryColor = Colors.blue.shade500;
  static const iconColor = Colors.black;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor,
    colorScheme: const ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
  );
}
