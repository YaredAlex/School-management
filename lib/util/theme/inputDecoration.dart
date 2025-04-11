import 'package:flutter/material.dart';
import 'package:school_managment/util/constants/colors/colors.dart';

class CInputDecoration {
  CInputDecoration._();

  static InputDecorationTheme lightDecoration = InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    iconColor: const Color.fromARGB(255, 136, 136, 136),
    prefixIconColor: const Color.fromARGB(255, 136, 136, 136),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: CColors.borderLight), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(color: CColors.primary), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
    errorBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(color: Colors.red), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
    disabledBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(color: Colors.grey), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
          color: Color.fromARGB(255, 231, 231, 231)), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
  );

  static InputDecorationTheme darkDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.all(16),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: Color.fromARGB(255, 55, 55, 55)), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CColors.primary), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
          color: Color.fromARGB(255, 63, 63, 63)), // Change to desired color
      borderRadius: BorderRadius.circular(12.0), // Change to desired radius
    ),
  );
}
