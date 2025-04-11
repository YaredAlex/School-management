import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/home/view/home.dart';

class ExitWarning extends StatelessWidget {
  ExitWarning({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final result = await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Yes'),
              ),
            ],
          ),
          barrierDismissible: true,
        );
        if (result ?? false) {
          // If user confirms exit, close the app
          if (Platform.isAndroid) {
            await SystemNavigator.pop();
          }
        }
      },
      child: child,
    );
  }
}
