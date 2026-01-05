import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/time_table/model/time_table_model.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/services/api_controller.dart';

class TimeTableController extends GetxController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isLoading = RxBool(false);

  void changeDate(int days) {
    selectedDate.value = selectedDate.value.add(Duration(days: days));
  }

  final RxMap<String, List<TimeTableEntry>> weeklyTimeTable =
      <String, List<TimeTableEntry>>{}.obs;
  AuthController authController = Get.find();
  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    fetchTimeTable();
  }

  Future<void> onRefresh() async {
    fetchTimeTable();
  }

  Future<void> fetchTimeTable() async {
    try {
      isLoading.value = true;
      var response = await ApiService().get(
        CAPIEndPoint.timetable(authController.currentStudent.value?.section),
      );
      response = (response as List<dynamic>).cast<Map<String, dynamic>>();
      weeklyTimeTable.value = {};
      for (var timetable in response) {
        if (weeklyTimeTable.containsKey(timetable['day'])) {
          weeklyTimeTable[timetable['day']]
              ?.add(TimeTableEntry.fromJson(timetable));
        } else {
          weeklyTimeTable[timetable['day']] = [
            TimeTableEntry.fromJson(timetable)
          ];
        }
      }
      debugPrint("$response");
      debugPrint("$weeklyTimeTable");
    } catch (e) {
      showErrorPopup("$e");
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
