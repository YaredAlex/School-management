import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/drawer/drawer.dart';
import 'package:school_managment/features/navigation/controller/navigation_controller.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});
  final navigationController = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CDrawer(
        isLoading: false,
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          elevation: 0,
          destinations: navigationController.bottomNavigationItems,
          selectedIndex: navigationController.currentScreen.value,
          onDestinationSelected: navigationController.changeScreen,
        ),
      ),
      body: Obx(() => navigationController
          .screens[navigationController.currentScreen.value]),
    );
  }
}
