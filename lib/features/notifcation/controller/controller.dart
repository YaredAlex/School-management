import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RxList<Map<String, dynamic>> notifications =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    // Simulating API call or database fetch
    notifications.value = [
      {
        'id': '1',
        'title': 'Parent-Teacher Meeting',
        'message': 'Scheduled for next Friday at 3 PM.',
        'date': '2024-07-15',
        'type': 'event',
        'isRead': false,
      },
      {
        'id': '2',
        'title': 'Exam Schedule Released',
        'message': 'The final exam schedule has been published.',
        'date': '2024-07-10',
        'type': 'academic',
        'isRead': true,
      },
      {
        'id': '3',
        'title': 'School Closure',
        'message':
            'School will be closed tomorrow due to severe weather conditions.',
        'date': '2024-07-08',
        'type': 'alert',
        'isRead': false,
      },
      // Add more notifications as needed
    ];
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((note) => note['id'] == id);
    if (index != -1) {
      notifications[index]['isRead'] = true;
      notifications.refresh();
    }
  }
}
