import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/message/model/chat_model.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/notification/notification_service.dart';
import 'package:school_managment/util/services/api_controller.dart';

class ChatController extends GetxController {
  final String otherType;
  final int otherId;

  late String userType;
  late int? userId;

  RxBool isLoading = false.obs;
  RxList<ChatModel> messages = <ChatModel>[].obs;

  final textController = TextEditingController();
  final scrollController = ScrollController();
  AuthController authController = Get.find();

  Timer? _pollingTimer;
  bool isChatPageOpen = false; // Track if user is in chat page

  ChatController({
    required this.otherType,
    required this.otherId,
  }) {
    userId = authController.currentStudent.value?.id;
    userType = "student";
  }

  @override
  void onInit() {
    super.onInit();

    // Mark chat page as open
    isChatPageOpen = true;

    // Initial load
    loadConversation();

    // Start polling every 2 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      fetchNewMessages();
    });
  }

  @override
  void onClose() {
    isChatPageOpen = false;
    _pollingTimer?.cancel();
    super.onClose();
  }

  /// Loads entire conversation on first load
  Future<void> loadConversation() async {
    try {
      isLoading.value = true;
      final res = await ApiService().get(CAPIEndPoint.chatApi(
        userId: userId,
        userType: userType,
        otherId: otherId,
        otherType: otherType,
      ));

      messages.assignAll(
        (res as List).map((e) => ChatModel.fromJson(e, userId!)).toList(),
      );
      _scrollToBottom();
    } catch (e) {
      debugPrint("error $e");
      showErrorPopup(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch only new messages every 2 seconds
  Future<void> fetchNewMessages() async {
    if (messages.isEmpty) return loadConversation();

    try {
      final lastMessage = messages.last;
      final lastId = lastMessage.id;

      final res = await ApiService().get(
        "${CAPIEndPoint.newChatApi(
          userId: userId,
          userType: userType,
          otherId: otherId,
          otherType: otherType,
        )}&after_id=$lastId",
      );

      final List<ChatModel> newMessages =
          (res as List).map((e) => ChatModel.fromJson(e, userId!)).toList();

      if (newMessages.isNotEmpty) {
        messages.addAll(newMessages);

        // Show notification ONLY when user is NOT on chat
        if (!isChatPageOpen) {
          _showNewMessageNotification(newMessages.last);
        }

        _scrollToBottom();
      }
    } catch (e) {
      print("Polling error: $e");
    }
  }

  /// Send message normally
  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    textController.clear();

    try {
      final res = await ApiService().post(
        CAPIEndPoint.sendChat(),
        data: {
          "text": text,
          "sender_type": "student",
          "sender_object_id": userId,
          "receiver_type": otherType,
          "receiver_object_id": otherId,
        },
      );

      final newMsg = ChatModel.fromJson(res, userId!);
      messages.add(newMsg);
      _scrollToBottom();
    } catch (e) {
      showErrorPopup(e.toString());
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  /// 🔔 Show notification when user is not inside chat window
  Future<void> _showNewMessageNotification(ChatModel msg) async {
    await NotificationService.showNotification(
      // title: msg.senderName ?? "New Message",
      title: "New Message",
      body: msg.text,
    );
  }
}
