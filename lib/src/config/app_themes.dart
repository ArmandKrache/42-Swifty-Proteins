import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme (
        elevation: 0,
        color: Colors.white,
        surfaceTintColor: Colors.white
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black87,
      splashColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black87),);
  }
}