import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/notifcation/model/notification_model.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/services/api_controller.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;
  final AuthController authController = Get.find();

  @override
  void onReady() {
    super.onReady();
    fetchNotifications();
  }

  Future<void> onRefresh() async {
    await fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      final response = await ApiService().get(CAPIEndPoint.events);
      List<Map<String, dynamic>>? data =
          (response['results'] as List<dynamic>).cast<Map<String, dynamic>>();
      debugPrint("data $data");
      notifications.value = [];
      for (var sem in data) {
        notifications.add(NotificationModel.fromJson(sem));
      }
    } catch (e) {
      Future.delayed(Duration(milliseconds: 0), () {
        showErrorPopup("Some message");
      });
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void markAsRead(int id) {
    final index = notifications.indexWhere((note) => note.id.toString() == id);
    if (index != -1) {
      notifications[index].isRead = true;
      notifications.refresh();
    }
  }
}
