import 'package:flutter/material.dart';
import 'package:school_managment/util/image_constant.dart';

class CCircleAvatar extends StatelessWidget {
  const CCircleAvatar({super.key, this.radius = 30, this.imgUrl});
  final double radius;
  final String? imgUrl;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imgUrl != null
          ? NetworkImage(imgUrl!)
          : const NetworkImage(CImageConstant.userNetImg),
    );
  }
}
