import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/attendace/view/attendance.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/auth/model/student.dart';
import 'package:school_managment/features/communication/model/gallery_model.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/services/api_controller.dart';

class HomeController extends GetxController {
  final authController = Get.find<AuthController>();
  final isLoading = RxBool(false);
  Rxn<StudentModel> currentStudent = Rxn<StudentModel>();
  RxList<GalleryModel> gallery = RxList<GalleryModel>([]);

  @override
  void onInit() {
    super.onInit();
    initializeStudent();
    fetchGallerImage();
  }

  @override
  void onReady() {
    super.onStart();
  }

  Future<void> initializeStudent() async {
    try {
      if (!authController.isStudentInitialized.value) {
        await authController.fetchStudents();
        currentStudent = authController.currentStudent;
      }
      await authController.fetchStudents();
    } catch (e) {
      debugPrint(e.toString());
      showErrorPopup(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGallerImage() async {
    try {
      final res = await ApiService().get(CAPIEndPoint.gallery);
      final galleryData = <GalleryModel>[];
      for (var json in res['results']) {
        galleryData.add(GalleryModel.fromJson(json));
      }
      debugPrint("Galler data $galleryData");
      gallery.value = galleryData;
    } catch (e) {
      debugPrint(e.toString());
      showErrorPopup(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toAttendance() {
    Get.to(() => AttendanceScreen());
  }
}
