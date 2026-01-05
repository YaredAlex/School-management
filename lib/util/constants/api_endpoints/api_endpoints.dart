class CAPIEndPoint {
  static const String baseUrl = 'http://10.0.2.2:8000';
  static const String login = '/api/user/login/';
  static const String logout = '/api/user/logout/';
  static const String resetPassword = '/api/user/reset-password/';
  static const String profile = '/api/user/profile/';
  static const String parentStudents = '/api/student/parent-student/';
  static String studentProfile(int id) => '/api/student/$id/';
  static const String courses = '/api/courses/viewall/';
  static String courseDetail(int id) => '/api/courses/view/$id/';
  static String updateStudentProfile(int id) => '/api/users/$id/';
  static String courseList(int id) => '/api/student/$id/courses/';
  static String get courseResult => '/api/results/fetch/';
  static String result(int id) => '/api/student/$id/results';
  static String resultSubject(int id, int subjectId) =>
      '/api/student/$id/results?subject_id=$subjectId';
  static String get events => '/api/events/';
  static String messageHistory(userType, userId) =>
      '/api/messages/history/?user_type=$userType&user_id=$userId';
  static String chatApi({userType, userId, otherType, otherId}) =>
      '/api/messages/conversation/?user_type=$userType&user_id=$userId&other_type=$otherType&other_id=$otherId';
  static String newChatApi({userType, userId, otherType, otherId}) =>
      '/api/messages/new/?user_type=$userType&user_id=$userId&other_type=$otherType&other_id=$otherId';
  static String sendChat({userType, userId, otherType, otherId}) =>
      '/api/messages/';
  static String attendance(int id) => '/api/student/$id/attendance/';
  static String get gallery => '/api/gallery/';
  static String timetable(classId) => '/api/timetables/?section=$classId';
}
