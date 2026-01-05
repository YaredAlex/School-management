import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/confirmation/confirmation.dart';
import 'package:school_managment/common/widget/error/error_dialog.dart';
import 'package:school_managment/common/widget/loading_dialog/loading_dialog.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/auth/model/student.dart';

class CDrawerController extends GetxController {
  RxInt selectedIndex = 0.obs;
  AuthController authController = Get.find();
  Rxn<StudentModel> get currentStudent => authController.currentStudent;
  Rxn<List<StudentModel>> get students => authController.students;
  final drawingList = [
    {
      'title': "Profile",
      'icon'
          'onTap': () {},
    }
  ];
  void changeRoute(String route) {
    // Get.back(); causing error
    Get.toNamed(route);
  }

  void logout(BuildContext context) {
    ConfirmationDialog.show(
      context: context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmButtonText: 'Logout',
      cancelButtonText: 'Cancel',
      isDestructive: true,
      icon: Iconsax.danger,
      onConfirm: () {
        _logout(context);
      },
    );
  }

  void _logout(BuildContext context) async {
    try {
      LoadingDialog.show(context, message: "Logging you out");
      await authController.logout();
      // LoadingDialog.hide(context);
    } catch (e) {
      LoadingDialog.hide(context);
      ErrorPopup.show(context, message: "Error: ${e.toString()}");
      debugPrint(e.toString());
    }
  }

  void changeAccount(int index) {
    authController.currentStudent.value = authController.students.value?[index];
  }
}
