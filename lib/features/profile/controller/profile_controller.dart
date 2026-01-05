import 'package:get/get.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/util/device/device.dart';

class ProfileController extends GetxController {
  AuthController authController = Get.find();
  String? get academicYear => authController.currentStudent.value?.academicYear;
  String? get dateOfAdmission =>
      authController.currentStudent.value?.dateOfAdmission != null
          ? formatDate(
              authController.currentStudent.value!.dateOfAdmission!.toLocal())
          : null;
  String? get fatherName => authController.currentStudent.value?.fatherName;
  String? get motherName => authController.currentStudent.value?.motherName;
  String? get dateOfBirth => authController.currentStudent.value?.dateOfBirth !=
          null
      ? formatDate(authController.currentStudent.value!.dateOfBirth!.toLocal())
      : null;
  String? get parentPhone => authController.currentStudent.value?.phone;
  String? get address => authController.currentStudent.value?.address;
  String? get name => authController.currentStudent.value?.fullName;
  String? get student_class => authController.currentStudent.value?.gradeName;
  String? get section =>
      authController.currentStudent.value?.section_name.toString();
  int? get age =>
      calculateAge(authController.currentStudent.value?.dateOfBirth);
  String? get imgUrl => authController.currentStudent.value?.picture;
  String get gender => authController.currentStudent.value?.gender ?? "Male";
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
