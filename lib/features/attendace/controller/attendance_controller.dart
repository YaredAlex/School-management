import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/attendace/model/attendance_model.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/services/api_controller.dart';

class AttendanceController extends GetxController {
  RxList<AttendanceModel> attendance = <AttendanceModel>[].obs;
  RxBool isLoading = RxBool(false);
  AuthController authController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchAbsentDates(authController.currentStudent.value?.id);
  }

  Future<void> onRefresh() async {
    fetchAbsentDates(authController.currentStudent.value?.id);
  }

  Future<void> fetchAbsentDates(int? id) async {
    if (id == null) {
      showErrorPopup("StudentId is required");
      return;
    }
    isLoading.value = true;
    try {
      final result = await ApiService().get(CAPIEndPoint.attendance(id));
      debugPrint("$result");
      List<Map<String, dynamic>>? data =
          (result as List<dynamic>).cast<Map<String, dynamic>>();
      attendance.value = [];
      for (var a in data) {
        attendance.add(AttendanceModel.fromJson(a));
      }
    } catch (e) {
      showErrorPopup(e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
