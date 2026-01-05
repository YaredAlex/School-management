class MessageHistory {
  final String otherType;
  final int otherId;
  final String? fullname;
  final String? picture;
  final String? role;
  final String lastMessage;
  final DateTime timestamp;
  final bool sentByUser;
  final int id;

  MessageHistory({
    required this.otherType,
    required this.otherId,
    this.fullname,
    this.picture,
    this.role,
    required this.lastMessage,
    required this.timestamp,
    required this.sentByUser,
    required this.id,
  });

  factory MessageHistory.fromJson(Map<String, dynamic> json) {
    return MessageHistory(
      otherType: json['other_type'],
      otherId: json['other_id'],
      fullname: json['fullname'],
      picture: json['picture'],
      role: json['role'],
      lastMessage: json['last_message'],
      timestamp: DateTime.parse(json['timestamp']),
      sentByUser: json['sent_by_user'],
      id: json['id'],
    );
  }
}
