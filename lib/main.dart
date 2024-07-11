import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/auth/view/signin/signin.dart';
import 'package:school_managment/util/localization/get_languages.dart';
import 'package:school_managment/util/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: CLanguages(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      title: 'managment',
      themeMode: ThemeMode.light,
      theme: CTheme.lightTheme,
      darkTheme: CTheme.darkTheme,
      home: Signin(),
    );
  }
}
