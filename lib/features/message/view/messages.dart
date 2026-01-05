import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/message/controller/message_controller.dart';
import 'package:school_managment/features/message/view/chat_page.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:intl/intl.dart';

class MessageHistoryPage extends StatelessWidget {
  final String? userType;
  final int? userId;

  MessageHistoryPage({
    super.key,
    this.userType,
    this.userId,
  });

  final MessageController messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    // Initialize controller values
    messageController.init(userType, userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: RefreshIndicator(
        onRefresh: messageController.fetchHistory,
        child: Obx(() {
          if (messageController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = messageController.messageHistory;

          if (chats.isEmpty) {
            return const Center(child: Text("No conversations yet."));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            itemCount: chats.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final chat = chats[index];

              return ListTile(
                tileColor:
                    Get.isDarkMode ? CColors.backgroundDark : Colors.white,
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      chat.picture != null ? NetworkImage(chat.picture!) : null,
                  child: chat.picture == null ? const Icon(Icons.person) : null,
                ),
                title: Text(
                  chat.fullname ?? "Unknown User",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  chat.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  _formatTime(chat.timestamp),
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () {
                  Get.to(() => ChatPage(
                        otherType: chat.otherType,
                        otherId: chat.otherId,
                        fullname: chat.fullname,
                        picture: chat.picture,
                      ));
                },
              );
            },
          );
        }),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();

    // Normalize date-only comparison
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    final diffDays = today.difference(messageDate).inDays;

    // Format time for "Today"
    final timeOnly = DateFormat('HH:mm').format(time);

    if (diffDays == 0) {
      // Today
      return timeOnly;
    } else if (diffDays == 1) {
      // Yesterday
      return "Yesterday";
    } else if (diffDays < 7) {
      // Within the last 7 days → Weekday name
      return DateFormat('EEEE').format(time); // Monday, Tuesday...
    } else if (time.year == now.year) {
      // Same year → MMM d
      return DateFormat('MMM d').format(time); // Nov 27
    } else {
      // Different year → MMM d, yyyy
      return DateFormat('MMM d, yyyy').format(time);
    }
  }
}
