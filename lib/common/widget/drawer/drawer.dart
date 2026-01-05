import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/CircularImage/circular_image.dart';
import 'package:school_managment/common/widget/drawer/drawer_controller.dart';
import 'package:school_managment/common/widget/error/success_dialog.dart';
import 'package:school_managment/features/navigation/controller/navigation_controller.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/device/device.dart';
import 'package:school_managment/util/image_constant.dart';
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
        _buildSkeletonHeader(context),
        ...List.generate(5, (index) => _buildSkeletonListTile()),
      ],
    );
  }

  // Skeleton drawer header
  Widget _buildSkeletonHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
      height: 174,
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
                drawerController.currentStudent.value?.picture != null
                    ? CCircleAvatar(
                        radius: 40,
                        imgUrl: drawerController.currentStudent.value?.picture,
                      )
                    : drawerController.currentStudent.value?.gender == "Female"
                        ? const CCircleAvatar(
                            radius: 40,
                            defaultImage: CImageConstant.avatarF,
                          )
                        : const CCircleAvatar(
                            radius: 40,
                            defaultImage: CImageConstant.avatarM,
                          ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  drawerController.currentStudent.value?.fullName ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: Colors.white),
                ),
                Text(
                  "Class ${drawerController.currentStudent.value?.gradeName} | Section ${drawerController.currentStudent.value?.section_name}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: const Color.fromARGB(255, 223, 223, 223)),
                )
              ],
            ),
          ),
        ),
        Obx(() => Column(
              children: _buildStudentList(context),
            )),
        Divider(
          color: getDividerColor(),
        ),
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
            Get.toNamed(CRoutes.about);
          },
        ),
        ListTile(
          title: Text(CTexts.logout),
          leading: const Icon(Iconsax.logout),
          selected: drawerController.selectedIndex.value == 4,
          onTap: () {
            drawerController.logout(context);
          },
        ),
      ],
    );
  }

  List<Widget> _buildStudentList(BuildContext context) {
    final students = drawerController.students.value;
    final currentStudentId = drawerController.currentStudent.value?.id;

    if (students != null && students.isNotEmpty) {
      return List.generate(
        students.length,
        (index) {
          final student = students[index];
          final isActive = student.id == currentStudentId;

          return ListTile(
            leading: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                _getInitials(drawerController.students.value?[index].fullName),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            title: Text(student.fullName!),
            trailing: isActive
                ? const Text(
                    "Active",
                    style: TextStyle(
                      color: CColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
            selected: isActive,
            onTap: () {
              if (!isActive) {
                drawerController.changeAccount(index);
                SuccessDialog.show(
                  context,
                  message: "Account changed successfully!",
                  buttonText: "Done",
                );
              }
            },
          );
        },
      );
    }
    return [const Text("No student accounts available.")];
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return "?";
    final parts = name.trim().split(" ");
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
