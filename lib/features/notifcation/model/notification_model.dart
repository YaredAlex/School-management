import 'package:intl/intl.dart';

class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String date;
  final String type; // "announcement" or "event"
  final DateTime createdAt;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    var date = json['date'] != null
        ? DateFormat('MMM dd, yyyy HH:mm a')
            .format(DateTime.parse(json['date']))
        : "";
    return NotificationModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: date,
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'type': type,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
