import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/device/device.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:shimmer/shimmer.dart';

class CourseCard extends StatelessWidget {
  CourseCard({
    required this.courseId,
    required this.onTap,
    required this.courseName,
    required this.imgAsset,
    this.courseCode,
    this.creditHours,
    this.teacherName,
  });
  final int courseId;
  final Function onTap;
  final String courseName;
  final String imgAsset;
  final String? courseCode;
  final int? creditHours;
  final String? teacherName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(courseId),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? CColors.cardBgDark : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Colored left border
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(CSizes.lgSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              courseName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: CSizes.smSpace),
                            // Course code
                            if (courseCode != null)
                              Text(
                                'code: $courseCode',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              )
                          ],
                        ),
                        Image.asset(
                          imgAsset,
                          height: 54,
                        )
                      ],
                    ),
                    const SizedBox(height: CSizes.mdSpace),
                    // Bottom row with credits and teacher
                    Row(
                      children: [
                        // Credits with icon
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 18,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: CSizes.smSpace),
                            Text(
                              'Credits ${creditHours ?? 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (teacherName != null)
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 18,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                teacherName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCardLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? CColors.cardBgDark : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Colored left border
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Shimmer.fromColors(
                baseColor: getBaseColor(),
                highlightColor: getHighlightColor(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Course name and image placeholder
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Course name placeholder
                            Container(
                              width: 180,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(height: 8),
                            // Course code placeholder
                            Container(
                              width: 120,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                        // Image placeholder
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Bottom row placeholders
                    Row(
                      children: [
                        // Credits placeholder
                        Container(
                          width: 100,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Spacer(),
                        // Teacher name placeholder
                        Container(
                          width: 120,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
