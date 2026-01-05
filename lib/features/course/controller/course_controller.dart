import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/course/controller/course_result_controller.dart';
import 'package:school_managment/features/course/model/courses.dart';
import 'package:school_managment/features/course/view/course_result.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/image_constant.dart';
import 'package:school_managment/util/services/api_controller.dart';

class CourseController extends GetxController {
  RxnString selectedCourse = RxnString(null);
  RxInt selectedSemester = 1.obs;
  AuthController authController = Get.find();
  RxBool isLoading = RxBool(false);
  final RxList<Course> _courses = <Course>[].obs;

  List<Course> get courses => _courses;
  //fetch Student course list
  void onInit() {
    super.onInit();
    fetchCourseList(authController.currentStudent.value?.id);
  }

  Future<void> onRefresh() async {
    fetchCourseList(authController.currentStudent.value?.id);
  }

  Future<void> fetchCourseList(int? studentId) async {
    if (studentId == null) {
      showErrorPopup("Studetn Id");
      return;
    }
    isLoading.value = true;
    try {
      final response =
          await ApiService().get(CAPIEndPoint.courseList(studentId));
      List<Map<String, dynamic>>? data =
          (response as List<dynamic>).cast<Map<String, dynamic>>();

      // debugPrint("data $data");
      _courses.value = [];
      for (var course in data) {
        _courses.add(Course.fromJson(course));
      }
    } catch (e) {
      showErrorPopup(e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toCourseResult(int courseId) {
    Get.lazyPut(() => CourseResultController(subjectId: courseId));
    Get.to(() => CourseResultScreen());
  }

  String getCourseAssetImage(String course) {
    course = course.toLowerCase();
    switch (course) {
      case 'english':
        return CImageConstant.englishIcon;
      case 'math':
      case 'mathematics':
        return CImageConstant.mathIcon;
      case 'physics':
        return CImageConstant.physicsIcon;
      case 'civic':
        return "";
      case 'amharic':
        return CImageConstant.amharicIcon;
      case 'chemistry':
        return CImageConstant.chemistryIcon;
      case 'biology':
        return CImageConstant.biologyIcon;
      case 'physical sport':
        return CImageConstant.sportIcon;
      case 'science':
        return CImageConstant.socialIcon;
      case 'it':
      case 'computer':
        return CImageConstant.computerIcon;
      case 'history':
        return CImageConstant.histroyIcon;
      default:
        return CImageConstant.courseIcon;
    }
  }
}
