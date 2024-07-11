import 'package:flutter/material.dart';

class TimeTableEntry {
  final String subject;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? teacher;
  final DateTime? date;

  TimeTableEntry({
    required this.subject,
    required this.startTime,
    required this.endTime,
    this.teacher,
    this.date,
  });
}
