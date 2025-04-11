import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/course/controller/course_controller.dart';
import 'package:school_managment/features/course/view/widget/course_card.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/image_constant.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/constants/text/texts.dart';

class CourseScreen extends StatelessWidget {
  CourseScreen({super.key});
  final double height = 160;
  final courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CHeaderSection(
            height: height,
            childern: [
              CAppBar(
                showLeading: false,
                title: CTexts.course,
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 24,
                    right: 24,
                  ),
                  child: TextField(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(CSizes.mdRadius),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: const Icon(
                          Iconsax.search_normal_1,
                          color: Colors.white,
                        ),
                        hintText: CTexts.search,
                        fillColor: Colors.white.withOpacity(0.2),
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.8)),
                        filled: true),
                  )),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? CColors.backgroundDark
                  : CColors.backgroundPrimary,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
              child: RefreshIndicator(
                onRefresh: courseController.onRefresh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Obx(
                    () => courseController.isLoading.value
                        ? _buildLoadingCourse(context)
                        : _buildCourseCard(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        int itemCount = courseController.courses.length;
        int rowCount = (itemCount / crossAxisCount).ceil();

        // Calculate the height of the grid
        double aspectRatio = 1.0; // Assuming square images
        double spacing = 16.0; // This should match your gridDelegate's spacing
        double itemHeight =
            (constraints.maxWidth / crossAxisCount) * aspectRatio;
        double totalSpacing = (rowCount - 1) * spacing;
        double gridHeight = (itemHeight * rowCount) + totalSpacing;

        return GridView.builder(
          padding: EdgeInsets.zero,
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
            return CourseCard(
              courseId: courseController.courses[index].id,
              onTap: (courseId) => courseController.toCourseResult(courseId),
              courseName: '${courseController.courses[index].courseName}',
              imgAsset: courseController.getCourseAssetImage(
                  courseController.courses[index].imgUlr ??
                      CImageConstant.courseIcon),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingCourse(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        int itemCount = 4;
        int rowCount = (itemCount / crossAxisCount).ceil();

        // Calculate the height of the grid
        double aspectRatio = 1.0; // Assuming square images
        double spacing = 16.0; // This should match your gridDelegate's spacing
        double itemHeight =
            (constraints.maxWidth / crossAxisCount) * aspectRatio;
        double totalSpacing = (rowCount - 1) * spacing;
        double gridHeight = (itemHeight * rowCount) + totalSpacing;

        return SizedBox(
          height: gridHeight,
          child: GridView.builder(
            padding: EdgeInsets.zero,
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
