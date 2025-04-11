import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/confirmation/confirmation.dart';
import 'package:school_managment/common/widget/error/error_dialog.dart';
import 'package:school_managment/common/widget/loading_dialog/loading_dialog.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/features/auth/model/student.dart';

class CDrawerController extends GetxController {
  RxInt selectedIndex = 0.obs;
  UserController userController = Get.find();
  AuthController authController = Get.find();
  Rxn<Student> get currentStudent => userController.currentStudent;
  Rxn<List<Student>> get students => userController.students;
  final drawingList = [
    {
      'title': "Profile",
      'icon'
          'onTap': () {},
    }
  ];
  void changeRoute(String route) {
    Get.back();
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
      LoadingDialog.hide(context);
    } catch (e) {
      LoadingDialog.hide(context);
      ErrorPopup.show(context, message: "Error: ${e.toString()}");
    }
  }

  void changeAccount(int index) {
    userController.currentStudent.value = userController.students.value?[index];
  }
}
