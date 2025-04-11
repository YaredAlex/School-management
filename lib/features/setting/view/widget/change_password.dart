import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/setting/controller/change_password.dart';

class ChangePasswordPage extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());

  ChangePasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => TextFormField(
                    controller: controller.currentPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isCurrentPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.toggleCurrentPasswordVisibility,
                      ),
                    ),
                    obscureText: !controller.isCurrentPasswordVisible.value,
                    validator: (value) => controller.validatePassword(
                        value, 'Current password is required'),
                  )),
              const SizedBox(height: 16),
              Obx(() => TextFormField(
                    controller: controller.newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isNewPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.toggleNewPasswordVisibility,
                      ),
                    ),
                    obscureText: !controller.isNewPasswordVisible.value,
                    validator: (value) => controller.validatePassword(
                        value, 'New password is required'),
                  )),
              const SizedBox(height: 16),
              Obx(() => TextFormField(
                    controller: controller.confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm New Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    ),
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    validator: (value) =>
                        controller.validateConfirmPassword(value),
                  )),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.changePassword,
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('Change Password'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
