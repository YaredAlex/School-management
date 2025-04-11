import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/controller/api_controller.dart';

class AttendanceController extends GetxController {
  final RxList<Map<String, dynamic>> absentDates = <Map<String, dynamic>>[].obs;
  RxBool isLoading = RxBool(false);
  ApiController apiController = Get.find();
  UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchAbsentDates(userController.currentStudent.value?.id);
  }

  Future<void> onRefresh() async {
    fetchAbsentDates(userController.currentStudent.value?.id);
  }

  Future<void> fetchAbsentDates(int? id) async {
    if (id == null) {
      showErrorPopup("StudentId is required");
      return;
    }
    isLoading.value = true;
    try {
      final result = await apiController.request(
          endpoint: CAPIEndPoint.attendance(id), method: 'GET');
      debugPrint(result);
    } catch (e) {
      showErrorPopup(e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
    absentDates.value = [
      {'date': 'No record Found', 'reason': 'No absent'},
    ];
  }
}
