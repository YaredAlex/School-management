import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/features/course/controller/course_controller.dart';
import 'package:school_managment/features/course/model/courses.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/controller/api_controller.dart';

class CourseResultController extends GetxController {
  final int courseId;
  CourseResultController({required this.courseId});
  RxBool isLoading = RxBool(true);
  UserController userController = Get.find();
  ApiController apiController = Get.find();
  CourseController courseController = Get.find();
  RxString selectedCourse = 'Mathematics'.obs;
  RxInt selectedSemester = 1.obs;
  void onInit() {
    super.onInit();
    fetchResult(courseId, userController.currentStudent.value?.id);
  }

  List<Course> get courses => courseController.courses;
  Future<void> onRefresh() async {
    fetchResult(courseId, userController.currentStudent.value?.id);
  }

  Future<void> fetchResult(int courseId, int? studentId) async {
    isLoading.value = true;
    try {
      final response = await apiController
          .request(endpoint: CAPIEndPoint.courseResult, method: 'POST', data: {
        'course_id': courseId,
        'student_id': studentId,
      });
      debugPrint('$response');
    } catch (e) {
      showErrorPopup(e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  final Map<String, Map<String, dynamic>> courseResults = {
    'Mathematics': {
      'semester1': {
        'dailyActivities': [
          {'date': '2023-01-15', 'activity': 'Homework', 'score': 90},
          {
            'date': '2023-02-01',
            'activity': 'Class Participation',
            'score': 85
          },
        ],
        'quizzes': [
          {'date': '2023-01-30', 'topic': 'Algebra', 'score': 88},
          {'date': '2023-02-15', 'topic': 'Geometry', 'score': 92},
        ],
        'tests': [
          {'date': '2023-03-01', 'topic': 'Mid-term', 'score': 85},
          {'date': '2023-04-15', 'topic': 'Final', 'score': 90},
        ],
      },
      'semester2': {
        'dailyActivities': [
          {'date': '2023-09-15', 'activity': 'Project', 'score': 95},
          {'date': '2023-10-01', 'activity': 'Presentation', 'score': 88},
        ],
        'quizzes': [
          {'date': '2023-09-30', 'topic': 'Trigonometry', 'score': 87},
          {'date': '2023-10-15', 'topic': 'Calculus', 'score': 89},
        ],
        'tests': [
          {'date': '2023-11-01', 'topic': 'Mid-term', 'score': 86},
          {'date': '2023-12-15', 'topic': 'Final', 'score': 91},
        ],
      },
    },
  };

  void changeCourse(String course) {
    selectedCourse.value = course;
  }

  void changeSemester(int semester) {
    selectedSemester.value = semester;
  }
}
