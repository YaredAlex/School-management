import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/exti_warning.dart';
import 'package:school_managment/features/notifcation/view/notification.dart';
import 'package:school_managment/features/profile/view/profile.dart';
import 'package:school_managment/util/text/texts.dart';

class NavigationController extends GetxController {
  final List<Widget> bottomNavigationItems = [
    NavigationDestination(icon: Icon(Icons.home), label: CTexts.home),
    NavigationDestination(icon: Icon(Icons.person), label: CTexts.profile),
    NavigationDestination(
        icon: Icon(Icons.notifications), label: CTexts.notification),
  ];
  final List<Widget> screens = [
    const ExitWarning(),
    const ProfileScreen(),
    NotificationScreen(),
  ];
  RxInt currentScreen = 0.obs;

  void changeScreen(int screen) {
    currentScreen.value = screen;
  }
}
