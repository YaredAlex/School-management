import 'package:flutter/material.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/theme/appbar_theme.dart';
import 'package:school_managment/util/theme/button_theme.dart';
import 'package:school_managment/util/theme/inputDecoration.dart';
import 'package:school_managment/util/theme/switchlist_theme.dart';
import 'package:school_managment/util/theme/text_theme.dart';

class CTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: CColors.backgroundPrimary,
      textTheme: CTextTheme.lightText,
      brightness: Brightness.light,
      elevatedButtonTheme: CButtonTheme.lightElevatedButton,
      primaryColor: CColors.primary,
      inputDecorationTheme: CInputDecoration.lightDecoration,
      switchTheme: CSwitchListTheme.lightSwitchList,
      appBarTheme: CAppBarTheme.lightAppbarTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: CColors.backgroundDark,
      textTheme: CTextTheme.darkText,
      brightness: Brightness.dark,
      elevatedButtonTheme: CButtonTheme.darkElevatedButton,
      primaryColor: CColors.primary,
      inputDecorationTheme: CInputDecoration.darkDecoration,
      switchTheme: CSwitchListTheme.darkSwitchList,
      appBarTheme: CAppBarTheme.darkAppbarTheme);
}
