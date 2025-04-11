import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:shimmer/shimmer.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.courseName,
    required this.imgAsset,
    required this.courseId,
    required this.onTap,
  });
  final String courseName;
  final String imgAsset;
  final int courseId;
  final Function(int courseId) onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(courseId);
      },
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Get.isDarkMode ? CColors.cardBgDark : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CSizes.mdRadius),
          side: BorderSide(
              color: Get.isDarkMode ? CColors.borderDark : CColors.borderLight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //Image
              SizedBox(
                height: 90,
                child: Image.asset(
                  imgAsset,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(courseName)
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCardLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Get.isDarkMode ? CColors.cardBgDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CSizes.mdRadius),
        side: BorderSide(
            color: Get.isDarkMode ? CColors.borderDark : CColors.borderLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //Image
            SizedBox(
              height: 90,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SizedBox(
                height: 14,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
