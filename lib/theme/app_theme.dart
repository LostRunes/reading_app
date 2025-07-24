
// Holds the light and dark theme data/colors used

import 'package:flutter/material.dart';

class AppColors {
  // color palette 
  static const primary   = Color.fromARGB(255, 243, 116, 169); 
  static const softBlue  = Color(0xFFB4E9F8);
  static const softPink  = Color(0xFFFFD7E5);
  static const softPurple= Color(0xFFE6D6FF);
}

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.transparent // transparent so that the bg image shows up
  );
}
