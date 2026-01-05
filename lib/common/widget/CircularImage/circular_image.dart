import 'package:flutter/material.dart';
import 'package:school_managment/util/image_constant.dart';

class CCircleAvatar extends StatelessWidget {
  const CCircleAvatar(
      {super.key, this.radius = 30, this.imgUrl, this.defaultImage});
  final double radius;
  final String? imgUrl;
  final String? defaultImage;
  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (defaultImage != null) {
      imageProvider = AssetImage(defaultImage!);
    } else if (imgUrl != null) {
      imageProvider = NetworkImage(imgUrl!);
    } else {
      imageProvider = const NetworkImage(CImageConstant.userNetImg);
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: imageProvider,
    );
  }
}
