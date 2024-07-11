import 'package:get/get.dart';
import 'package:school_managment/util/image_constant.dart';

class CourseResultController extends GetxController {
  RxString selectedCourse = 'Mathematics'.obs;
  RxInt selectedSemester = 1.obs;

  final List<Map<String, dynamic>> courses = [
    {
      'course': 'Mathematics',
      'id': 1,
      'img': '',
    },
    {
      'course': 'Amharic',
      'id': 2,
      'img': '',
    },
    {
      'course': 'History',
      'id': 3,
      'img': '',
    },
    {
      'course': 'English',
      'id': 4,
      'img': '',
    },
    {
      'course': 'Biology',
      'id': 5,
      'img': '',
    },
    {
      'course': 'IT',
      'id': 6,
      'img': '',
    },
  ];

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
    // Add more courses here...
  };

  void changeCourse(String course) {
    selectedCourse.value = course;
  }

  void changeSemester(int semester) {
    selectedSemester.value = semester;
  }

  String getCourseAssetImage(String course) {
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
