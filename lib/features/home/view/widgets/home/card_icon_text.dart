import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class CardIconText extends StatelessWidget {
  const CardIconText({
    super.key,
    this.onClick,
    required this.backgroundColor,
    required this.assetImage,
    required this.title,
  });
  final VoidCallback? onClick;
  final Color backgroundColor;
  final String assetImage;
  final String title;
  final double iconSize = 50;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.transparent : backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border:
                Get.isDarkMode ? Border.all(color: CColors.borderDark) : null),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            SizedBox(
              height: iconSize,
              width: iconSize,
              child: Image.asset(assetImage),
            ),
            const SizedBox(
              height: CSizes.mdSpace,
            ),
            //text
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!,
            )
          ],
        ),
      ),
    );
  }
}
