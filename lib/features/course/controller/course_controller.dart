import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/features/course/controller/course_result_controller.dart';
import 'package:school_managment/features/course/model/courses.dart';
import 'package:school_managment/features/course/view/course_result.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/controller/api_controller.dart';
import 'package:school_managment/util/image_constant.dart';

class CourseController extends GetxController {
  RxString selectedCourse = 'Mathematics'.obs;
  RxInt selectedSemester = 1.obs;
  UserController userController = Get.find();
  ApiController apiController = Get.find();
  RxBool isLoading = RxBool(false);
  final RxList<Course> _courses = <Course>[].obs;

  List<Course> get courses => _courses;
  //fetch Student course list
  void onInit() {
    super.onInit();
    fetchCourseList(userController.currentStudent.value?.classModel.id);
  }

  Future<void> onRefresh() async {
    fetchCourseList(userController.currentStudent.value?.classModel.id);
  }

  Future<void> fetchCourseList(int? classId) async {
    if (classId == null) {
      showErrorPopup("Class Id can not be null");
      return;
    }
    isLoading.value = true;
    try {
      final response = await apiController.request(
          endpoint: CAPIEndPoint.courseList(classId));
      List<Map<String, dynamic>>? data =
          (response['data'] as List<dynamic>).cast<Map<String, dynamic>>();
      int? courseId = data[0]['id'];
      if (courseId != null) {
        _courses.value = [];
      }
      for (var course in data) {
        //check if course have image
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
    Get.lazyPut(() => CourseResultController(courseId: courseId));
    Get.to(() => CourseResultScreen());
  }
  // final List<Map<String, dynamic>> courses = [
  //   {
  //     'course': 'Mathematics',
  //     'id': 1,
  //     'img': '',
  //   },
  //   {
  //     'course': 'Amharic',
  //     'id': 2,
  //     'img': '',
  //   },
  //   {
  //     'course': 'History',
  //     'id': 3,
  //     'img': '',
  //   },
  //   {
  //     'course': 'English',
  //     'id': 4,
  //     'img': '',
  //   },
  //   {
  //     'course': 'Biology',
  //     'id': 5,
  //     'img': '',
  //   },
  //   {
  //     'course': 'IT',
  //     'id': 6,
  //     'img': '',
  //   },
  //   {
  //     'course': 'Chemistry',
  //     'id': 6,
  //     'img': '',
  //   },
  // ];

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
