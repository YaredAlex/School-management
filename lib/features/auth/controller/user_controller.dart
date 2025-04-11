import 'package:get/get.dart';
import 'package:school_managment/features/auth/model/student.dart';
import 'package:school_managment/features/auth/model/user.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/controller/api_controller.dart';

class UserController extends GetxController {
  final ApiController apiController = Get.find<ApiController>();
  final currentParent = Rxn<User>();
  final students = Rxn<List<Student>>(null);
  final currentStudent = Rxn<Student>();
  final isStudentInitialized = RxBool(false);

  Future<void> fetchUserProfile() async {
    var response = await apiController.request(
      endpoint: CAPIEndPoint.parentProfile,
      method: "GET",
      useToken: true,
    );
    if (response != null) {
      print(response['user']);
      currentParent.value = User.fromJson(response['user']);
    }
  }

  Future<void> fetchStudents() async {
    var response = await apiController.request(
        endpoint: CAPIEndPoint.parentStudents,
        method: "GET",
        data: {"parent_phone_number": currentParent.value?.phoneNumber},
        useToken: true);
    if (response != null) {
      var result = response['students'] as List<dynamic>;
      List<Map<String, dynamic>> data = result.cast<Map<String, dynamic>>();
      final allSibilings = <Student>[];
      for (var s in data) {
        allSibilings.add(Student.fromJson(s));
      }
      currentStudent.value = allSibilings.first;
      students.value = allSibilings;
      isStudentInitialized.value = true;
      print("all student is $allSibilings");
    }
  }

  void clearUser() {
    currentParent.value = null;
  }
}
