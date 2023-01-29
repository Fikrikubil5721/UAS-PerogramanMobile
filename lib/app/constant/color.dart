import 'package:flutter/material.dart';

const textRed = Color(0xFFD61355);
const textBlue = Color(0xFF0081C9);

const bgBlue = Color(0xFFAAE3E2);
const bgRed = Color(0xFFF48484);

const bgAppDark = Color(0xFF03001C);
const bgDark = Color(0xFF282A3A);
const bgGrey = Color(0xFFEEEEEE);

const white = Color(0xFFF5EDED);

ThemeData dark = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: bgDark,
  ),
  backgroundColor: bgBlue,
  scaffoldBackgroundColor: bgDark,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: textRed),
    headline5: TextStyle(color: textBlue),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: bgBlue,
      textStyle: TextStyle(color: Colors.black),
    ),
  ),
);

ThemeData light = ThemeData(
  scaffoldBackgroundColor: bgGrey,
  appBarTheme: AppBarTheme(
    backgroundColor: bgRed,
  ),
  backgroundColor: bgRed,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: textRed),
    headline5: TextStyle(color: textBlue),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: bgRed,
      textStyle: TextStyle(color: Colors.black),
    ),
  ),
);
