import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

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
