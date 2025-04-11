import 'package:get/get.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/util/device/device.dart';

class ProfileController extends GetxController {
  UserController userController = Get.find();
  String? get academicYear => userController.currentStudent.value?.academicYear;
  String? get dateOfAdmission => formatDate(
      userController.currentStudent.value?.dateOfAdmission ?? DateTime.now());
  String? get fatherName => userController.currentStudent.value?.fatherName;
  String? get motherName => userController.currentStudent.value?.motherName;
  String? get dateOfBirth =>
      formatDate(userController.currentStudent.value?.dateOfBirth.toLocal() ??
          DateTime.now());
  String? get parentPhone =>
      userController.currentStudent.value?.parentPhoneNumber;
  String? get address => userController.currentStudent.value?.address;
  String? get name => userController.currentStudent.value?.name;
  String? get student_class =>
      userController.currentStudent.value?.classModel.className;
  String? get section =>
      userController.currentStudent.value?.classModel.section;
  int? get age =>
      calculateAge(userController.currentStudent.value?.dateOfBirth);
  String? get imgUrl => userController.currentStudent.value?.profilePicture;

  int? calculateAge(DateTime? dateOfBirth) {
    DateTime today = DateTime.now();
    if (dateOfBirth != null) {
      int age = today.year - dateOfBirth.year;
      if (today.month < dateOfBirth.month ||
          (today.month == dateOfBirth.month && today.day < dateOfBirth.day))
        age--;
      return age;
    }

    return null;
  }
}
