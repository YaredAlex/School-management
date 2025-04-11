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

Color getContainerBg() {
  return Get.isDarkMode ? CColors.cardBgDark : Colors.white;
}

Color getDividerColor() {
  return Get.isDarkMode ? CColors.borderDark : CColors.borderLight;
}

String formatDate(DateTime date) {
  final formatter = DateFormat('E, MMM, y');
  return formatter.format(date);
}
