import 'dart:async';

import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/message/model/message_list_model.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/services/api_controller.dart';

class MessageController extends GetxController {
  var isLoading = false.obs;
  var messageHistory = <MessageHistory>[].obs;

  late String userType;
  late int? userId;

  AuthController authController = Get.find();
  Timer? _pollingTimer;

  void init(String? type, int? id) {
    userType = "student";
    userId = authController.currentStudent.value?.id;

    fetchHistory();

    // ⏱ Poll for new messages every 2 seconds
    _pollingTimer = Timer.periodic(Duration(seconds: 2), (_) {
      checkForNewMessages();
    });
  }

  /// --- Core API Call ---
  Future<List<MessageHistory>> _fetchHistoryRaw() async {
    final response =
        await ApiService().get(CAPIEndPoint.messageHistory(userType, userId));
    final data = response as List<dynamic>;
    return data.map((e) => MessageHistory.fromJson(e)).toList();
  }

  /// --- Initial Load ---
  Future<void> fetchHistory() async {
    if (userId == null) {
      showErrorPopup("Student id is required");
      return;
    }
    try {
      isLoading.value = true;
      messageHistory.value = await _fetchHistoryRaw();
    } catch (e) {
      showErrorPopup(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //incremental update
  Future<void> checkForNewMessages() async {
    if (userId == null) return;

    try {
      final newData = await _fetchHistoryRaw();

      // Update only if new messages differ
      if (_isDifferent(newData, messageHistory)) {
        messageHistory.value = newData;
      }
    } catch (e) {
      print("Polling error: $e");
    }
  }

  /// Helper: Compare message lists
  bool _isDifferent(List<MessageHistory> newList, List oldList) {
    if (newList.length != oldList.length) return true;

    // If lengths same, compare last message IDs
    if (newList.isNotEmpty &&
        oldList.isNotEmpty &&
        newList.last.id != oldList.last.id) return true;

    return false;
  }

  @override
  void onClose() {
    _pollingTimer?.cancel(); // Stop timer to prevent memory leak
    super.onClose();
  }
}
