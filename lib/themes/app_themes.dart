import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// app主题
class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.lightBlueAccent,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.lightBlueAccent,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    colorScheme: ColorScheme.light(),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.black45,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.grey),
    ),
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    colorScheme: ColorScheme.dark(),
  );
}
