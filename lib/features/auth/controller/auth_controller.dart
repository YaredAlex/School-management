import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/model/student.dart';
import 'package:school_managment/features/auth/model/user.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/routes/routes.dart';
import 'package:school_managment/util/services/api_controller.dart';

class AuthController extends GetxController {
  RxnString accessToken = RxnString();
  RxnString refreshToken = RxnString();
  RxBool isAuthenticated = false.obs;
  RxBool isLoading = false.obs;
  RxnString errorMessage = RxnString();
  final currentParent = Rxn<User>();
  final students = Rxn<List<StudentModel>>(null);
  final currentStudent = Rxn<StudentModel>();
  final isStudentInitialized = RxBool(false);
  @override
  void onInit() {
    super.onInit();
  }

  Future<dynamic> fetchUserProfile() async {
    try {
      isLoading.value = true;
      var response = await ApiService().get(
        CAPIEndPoint.profile,
      );
      if (response != null) {
        currentParent.value = User.fromJson(response);
      }
      return response;
    } catch (e) {
      showErrorPopup(e.toString());
      return e;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStudents() async {
    try {
      isLoading.value = true;
      var response = await ApiService().get(
        CAPIEndPoint.parentStudents,
      );
      if (response != null) {
        var result = response as List<dynamic>;
        debugPrint("students are $result");
        List<Map<String, dynamic>> data = result.cast<Map<String, dynamic>>();
        final allSibilings = <StudentModel>[];
        for (var s in data) {
          allSibilings.add(StudentModel.fromJson(s));
        }
        currentStudent.value =
            allSibilings.isNotEmpty ? allSibilings.first : null;
        isStudentInitialized.value =
            currentStudent.value == null ? false : true;
        students.value = allSibilings;

        // print("all student is $allSibilings");
      }
    } catch (e) {
      showErrorPopup(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearUser() {
    currentParent.value = null;
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      isLoading.value = true;
      await ApiService().removeToken();
      Get.offAllNamed(CRoutes.signin);
    } catch (e) {
      showErrorPopup(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Check login on app start
  Future<void> checkCredential() async {
    await fetchUserProfile();
    Get.offAllNamed(CRoutes.home);
  }

  // REFRESH TOKEN
  Future<bool> refreshAccessToken() async {
    if (refreshToken.value == null) return false;
    try {
      final response = await ApiService().post(
        "/api/user/refresh",
        data: {"refresh_token": refreshToken.value},
      );

      if (response != null && response["token"] != null) {
        ApiService().saveToken(response["token"], refreshToken.value ?? "");
        return true;
      }
    } catch (e) {
      debugPrint("Refresh token failed: $e");
    }

    logout();
    return false;
  }
}
