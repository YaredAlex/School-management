import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/popups/popup_service.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/util/services/api_controller.dart';

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
  AuthController authController = Get.find();

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
      debugPrint("id of user ${authController.currentParent.value?.id}");
      try {
        final response = await ApiService().post(
            "/api/user/${authController.currentParent.value?.id}/change-password/",
            data: {
              "new_password": newPasswordController.text.toString(),
              "current_password": currentPasswordController.text.toString(),
            });

        await PopupService.showSuccess(
            title: "Sucesss",
            message: "Password changed succesfully",
            onDismiss: () {});
        Get.back();
      } catch (e) {
        PopupService.showError(title: "Failed", message: "$e");
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
