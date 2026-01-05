import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'popup_message.dart';

class PopupService {
  PopupService._();

  static Future<bool?> show({
    required String title,
    String message = '',
    bool success = true,
    Duration duration = const Duration(seconds: 2),
    bool barrierDismissible = true,
    bool showCloseButton = false,
    VoidCallback? onDismiss,
  }) async {
    try {
      return await Get.dialog<bool>(
        PopupMessage(
          title: title,
          message: message,
          success: success,
          duration: duration,
          showCloseButton: showCloseButton,
          onDismiss: onDismiss,
        ),
        barrierDismissible: barrierDismissible,
        name: 'popup_message',
      );
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> showSuccess({
    required String title,
    String message = '',
    Duration duration = const Duration(seconds: 2),
    bool barrierDismissible = true,
    bool showCloseButton = true,
    VoidCallback? onDismiss,
  }) =>
      show(
        title: title,
        message: message,
        success: true,
        barrierDismissible: barrierDismissible,
        showCloseButton: showCloseButton,
        onDismiss: onDismiss,
      );

  static Future<bool?> showError({
    required String title,
    String message = '',
    Duration duration = const Duration(seconds: 2),
    bool barrierDismissible = true,
    bool showCloseButton = true,
    VoidCallback? onDismiss,
  }) =>
      show(
        title: title,
        message: message,
        success: false,
        barrierDismissible: barrierDismissible,
        showCloseButton: showCloseButton,
        onDismiss: onDismiss,
      );
}
