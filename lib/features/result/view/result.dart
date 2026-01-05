import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/course/view/widget/container_wrapper.dart';
import 'package:school_managment/features/result/controller/result_controller.dart';
import 'package:school_managment/features/result/model/result_model.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/sizes.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key});
  final double height = CSizes.topBarHeight;
  final ResultController resultController = Get.put(ResultController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? CColors.backgroundDark : CColors.backgroundPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CHeaderSection(
            height: height,
            childern: [
              CAppBar(
                showLeading: false,
                title: CTexts.examResult,
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? CColors.backgroundDark
                  : CColors.backgroundPrimary,
            ),
            child: RefreshIndicator(
              onRefresh: resultController.onRefresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Obx(() {
                  final results = resultController.results;

                  if (results.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          "No result found",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------------- SEMESTER SELECTOR ----------------
                      _buildSemesterSelector(results),

                      const SizedBox(height: 16),

                      // ---------------- COURSE CARDS ----------------
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: CSizes.defaultSpace),
                        child: _buildCourseCards(context),
                      )
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  // ---------------- SEMESTER TABS ----------------
  Widget _buildSemesterSelector(List<SemesterResultModel> semesters) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: semesters.asMap().entries.map((entry) {
            final index = entry.key;
            final sem = entry.value;

            final isSelected = resultController.selectedSemester.value == index;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                      isSelected ? CColors.primary : Colors.transparent,
                  foregroundColor: isSelected ? Colors.white : Colors.black54,
                ),
                onPressed: () => resultController.changeSemesterTab(index),
                child: Text("${sem.semester} ${sem.year}"),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---------------- COURSE CARDS ----------------
  Widget _buildCourseCards(BuildContext context) {
    final selected =
        resultController.results[resultController.selectedSemester.value];

    if (selected.records.isEmpty) {
      return Center(child: Text("No result found"));
    }

    return Column(
      children: selected.records.map((course) {
        return CContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subject Title
              Text(
                "${course.course}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),

              // Assessment Table
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                },
                children: [
                  // Header Row
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Assessment",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Score",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

                  // Data Rows
                  ...course.results.map((r) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("${r.assessmentType}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(r.score?.toString() ?? "-"),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
