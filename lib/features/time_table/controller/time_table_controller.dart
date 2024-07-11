import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/time_table/model/time_table_model.dart';

class TimeTableController extends GetxController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  void changeDate(int days) {
    selectedDate.value = selectedDate.value.add(Duration(days: days));
  }

  final RxMap<String, List<TimeTableEntry>> weeklyTimeTable =
      <String, List<TimeTableEntry>>{}.obs;

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
}
