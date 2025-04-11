import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/attendace/view/attendance.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/features/auth/model/student.dart';

class HomeController extends GetxController {
  final userController = Get.find<UserController>();
  final authController = Get.find<AuthController>();
  final isLoading = RxBool(false);
  Rxn currentStudent = Rxn<Student>();
  @override
  void onInit() {
    super.onInit();
    intializeStudent();
  }

  @override
  void onReady() {
    super.onStart();
  }

  void intializeStudent() async {
    try {
      if (!isLoading.value && !userController.isStudentInitialized.value) {
        await userController.fetchStudents();
        currentStudent = userController.currentStudent;
      }
    } catch (e) {
      showErrorPopup(e.toString());
      debugPrint("showing error " + e.toString());
    } finally {
      isLoading.value = false;
      //use need to check your network connection as well
      //check if student is intialized
      if (userController.currentStudent.value == null) {
        //show big error and option to refresh

        debugPrint("student is null");
      }
    }
  }

  void toAttendance() {
    Get.to(() => AttendanceScreen());
  }
}
