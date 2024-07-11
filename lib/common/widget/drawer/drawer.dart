import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/CircularImage/circular_image.dart';
import 'package:school_managment/common/widget/drawer/drawer_controller.dart';
import 'package:school_managment/features/navigation/controller/navigation_controller.dart';
import 'package:school_managment/features/setting/view/setting.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/text/texts.dart';

class CDrawer extends StatelessWidget {
  final drawerController = Get.put(CDrawerController());
  final navController = Get.find<NavigationController>();
  CDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: CColors.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CCircleAvatar(
                    radius: 40,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    CTexts.userName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: Colors.white),
                  ),
                  Text(
                    CTexts.userSub,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: const Color.fromARGB(255, 223, 223, 223)),
                  )
                ],
              )),
          Obx(() => ListTile(
                title: Text(CTexts.addAccount),
                leading: const Icon(Iconsax.add),
                selected: drawerController.selectedIndex.value == 0,
                onTap: () {
                  drawerController.changeIndex(0);

                  // Get.to(() => const HomeScreen());
                },
              )),
          Obx(() => ListTile(
                title: Text(CTexts.profile),
                leading: const Icon(Iconsax.user),
                selected: drawerController.selectedIndex.value == 1,
                onTap: () {
                  drawerController.changeIndex(1);
                  Get.back();
                  navController.changeScreen(1);
                },
              )),
          Obx(() => ListTile(
                title: Text(CTexts.examResult),
                leading: const Icon(Iconsax.book),
                selected: drawerController.selectedIndex.value == 2,
                onTap: () {
                  drawerController.changeIndex(2);
                  Get.back();
                  // Get.to(() => SettingsPage());
                },
              )),
          Obx(() => ListTile(
                title: Text(CTexts.setting),
                leading: const Icon(Iconsax.setting),
                selected: drawerController.selectedIndex.value == 3,
                onTap: () {
                  drawerController.changeIndex(2);
                  Get.back();
                  Get.to(() => SettingsPage());
                },
              )),
          Obx(() => ListTile(
                title: Text(CTexts.about),
                leading: const Icon(Iconsax.support),
                selected: drawerController.selectedIndex.value == 4,
                onTap: () {
                  drawerController.changeIndex(2);
                  Get.back();
                  // Get.to(() => SettingsPage());
                },
              )),
        ],
      ),
    );
  }
}
