import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/message/controller/chat_controller.dart';

class ChatPage extends StatelessWidget {
  final String otherType;
  final int otherId;
  final String? fullname;
  final String? picture;

  ChatPage({
    super.key,
    required this.otherType,
    required this.otherId,
    this.fullname,
    this.picture,
  });

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(
      ChatController(
        otherType: otherType,
        otherId: otherId,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: picture != null ? NetworkImage(picture!) : null,
              child: picture == null ? const Icon(Icons.person) : null,
            ),
            const SizedBox(width: 10),
            Text(fullname ?? "Chat"),
          ],
        ),
      ),
      body: Column(
        children: [
          // ----------- MESSAGE LIST -----------
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: controller.messages.length,
                itemBuilder: (_, index) {
                  final msg = controller.messages[index];

                  final isMe = msg.sentByUser;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.text,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            "${msg.formattedTime} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 12,
                                    color:
                                        isMe ? Colors.white : Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // ----------- MESSAGE INPUT BOX -----------
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Message...",
                      hintStyle: TextStyle(
                        color: Get.isDarkMode
                            ? Colors.grey.shade500
                            : Colors.grey.shade600,
                      ),
                      filled: true,
                      fillColor:
                          Get.isDarkMode ? Colors.grey.shade800 : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                CircleAvatar(
                  backgroundColor:
                      Get.isDarkMode ? Colors.blueGrey : Colors.blue,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Get.isDarkMode ? Colors.white : Colors.white,
                    ),
                    onPressed: controller.sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
