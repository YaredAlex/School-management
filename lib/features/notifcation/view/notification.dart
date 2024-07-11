import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/notifcation/controller/controller.dart';
import 'package:school_managment/features/notifcation/view/widget/notification_item.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CHeaderSection(
              height: CSizes.topBarHeight,
              childern: [
                CAppBar(
                  title: "Notifications",
                  showLoading: false,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CColors.backgroundDark
                    : CColors.backgroundPrimary,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Important Notification"),
                    const SizedBox(
                      height: CSizes.itemSpacing,
                    ),
                    Obx(
                      () => controller.notifications.isEmpty
                          ? Center(child: Text("No notifications"))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.notifications.length,
                              itemBuilder: (context, index) {
                                final notification =
                                    controller.notifications[index];
                                return NotificationItem(
                                  notification: notification,
                                  onTap: () {
                                    controller.markAsRead(notification['id']);
                                    // You can add navigation or show a dialog here
                                    Get.dialog(
                                      AlertDialog(
                                        title: Text(notification['title']),
                                        content: Text(notification['message']),
                                        actions: [
                                          TextButton(
                                            child: Text('Close'),
                                            onPressed: () => Get.back(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
