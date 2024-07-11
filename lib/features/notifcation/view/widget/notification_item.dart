import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final Map<String, dynamic> notification;
  final Function onTap;

  NotificationItem({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        leading: Icon(
          _getIconForType(notification['type']),
          color: _getColorForType(notification['type']),
        ),
        title: Text(
          notification['title'],
          style: TextStyle(
            fontWeight:
                notification['isRead'] ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(notification['message']),
            SizedBox(height: 4),
            Text(
              'Date: ${notification['date']}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: notification['isRead']
            ? null
            : Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
        onTap: () => onTap(),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'event':
        return Icons.event;
      case 'academic':
        return Icons.school;
      case 'alert':
        return Icons.warning;
      default:
        return Icons.notifications;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'event':
        return Colors.green;
      case 'academic':
        return Colors.blue;
      case 'alert':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
