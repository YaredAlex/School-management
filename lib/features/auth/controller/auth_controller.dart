import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/features/auth/model/user.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/controller/api_controller.dart';
import 'package:school_managment/util/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final ApiController apiController = Get.find<ApiController>();
  final UserController userController = Get.find<UserController>();
  RxnString accessToken = RxnString();
  RxnString refreshToken = RxnString();
  RxBool obscureText = RxBool(true);
  RxnString _phone = RxnString();
  RxnString _password = RxnString();
  RxBool isAuthenticated = false.obs;
  RxBool isLoading = false.obs;
  RxnString errorMessage = RxnString();

  String? get phone => _phone.value;
  String? get password => _password.value;
  set phone(String? value) {
    _phone.value = value;
  }

  set password(String? value) {
    _password.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    _loadTokens();
  }

  // Load JWT tokens from local storage
  Future<void> _loadTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken.value = prefs.getString("token");
    refreshToken.value = prefs.getString("refresh_token");
    isAuthenticated.value = accessToken.value != null;
    // if (isAuthenticated.value) Get.offAllNamed(CRoutes.home);
  }

  // Save tokens after login or refresh
  Future<void> _saveTokens(
      String newAccessToken, String newRefreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newAccessToken.isNotEmpty) {
      await prefs.setString("token", newAccessToken);
      accessToken.value = newAccessToken;
      isAuthenticated.value = true;
    }
    if (newRefreshToken.isNotEmpty) {
      await prefs.setString("refresh_token", newRefreshToken);
      refreshToken.value = newRefreshToken;
    }
  }

  // Remove tokens on logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await apiController.request(
        endpoint: CAPIEndPoint.logout, method: "POST");
    await prefs.remove("token");
    await prefs.remove("refresh_token");
    accessToken.value = "";
    refreshToken.value = "";
    isAuthenticated.value = false;
    Get.offAllNamed(CRoutes.signin);
  }

  // Login function
  Future<void> login(String? phone, String? password) async {
    isLoading.value = true;
    errorMessage.value = null;
    debugPrint('$phone');
    try {
      final response = await apiController.request(
        endpoint: CAPIEndPoint.login,
        method: "POST",
        data: {
          "phone_number": phone!.substring(4),
          "password": password,
        },
        useToken: false,
      );
      // success logic
      accessToken.value = response["token"] as String?;
      //bind token to apirequests
      apiController.bindAccessToken(accessToken);
      _saveTokens(accessToken.value ?? "", response['refresh_token'] ?? "");
      userController.currentParent.value = User.fromJson(response['user']);
      Get.offAllNamed(CRoutes.home);
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error logging in $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkCredential() async {
    try {
      await _loadTokens();
      if (accessToken.value != null) {
        apiController.bindAccessToken(accessToken);
        await userController.fetchUserProfile();
        //if success full fetching parent/userprofile goto home
        Get.offAllNamed(CRoutes.home);
      } else {
        return Get.offAllNamed(CRoutes.signin);
      }
    } catch (e) {
      if (e.toString() == 'User not authenticated') {
        return Get.offAllNamed(CRoutes.signin);
      }
      showErrorPopup(e.toString());
    }
  }

  // Refresh token method
  Future<bool> refreshAccessToken() async {
    if (refreshToken.value != null) return false;
    var response = await apiController.request(
      endpoint: "/auth/refresh",
      method: "POST",
      data: {"refresh_token": refreshToken.value},
    );

    if (response != null && response["token"] != null) {
      await _saveTokens(response["token"], refreshToken.value ?? "");
      return true;
    } else {
      logout();
      return false;
    }
  }
}
