import 'package:flutter/material.dart';
import 'package:school_managment/util/colors/colors.dart';

class CTextTheme {
  static const TextTheme lightText = TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      headlineMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
      headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      titleLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
      titleSmall: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: CColors.dimGray),
      bodyLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
      bodySmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: CColors.dimGray),
      labelMedium: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black),
      labelSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: CColors.dimGray));

  static const TextTheme darkText = TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
      headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
      titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: CColors.lightGray),
      bodyLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      bodySmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: CColors.lightGray),
      labelMedium: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white),
      labelSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: CColors.lightGray));
}
