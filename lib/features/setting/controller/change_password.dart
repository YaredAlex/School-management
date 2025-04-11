import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isCurrentPasswordVisible = false.obs;
  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  void toggleCurrentPasswordVisibility() => isCurrentPasswordVisible.toggle();
  void toggleNewPasswordVisibility() => isNewPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  String? validatePassword(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your new password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        // Simulate API call
        await Future.delayed(Duration(seconds: 2));
        // Implement actual password change logic here
        // For example, call an API to update the password
        print('Changing password...');
        print('Current Password: ${currentPasswordController.text}');
        print('New Password: ${newPasswordController.text}');

        Get.snackbar('Success', 'Password changed successfully');
        Get.back(); // Return to previous screen
      } catch (e) {
        Get.snackbar('Error', 'Failed to change password: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
