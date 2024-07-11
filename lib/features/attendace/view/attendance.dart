import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/attendace/controller/attendance_controller.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/text/texts.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});
  final controller = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? CColors.backgroundDark : CColors.backgroundPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CHeaderSection(
              height: CSizes.topBarHeight,
              childern: [
                CAppBar(
                  title: CTexts.attendance,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CTexts.absentDates,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(() => ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.absentDates.length,
                              itemBuilder: (context, index) {
                                final absentDate =
                                    controller.absentDates[index];
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
