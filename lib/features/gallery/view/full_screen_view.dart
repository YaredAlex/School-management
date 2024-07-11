import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImageView extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  FullScreenImageView({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Get.back(),
        child: PageView.builder(
          itemCount: images.length,
          controller: PageController(initialPage: initialIndex),
          itemBuilder: (context, index) {
            return InteractiveViewer(
              child: Image.network(
                images[index],
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}
