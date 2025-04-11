import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/constants/colors/colors.dart';

class CHeaderSection extends StatelessWidget {
  const CHeaderSection({
    super.key,
    required this.height,
    required this.childern,
    this.curveRadius = 20,
    this.backgroundColor = CColors.primary,
  });

  final double height;
  final List<Widget> childern;
  final double curveRadius;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // clipper: CCustomShape(radius: curveRadius),
      child: Container(
        height: height,
        decoration: const BoxDecoration(color: CColors.primary),
        child: Stack(
          children: [
            Column(children: childern),
            //appBar,
            const Positioned(
                right: -90,
                top: -60,
                child: IgnorePointer(child: CircularContainer())),
            const Positioned(
                right: -90,
                top: 70,
                child: IgnorePointer(child: CircularContainer())),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? CColors.backgroundDark
                          : CColors.backgroundPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(curveRadius),
                        topRight: Radius.circular(curveRadius),
                      )),
                  height: 20,
                  width: double.infinity,
                ))
            //Title,
            //Search
          ],
        ),
      ),
    );
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.radius = 200,
    this.bgColor,
  });
  final double radius;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        color: bgColor != null
            ? bgColor
            : const Color.fromARGB(255, 255, 255, 255).withOpacity(0.05),
        borderRadius: BorderRadius.circular(500),
      ),
    );
  }
}
