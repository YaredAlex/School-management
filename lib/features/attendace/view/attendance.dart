import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/attendace/controller/attendance_controller.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:shimmer/shimmer.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});
  AttendanceController attendanceController = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Get.isDarkMode ? CColors.backgroundDark : CColors.backgroundPrimary,
        body: Column(
          children: [
            CHeaderSection(
              height: CSizes.topBarHeight,
              childern: [
                CAppBar(
                  title: CTexts.attendance,
                  showLeading: false,
                ),
              ],
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? CColors.backgroundDark
                        : CColors.backgroundPrimary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: CSizes.defaultSpace),
                        child: Text(
                          CTexts.absentDates,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RefreshIndicator(
                        onRefresh: attendanceController.onRefresh,
                        child: Obx(() => ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: CSizes.defaultSpace),
                              shrinkWrap: true,
                              physics: attendanceController.isLoading.value
                                  ? const NeverScrollableScrollPhysics()
                                  : const AlwaysScrollableScrollPhysics(),
                              itemCount: attendanceController.isLoading.value
                                  ? 3
                                  : attendanceController.absentDates.length,
                              itemBuilder: (context, index) {
                                if (attendanceController.isLoading.value) {
                                  return _loadingCard();
                                }
                                final absentDate =
                                    attendanceController.absentDates[index];
                                return Card(
                                  elevation: 0,
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    title: Text(absentDate['date']),
                                    subtitle: Text(absentDate['reason']),
                                    leading: Icon(Icons.calendar_today),
                                  ),
                                );
                              },
                            )),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }

  Widget _loadingCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1500),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          subtitle: Container(
            width: double.infinity,
            height: 14,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          leading: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
