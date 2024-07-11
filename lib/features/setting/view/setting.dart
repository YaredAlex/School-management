import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/features/setting/controller/setting_controller.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/text/texts.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  SettingsPage({super.key});
  final iconPadding = 4.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? CColors.backgroundDark : Colors.white,
      appBar: AppBar(
        shape: Border(
            bottom: BorderSide(
                color:
                    Get.isDarkMode ? CColors.borderDark : CColors.borderLight)),
        title: Text(CTexts.setting),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
                title: CTexts.generalSettings, context: context),
            _buildSettingsCard([
              ListTile(
                  leading: Icon(Icons.language),
                  title: Text(
                    CTexts.language,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(CTexts.selectPreferredLanguage),
                  trailing: Obx(() => DropdownButton<String>(
                        value: controller.language.value,
                        onChanged: (String? newValue) {
                          if (newValue != null)
                            controller.changeLanguage(newValue);
                        },
                        items: <Map<String, String>>[
                          {'code': 'en', 'name': 'English'},
                          {'code': 'am', 'name': 'Amharic'},
                          {'code': 'om', 'name': 'Oromifa'},
                        ].map<DropdownMenuItem<String>>(
                            (Map<String, String> language) {
                          return DropdownMenuItem<String>(
                            value: language['code'],
                            child: Text(language['name']!),
                          );
                        }).toList(),
                      ))),
              Obx(() => SwitchListTile(
                    secondary: const Icon(
                      Icons.dark_mode_outlined,
                    ),
                    subtitle: Text(CTexts.togleDarkMode),
                    title: Text(
                      CTexts.darkMode,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    value: controller.darkMode.value,
                    onChanged: controller.toggleDarkMode,
                  )),
              Obx(
                () => SwitchListTile(
                  secondary: const Icon(
                    Icons.notifications_outlined,
                  ),
                  subtitle: Text(CTexts.managePushNotification),
                  title: Text(
                    CTexts.pushNotification,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  value: controller.pushNotifications.value,
                  onChanged: controller.togglePushNotifications,
                ),
              ),
            ]),
            Divider(
                color:
                    Get.isDarkMode ? CColors.borderDark : CColors.borderLight),
            _buildSectionHeader(
                title: CTexts.accountSettings, context: context),
            _buildSettingsCard([
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text(
                  'User Role',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Obx(() => DropdownButton<String>(
                      value: controller.userRole.value,
                      onChanged: (String? newValue) {
                        if (newValue != null)
                          controller.changeUserRole(newValue);
                      },
                      items: <String>['Student', 'Teacher', 'Admin']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
              ),
              ListTile(
                leading: const Icon(Iconsax.key),
                title: Text(
                  CTexts.changePassword,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(CTexts.updateYourPassword),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => Get.toNamed('/changePassword'),
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(
                  CTexts.updateProfile,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(CTexts.editYourPersonalAndContact),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => Get.toNamed('/updateProfile'),
              ),
            ]),
            Divider(
                color:
                    Get.isDarkMode ? CColors.borderDark : CColors.borderLight),
            _buildSectionHeader(
                title: CTexts.academicSettings, context: context),
            _buildSettingsCard([
              ListTile(
                leading: Icon(Iconsax.calendar),
                title: Text(
                  CTexts.academicYear,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Obx(() => Text(controller.academicYear.value)),
                onTap: () => controller.changeAcademicYear(),
              ),
              ListTile(
                leading: Icon(Icons.grade_outlined),
                title: Text(
                  CTexts.classGrade,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Obx(() => Text(controller.classGrade.value)),
                onTap: () => controller.changeClassGrade(),
              ),
            ]),
            Divider(
                color:
                    Get.isDarkMode ? CColors.borderDark : CColors.borderLight),
            _buildSectionHeader(title: CTexts.appInformation, context: context),
            _buildSettingsCard([
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.symmetric(horizontal: iconPadding),
                  child: const Icon(Icons.policy_outlined),
                ),
                title: Text(
                  CTexts.privacyPolicy,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(CTexts.reviewTermAndPolicy),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Get.toNamed('/privacyPolicy'),
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.symmetric(horizontal: iconPadding),
                  child: const Icon(Icons.shield_outlined),
                ),
                title: Text(
                  CTexts.termOfServices,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(CTexts.learnMoreAbout),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Get.toNamed('/termsOfService'),
              ),
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.symmetric(horizontal: iconPadding),
                  child: const Icon(Icons.help_outline),
                ),
                title: Text(
                  CTexts.about,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Get.toNamed('/about'),
              ),
            ]),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: controller.logout,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.red,
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            //   ),
            //   child: const Text('Logout'),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      {required String title, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      elevation: 0,
      child: Column(children: children),
    );
  }
}
