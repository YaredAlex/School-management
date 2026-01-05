import 'package:intl/intl.dart';

class ChatModel {
  final String text;
  final bool isRead;
  final DateTime timestamp;
  final bool sentByUser;
  final int id;
  final String senderName;

  ChatModel({
    required this.text,
    required this.isRead,
    required this.timestamp,
    required this.sentByUser,
    required this.id,
    required this.senderName,
  });
  String get formattedTime {
    return DateFormat("yyyy-MM-dd  hh:mm a").format(timestamp);
  }

  factory ChatModel.fromJson(Map<String, dynamic> json, int senderId) {
    return ChatModel(
        text: json["text"],
        isRead: json["is_read"],
        timestamp: DateTime.parse(json["timestamp"]),
        sentByUser: json["sender_object_id"] == senderId,
        id: json['id'],
        senderName: json['sender_name']);
  }
}
