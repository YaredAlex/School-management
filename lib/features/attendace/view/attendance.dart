import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/attendace/controller/attendance_controller.dart';
import 'package:school_managment/features/attendace/model/attendance_model.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/device/device.dart';
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
                    color: bgPrimaryShade(),
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
                        child: Obx(
                          () => ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: CSizes.defaultSpace),
                            shrinkWrap: true,
                            physics: attendanceController.isLoading.value
                                ? const NeverScrollableScrollPhysics()
                                : const AlwaysScrollableScrollPhysics(),
                            itemCount: attendanceController.isLoading.value
                                ? 3
                                : attendanceController.attendance.length,
                            itemBuilder: (context, index) {
                              if (attendanceController.isLoading.value) {
                                return _loadingCard();
                              }

                              // Get AttendanceModel
                              final AttendanceModel model =
                                  attendanceController.attendance[index];

                              return Card(
                                elevation: 0,
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: const Icon(Icons.calendar_today),
                                  title: Text(
                                    model.date != null
                                        ? "${model.date!.year}-${model.date!.month}-${model.date!.day}"
                                        : "Unknown Date",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Absent count: ${model.absentCount ?? 0}"),
                                      Text(
                                          "Absent %: ${model.absentPercentage ?? 0}%"),
                                      const SizedBox(height: 4),
                                      // if (model.absentRecords != null &&
                                      //     model.absentRecords!.isNotEmpty)
                                      //   Text(
                                      //     "Courses: ${model.absentRecords!.map((e) => e.course).join(', ')}",
                                      //   )
                                      // else
                                      //   const Text("No absent courses"),
                                    ],
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios,
                                      size: 16),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }

  Widget _loadingCard() {
    return Shimmer.fromColors(
      baseColor: getBaseColor(),
      highlightColor: getHighlightColor(),
      period: const Duration(milliseconds: 1500),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: bgWhite(),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          subtitle: Container(
            width: double.infinity,
            height: 14,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: bgWhite(),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          leading: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: bgWhite(),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
