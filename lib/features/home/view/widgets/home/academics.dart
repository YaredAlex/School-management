import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/course/view/course.dart';
import 'package:school_managment/features/home/view/widgets/home/card_icon_text.dart';
import 'package:school_managment/features/library/view/library.dart';
import 'package:school_managment/features/time_table/view/time_table.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/image_constant.dart';
import 'package:school_managment/util/routes/routes.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/constants/text/texts.dart';

class Academics extends StatelessWidget {
  const Academics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CTexts.titleAcademics,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: CSizes.itemSpacing,
          ),
          SizedBox(
            height: 216,
            child: GridView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount: 2,
                  mainAxisExtent: 100),
              children: [
                CardIconText(
                  assetImage: CImageConstant.courseResult,
                  backgroundColor: CColors.lightBlue,
                  title: CTexts.courseResult,
                  onClick: () {
                    Get.to(() => CourseScreen());
                  },
                ),
                CardIconText(
                  assetImage: CImageConstant.attendance,
                  backgroundColor: CColors.lightRed,
                  title: CTexts.attendance,
                  onClick: () {
                    Get.toNamed(CRoutes.attendance);
                  },
                ),
                CardIconText(
                  assetImage: CImageConstant.timeTable,
                  backgroundColor: CColors.dustStorm,
                  title: CTexts.timeTable,
                  onClick: () {
                    Get.to(() => TimeTableScreen());
                  },
                ),
                CardIconText(
                  assetImage: CImageConstant.books,
                  backgroundColor: CColors.lightPurple,
                  title: CTexts.library,
                  onClick: () {
                    Get.to(() => LibraryScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
