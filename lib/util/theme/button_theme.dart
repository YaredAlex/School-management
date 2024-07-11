import 'package:flutter/material.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class CButtonTheme {
  static ElevatedButtonThemeData lightElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: CColors.primary,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CSizes.mdRadius)),
  ));

  static ElevatedButtonThemeData darkElevatedButton = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: CColors.primary,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CSizes.mdRadius)),
  ));
}
