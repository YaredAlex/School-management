import 'package:get/get.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/util/controller/api_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(ApiController(), permanent: true);
  }
}
