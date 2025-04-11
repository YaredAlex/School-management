import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class CContainer extends StatelessWidget {
  const CContainer({super.key, required this.child, this.bgColor});
  final Color? bgColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CSizes.itemSpacing),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CSizes.mdRadius),
          color: Get.isDarkMode ? CColors.cardBgDark : bgColor ?? Colors.white),
      child: child,
    );
  }
}
