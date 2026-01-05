import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/result/model/result_model.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/services/api_controller.dart';

class ResultController extends GetxController {
  RxnString selectedResult = RxnString(null);
  RxInt selectedSemester = 0.obs;
  AuthController authController = Get.find();
  RxBool isLoading = RxBool(false);
  final RxList<SemesterResultModel> results = <SemesterResultModel>[].obs;

  //fetch Student course list
  void onInit() {
    super.onInit();
    fetchResultList(authController.currentStudent.value?.id);
  }

  Future<void> onRefresh() async {
    fetchResultList(authController.currentStudent.value?.id);
    if (selectedSemester.value > results.length) {
      selectedSemester.value = 0;
    }
  }

  void changeSemesterTab(int index) {
    selectedSemester.value = index;
  }

  Future<void> fetchResultList(int? studentId) async {
    if (studentId == null) {
      showErrorPopup("Studetn Id");
      return;
    }
    isLoading.value = true;
    try {
      final response = await ApiService().get(CAPIEndPoint.result(studentId));
      List<Map<String, dynamic>>? data =
          (response as List<dynamic>).cast<Map<String, dynamic>>();
      debugPrint("data $data");
      results.value = [];
      for (var sem in data) {
        results.add(SemesterResultModel.fromJson(sem));
      }
    } catch (e) {
      // showErrorPopup(e.toString());
      // debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
