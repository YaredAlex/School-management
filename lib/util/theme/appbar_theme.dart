import 'package:flutter/material.dart';
import 'package:school_managment/util/constants/colors/colors.dart';

class CAppBarTheme {
  CAppBarTheme._();

  static const AppBarTheme lightAppbarTheme = AppBarTheme(
    backgroundColor: CColors.primary,
    foregroundColor: Colors.white,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  );
  static const AppBarTheme darkAppbarTheme = AppBarTheme(
    backgroundColor: CColors.primary,
    foregroundColor: Colors.white,
    scrolledUnderElevation: 0,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  );
}
