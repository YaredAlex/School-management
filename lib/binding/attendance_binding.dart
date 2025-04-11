import 'package:get/get.dart';
import 'package:school_managment/features/attendace/controller/attendance_controller.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    print('AttendanceBinding: Registering AttendanceController');
    Get.lazyPut<AttendanceController>(() => AttendanceController());
  }
}
