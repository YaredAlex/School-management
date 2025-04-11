class CAPIEndPoint {
  static const String baseUrl = 'http://10.0.2.2:8000';
  static const String login = '/api/users/login';
  static const String logout = '/api/users/logout';
  static const String parentProfile = '/api/users/profile';
  static const String parentStudents = '/api/parents/students';
  static String studentProfile(int id) => '/api/students/$id';
  static const String courses = '/api/courses/viewall';
  static String courseDetail(int id) => '/api/courses/view/$id';
  static String updateStudentProfile(int id) => '/api/users/$id';
  static String courseList(int id) => '/api/courses/class/$id';
  static String get courseResult => '/api/results/fetch';
  static String attendance(int id) => '/api/attendance/$id';
}
