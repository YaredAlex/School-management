import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/course/controller/course_result_controller.dart';
import 'package:school_managment/features/course/view/widget/container_wrapper.dart';
import 'package:school_managment/features/course/view/widget/course_card.dart';
import 'package:school_managment/features/result/model/result_model.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/sizes.dart';

class CourseResultScreen extends StatelessWidget {
  CourseResultScreen({super.key}) {
    resultController = Get.find();
  }
  final double height = CSizes.topBarHeight;
  late CourseResultController resultController;
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
                  if (resultController.isLoading.value) {
                    return _buildLoadingResult(context);
                  }
                  if (results.isEmpty) {
                    return Center(
                      child: Text(
                        "No result found",
                        style: Theme.of(context).textTheme.titleMedium,
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

  Widget _buildLoadingResult(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth < 600 ? 1 : 2;
        int itemCount = 1;
        int rowCount = (itemCount / crossAxisCount).ceil();

        double aspectRatio = crossAxisCount == 1 ? 2.5 : 1.3;
        double spacing = 16.0;
        double itemHeight =
            (constraints.maxWidth / crossAxisCount) / aspectRatio;
        double totalSpacing = (rowCount - 1) * spacing;
        double gridHeight = (itemHeight * rowCount) + totalSpacing;

        return SizedBox(
          height: gridHeight,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return CourseCardLoading();
            },
          ),
        );
      },
    );
  }
}
