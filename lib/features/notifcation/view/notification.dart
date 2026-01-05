import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/notifcation/controller/controller.dart';
import 'package:school_managment/features/notifcation/view/widget/notification_item.dart';
import 'package:school_managment/features/time_table/view/time_table_shimmer.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/sizes.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CHeaderSection(
            height: CSizes.topBarHeight,
            childern: [
              CAppBar(
                title: CTexts.notification,
                showLeading: false,
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
              child: RefreshIndicator(
                onRefresh: controller.onRefresh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Important Notification"),
                      const SizedBox(
                        height: CSizes.itemSpacing,
                      ),
                      Obx(
                        () => controller.isLoading.value
                            ? _buildLoadingNotification(context)
                            : controller.notifications.isEmpty
                                ? Container(
                                    height: 100,
                                    child: const Center(
                                        child: Text("No notifications")),
                                  )
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
                                          controller
                                              .markAsRead(notification.id);
                                          // You can add navigation or show a dialog here
                                          Get.dialog(
                                            AlertDialog(
                                              title: Text(notification.title),
                                              content: Text(
                                                  notification.description),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingNotification(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      shrinkWrap: true,
      itemBuilder: (context, index) => const TimeTableCardShimmer(),
    );
  }
}
