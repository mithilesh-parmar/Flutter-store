import 'package:flutter/material.dart';

class Constants {
  static final CONSUMER_KEY_CLOUD =
      'ck_fc75eb207e9e48ecc852fbfdd9461f112ef9d860';
  static final CONSUMER_SECRET_CLOUD =
      'cs_998324c7091df9dd256117dcf6105865f155de78';

  static final URL_CLOUD = 'https://mastigophoran-miner.000webhostapp.com';

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.orange;
  static Color darkAccent = Colors.orangeAccent;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;

  static double baseHeight = 640;

  static double screenAwareSize(double size, BuildContext context) {
    return size * MediaQuery.of(context).size.height / baseHeight;
  }

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    hintColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
