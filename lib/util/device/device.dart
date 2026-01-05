import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_managment/util/constants/colors/colors.dart';

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Color bgWhite() {
  return Get.isDarkMode ? CColors.cardBgDark : Colors.white;
}

Color bgPrimaryShade() {
  return Get.isDarkMode ? CColors.backgroundDark : CColors.backgroundPrimary;
}

Color getDividerColor() {
  return Get.isDarkMode ? CColors.borderDark : CColors.borderLight;
}

Color bgCard() {
  return Get.isDarkMode ? CColors.cardBgDark : Colors.white;
}

Color getDefaultIconColor() {
  return Get.isDarkMode ? Colors.white : Colors.black;
}

String formatDate(DateTime date) {
  final formatter = DateFormat('E, MMM, y');
  return formatter.format(date);
}

Color getBaseColor() {
  return Get.isDarkMode
      ? Colors.grey[700]! // Dark mode
      : Colors.grey[300]!; // Light mode
}

Color getHighlightColor() {
  return Get.isDarkMode
      ? Colors.grey[600]! // Dark mode
      : Colors.grey[100]!; // Light mode
}
