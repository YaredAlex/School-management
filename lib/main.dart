import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/binding/attendance_binding.dart';
import 'package:school_managment/features/attendace/view/attendance.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/features/auth/controller/user_controller.dart';
import 'package:school_managment/features/auth/view/signin/signin.dart';
import 'package:school_managment/features/course/view/course.dart';
import 'package:school_managment/features/home/view/home.dart';
import 'package:school_managment/features/library/view/library.dart';
import 'package:school_managment/features/navigation/navigate.dart';
import 'package:school_managment/features/profile/view/profile.dart';
import 'package:school_managment/features/setting/view/setting.dart';
import 'package:school_managment/features/splash/view/splash.dart';
import 'package:school_managment/util/controller/api_controller.dart';
import 'package:school_managment/util/localization/get_languages.dart';
import 'package:school_managment/util/routes/routes.dart';
import 'package:school_managment/util/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ApiController(), permanent: true);
  Get.put(UserController(), permanent: true);
  Get.put(AuthController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: CLanguages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'School IB',
      themeMode: ThemeMode.light,
      theme: CTheme.lightTheme,
      darkTheme: CTheme.darkTheme,
      initialRoute: CRoutes.splash,
      getPages: [
        GetPage(name: CRoutes.splash, page: () => SplashScreen()),
        GetPage(name: CRoutes.signin, page: () => Signin()),
        GetPage(name: CRoutes.home, page: () => NavigationScreen()),
        GetPage(name: CRoutes.profile, page: () => ProfileScreen()),
        GetPage(name: CRoutes.courses, page: () => CourseScreen()),
        GetPage(name: CRoutes.attendance, page: () => AttendanceScreen()),
        GetPage(name: CRoutes.library, page: () => LibraryScreen()),
        GetPage(
            name: CRoutes.attendance,
            binding: AttendanceBinding(),
            page: () => AttendanceScreen()),
        GetPage(name: CRoutes.setting, page: () => SettingsPage()),
      ],
    );
  }
}
