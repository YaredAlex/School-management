import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  // General Settings
  final RxBool darkMode = false.obs;

  // Notifications
  final RxBool pushNotifications = true.obs;
  final RxBool emailNotifications = true.obs;

  // Account Settings
  final RxString userRole = 'Student'.obs;

  // Academic Settings
  final RxString academicYear = '2023-2024'.obs;
  final RxString classGrade = '10th Grade'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
    // clearSharedPreferences();
  }

  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('Shared preferences cleared');
  }

  var language = 'en'.obs;

  void changeLanguage(String langCode) {
    language.value = langCode;
    switch (langCode) {
      case 'en':
        Get.updateLocale(Locale('en', 'US'));
        break;
      case 'am':
        Get.updateLocale(Locale('am', 'ET'));
        break;
      case 'om':
        Get.updateLocale(Locale('om', 'ET'));
        break;
    }
    saveSettings();
  }

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    darkMode.value = prefs.getBool('darkMode') ?? false;
    language.value = prefs.getString('language') ?? 'English';
    pushNotifications.value = prefs.getBool('pushNotifications') ?? true;
    emailNotifications.value = prefs.getBool('emailNotifications') ?? true;
    userRole.value = prefs.getString('userRole') ?? 'Student';
    academicYear.value = prefs.getString('academicYear') ?? '2023-2024';
    classGrade.value = prefs.getString('classGrade') ?? '10th Grade';
  }

  Future<void> saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', darkMode.value);
    await prefs.setString('language', language.value);
    await prefs.setBool('pushNotifications', pushNotifications.value);
    await prefs.setBool('emailNotifications', emailNotifications.value);
    await prefs.setString('userRole', userRole.value);
    await prefs.setString('academicYear', academicYear.value);
    await prefs.setString('classGrade', classGrade.value);
  }

  void toggleDarkMode(bool value) {
    darkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    saveSettings();
  }

  void togglePushNotifications(bool value) {
    pushNotifications.value = value;
    // Implement push notification toggle logic here
    saveSettings();
  }

  void toggleEmailNotifications(bool value) {
    emailNotifications.value = value;
    // Implement email notification toggle logic here
    saveSettings();
  }

  void changeUserRole(String value) {
    userRole.value = value;
    // Implement user role change logic here
    saveSettings();
  }

  void changeAcademicYear() {
    Get.dialog(
      AlertDialog(
        title: Text('Select Academic Year'),
        content: DropdownButton<String>(
          value: academicYear.value,
          items: ['2022-2023', '2023-2024', '2024-2025'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              academicYear.value = newValue;
              saveSettings();
              Get.back();
            }
          },
        ),
      ),
    );
  }

  void changeClassGrade() {
    Get.dialog(
      AlertDialog(
        title: Text('Select Class/Grade'),
        content: DropdownButton<String>(
          value: classGrade.value,
          items: ['9th Grade', '10th Grade', '11th Grade', '12th Grade']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              classGrade.value = newValue;
              saveSettings();
              Get.back();
            }
          },
        ),
      ),
    );
  }

  void logout() {
    // Implement logout logic here
    // For example:
    // AuthService.logout();
    Get.offAllNamed('/login'); // Navigate to login page
  }

  void navigateToChangePassword() {
    Get.toNamed('/changePassword');
  }

  void navigateToUpdateProfile() {
    Get.toNamed('/updateProfile');
  }

  void navigateToPrivacyPolicy() {
    Get.toNamed('/privacyPolicy');
  }

  void navigateToTermsOfService() {
    Get.toNamed('/termsOfService');
  }

  void navigateToAbout() {
    Get.toNamed('/about');
  }
}
