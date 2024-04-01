import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Color.fromARGB(255, 78, 72, 72)),
      titleLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      // Define more text styles here as needed
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF008080), // Teal color
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      // Define more text styles here as needed
    ),
  );
}
