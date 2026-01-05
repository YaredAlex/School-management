import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/common/widget/popups/popup_service.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/services/api_controller.dart';

class ForgetPasswordCtrl extends GetxController {
  RxBool isLoading = false.obs;
  RxnString errorMessage = RxnString();
  RxnString emailError = RxnString();
  RxnString _email = RxnString();
  String? get email => _email.value;
  set email(String? value) => _email.value = value;

  Future<void> resetPassword(String? email) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final response = (await ApiService().post(
        CAPIEndPoint.resetPassword,
        data: {
          "email": email,
        },
      )) as Map<String, dynamic>;
      debugPrint("$response");
      PopupService.showSuccess(
          title: "Success", message: "${response['detail']}");
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint("Reset Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
