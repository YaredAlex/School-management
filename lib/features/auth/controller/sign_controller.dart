import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/auth/model/user.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/routes/routes.dart';
import 'package:school_managment/util/services/api_controller.dart';

class SignInController extends GetxController {
  RxBool obscureText = true.obs;
  RxBool isAuthenticated = false.obs;
  RxBool isLoading = false.obs;
  RxnString errorMessage = RxnString();
  RxnString phoneError = RxnString();
  RxnString _phone = RxnString();
  RxnString _password = RxnString();
  String? get phone => _phone.value;
  String? get password => _password.value;
  set phone(String? value) => _phone.value = value;
  set password(String? value) => _password.value = value;
  AuthController authController = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  // LOGIN
  Future<void> login(String? phone, String? password) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final response = await ApiService().post(
        CAPIEndPoint.login,
        data: {
          "phone": "0${phone!.substring(4)}",
          "password": password,
        },
      );
      debugPrint("$response");
      String token = response["access"];
      String refresh = response["refresh"];
      ApiService().saveToken(token, refresh);
      // Set current user
      authController.currentParent.value = User.fromJson(response["user"]);
      Get.offAllNamed(CRoutes.home);
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint("Login Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
