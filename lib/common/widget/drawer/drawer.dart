import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/CircularImage/circular_image.dart';
import 'package:school_managment/common/widget/drawer/drawer_controller.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/navigation/controller/navigation_controller.dart';
import 'package:school_managment/features/setting/view/setting.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/routes/routes.dart';
import 'package:shimmer/shimmer.dart'; // Add this package

class CDrawer extends StatelessWidget {
  final drawerController = Get.put(CDrawerController());
  final navController = Get.find<NavigationController>();

  // Add isLoading parameter to control when to show skeleton
  final bool isLoading;

  CDrawer({super.key, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: isLoading
          ? _buildLoadingDrawer(context)
          : _buildLoadedDrawer(context),
    );
  }

  // Skeleton loading drawer
  Widget _buildLoadingDrawer(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        // Skeleton drawer header
        _buildSkeletonHeader(context),

        // Skeleton menu items
        ...List.generate(5, (index) => _buildSkeletonListTile()),
      ],
    );
  }

  // Skeleton drawer header
  Widget _buildSkeletonHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
      height: 174, // Same height as DrawerHeader
      decoration: const BoxDecoration(
        color: CColors.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skeleton avatar
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.white.withOpacity(0.8),
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Skeleton username
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.white.withOpacity(0.8),
            child: Container(
              height: 16,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Skeleton user subtitle
          Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.white.withOpacity(0.8),
            child: Container(
              height: 16,
              width: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Skeleton list tile
  Widget _buildSkeletonListTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          // Icon placeholder
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 32),

          // Title placeholder
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Original drawer with loaded content
  Widget _buildLoadedDrawer(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Obx(
          () => DrawerHeader(
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
                  drawerController.currentStudent.value?.name ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: Colors.white),
                ),
                Text(
                  "Class ${drawerController.currentStudent.value?.classModel.className} | Section ${drawerController.currentStudent.value?.classModel.section}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: const Color.fromARGB(255, 223, 223, 223)),
                )
              ],
            ),
          ),
        ),
        ..._buildStudentList(),
        Obx(
          () => ListTile(
            title: Text(CTexts.profile),
            leading: const Icon(Iconsax.user),
            selected: drawerController.selectedIndex.value == 1,
            onTap: () {
              drawerController.changeRoute(CRoutes.profile);
            },
          ),
        ),
        ListTile(
          title: Text(CTexts.examResult),
          leading: const Icon(Iconsax.book),
          selected: drawerController.selectedIndex.value == 2,
          onTap: () {
            drawerController.changeRoute(CRoutes.courses);
            Get.back();
            // Get.to(() => SettingsPage());
          },
        ),
        ListTile(
          title: Text(CTexts.setting),
          leading: const Icon(Iconsax.setting),
          selected: drawerController.selectedIndex.value == 3,
          onTap: () {
            drawerController.changeRoute(CRoutes.setting);
          },
        ),
        ListTile(
          title: Text(CTexts.about),
          leading: const Icon(Iconsax.support),
          selected: drawerController.selectedIndex.value == 4,
          onTap: () {
            Get.snackbar("TODO", "route to about");
          },
        ),
        ListTile(
          title: Text(CTexts.login),
          leading: const Icon(Iconsax.logout),
          selected: drawerController.selectedIndex.value == 4,
          onTap: () {
            drawerController.logout(context);
          },
        ),
      ],
    );
  }

  List<Widget> _buildStudentList() {
    if (drawerController.students.value != null) {
      return List.generate(
        drawerController.students.value?.length ?? 1,
        (index) => ListTile(
          title: Text(drawerController.students.value?[index].name ?? "?"),
          leading: const Icon(Iconsax.tick_circle),
          selected: drawerController.selectedIndex.value == 0,
          onTap: () {
            if (drawerController.currentStudent.value?.id !=
                drawerController.students.value?[index].id) {
              drawerController.changeAccount(index);
              showSuccessPopup(
                  "Account changed to ${drawerController.students.value?[index].name}");
            }
          },
        ),
      );
    }
    return [
      ListTile(
        title: Text(CTexts.addAccount),
        leading: const Icon(Iconsax.add),
        selected: drawerController.selectedIndex.value == 0,
        onTap: () {
          Get.snackbar("TODO", "show add account ");
        },
      ),
    ];
  }
}
