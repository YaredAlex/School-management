import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorPopup(String message) {
  Get.snackbar(
    "Error",
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red.shade600,
    colorText: Colors.white,
    icon: const Icon(Icons.error_outline, color: Colors.white),
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showSuccessPopup(String message) {
  Get.snackbar(
    "Success",
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Color.fromARGB(255, 176, 248, 195),
    colorText: Color.fromARGB(221, 0, 155, 67),
    icon: const Icon(Icons.error_outline, color: Colors.grey),
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
  );
}
