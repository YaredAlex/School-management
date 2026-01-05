import 'package:flutter/material.dart';

class TimeTableEntry {
  final String subject;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? instructor;
  final String day;

  TimeTableEntry({
    required this.subject,
    required this.startTime,
    required this.day,
    required this.endTime,
    this.instructor,
  });

  factory TimeTableEntry.fromJson(Map<String, dynamic> json) {
    debugPrint("json $json");
    var startTime = json['time_slot']?['start_time'] as String;
    var endTime = json['time_slot']?['end_time'] as String;
    return TimeTableEntry(
      subject: json['course_name'],
      startTime: TimeOfDay(
          hour: int.parse(startTime.split(":")[0]),
          minute: int.parse(startTime.split(":")[1])),
      endTime: TimeOfDay(
          hour: int.parse(endTime.split(":")[0]),
          minute: int.parse(endTime.split(":")[1])),
      day: json['day'],
    );
  }
}
