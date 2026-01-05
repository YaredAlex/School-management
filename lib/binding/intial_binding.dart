import 'package:get/get.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
