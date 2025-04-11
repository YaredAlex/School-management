import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/exti_warning.dart';
import 'package:school_managment/features/course/view/course.dart';
import 'package:school_managment/features/home/view/home.dart';
import 'package:school_managment/features/notifcation/view/notification.dart';
import 'package:school_managment/util/constants/text/texts.dart';

class NavigationController extends GetxController {
  final List<Widget> bottomNavigationItems = [
    NavigationDestination(icon: const Icon(Iconsax.home), label: CTexts.home),
    NavigationDestination(
        icon: const Icon(Iconsax.ranking_1), label: CTexts.gradeReport),
    NavigationDestination(
        icon: const Icon(Iconsax.notification), label: CTexts.notification),
  ];
  final List<Widget> screens = [
    ExitWarning(child: HomeScreen()),
    ExitWarning(child: HomeScreen()),
    ExitWarning(child: NotificationScreen()),
  ];
  RxInt currentScreen = 0.obs;

  void changeScreen(int screen) {
    currentScreen.value = screen;
  }
}
