import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/custom_tile/custom_tile.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/course/controller/course_result_controller.dart';
import 'package:school_managment/features/course/view/widget/container_wrapper.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class CourseResultScreen extends StatelessWidget {
  CourseResultScreen({super.key, required this.courseId});
  final double height = CSizes.topBarHeight;
  final int courseId;
  final controller = Get.put(CourseResultController());
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
              height: height,
              childern: [
                CAppBar(
                  showLoading: false,
                  title: "Course result",
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
                  //course result
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _buildCourseSelector(),
                        _buildSemesterSelector(),
                        CContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle('Daily Activities', context),
                              _buildDailyActivities(context: context),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CContainer(
                            bgColor: CColors.lightBlue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('Quizzes', context),
                                _buildQuizzes(),
                              ],
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        CContainer(
                            bgColor: CColors.lightPurple,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('Tests', context),
                                _buildTests(),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButton<String>(
        value: controller.selectedCourse.value,
        onChanged: (String? newValue) {
          if (newValue != null) controller.changeCourse(newValue);
        },
        items: controller.courses
            .map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
          return DropdownMenuItem<String>(
            value: value['course'],
            child: Text(value['course']),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSemesterSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => controller.changeSemester(1),
              child: Text('Semester 1'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextButton(
              onPressed: () => controller.changeSemester(2),
              child: Text('Semester 2'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildDailyActivities({required BuildContext context}) {
    final activities = controller.courseResults[controller.selectedCourse.value]
            ?['semester${controller.selectedSemester.value}']['dailyActivities']
        as List<dynamic>?;

    if (activities == null || activities.isEmpty) {
      return const Center(child: Text('No daily activities recorded'));
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return CustomListTile(
            title: Text(
              activity['activity'],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text('Date: ${activity['date']}'),
            trailing: Text('Score: ${activity['score']}'));
      },
    );
  }

  Widget _buildQuizzes() {
    final quizzes = controller.courseResults[controller.selectedCourse.value]
            ?['semester${controller.selectedSemester.value}']['quizzes']
        as List<dynamic>?;

    if (quizzes == null || quizzes.isEmpty) {
      return Center(child: Text('No quizzes recorded'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final quiz = quizzes[index];
        return CustomListTile(
          title: Text(
            quiz['topic'],
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text('Date: ${quiz['date']}'),
          trailing: Text('Score: ${quiz['score']}'),
        );
      },
    );
  }

  Widget _buildTests() {
    final tests = controller.courseResults[controller.selectedCourse.value]
            ?['semester${controller.selectedSemester.value}']['tests']
        as List<dynamic>?;

    if (tests == null || tests.isEmpty) {
      return Center(child: Text('No tests recorded'));
    }

    return Table(
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
      },
      children: [
        const TableRow(
          children: [
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('Topic', style: TextStyle(fontWeight: FontWeight.bold)),
            )),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('Score', style: TextStyle(fontWeight: FontWeight.bold)),
            )),
          ],
        ),
        ...tests
            .map((test) => TableRow(
                  children: [
                    TableCell(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(test['date']),
                    )),
                    TableCell(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(test['topic']),
                    )),
                    TableCell(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(test['score'].toString()),
                    )),
                  ],
                ))
            .toList(),
      ],
    );
  }
}
