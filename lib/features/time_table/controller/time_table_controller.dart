import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/features/time_table/model/time_table_model.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/controller/api_controller.dart';

class TimeTableController extends GetxController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  void changeDate(int days) {
    selectedDate.value = selectedDate.value.add(Duration(days: days));
  }

  final RxMap<String, List<TimeTableEntry>> weeklyTimeTable =
      <String, List<TimeTableEntry>>{}.obs;
  UserController userController = Get.find();
  ApiController apiController = Get.find();
  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    weeklyTimeTable.value = {
      'Monday': [
        TimeTableEntry(
            subject: 'Math',
            startTime: const TimeOfDay(hour: 2, minute: 0),
            endTime: TimeOfDay(hour: 2, minute: 30),
            teacher: 'Dr. Yared'),
        TimeTableEntry(
            subject: 'Science',
            startTime: TimeOfDay(hour: 3, minute: 0),
            endTime: TimeOfDay(hour: 4, minute: 30),
            teacher: 'Prof. Dagi'),
      ],
      'Tuesday': [
        TimeTableEntry(
            subject: 'History',
            startTime: TimeOfDay(hour: 2, minute: 30),
            endTime: TimeOfDay(hour: 3, minute: 0)),
        TimeTableEntry(
            subject: 'English',
            startTime: TimeOfDay(hour: 4, minute: 30),
            endTime: TimeOfDay(hour: 5, minute: 0),
            teacher: 'Ms. Bee'),
      ],
      // Add entries for other days...
    };
  }

  Future<void> onRefresh() async {
    // fetchTimeTable();
  }

  Future<void> fetchTimeTable() async {
    try {
      final response = await apiController.request(
          endpoint: CAPIEndPoint.baseUrl, method: 'GET');
      debugPrint(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
