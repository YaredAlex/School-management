import 'package:get/get.dart';
import 'package:school_managment/features/navigation/navigate.dart';

class SigninController extends GetxController {
  void signinUser() {
    Get.to(() => NavigationScreen());
  }
}
