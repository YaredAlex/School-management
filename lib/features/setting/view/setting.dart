import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/features/setting/controller/setting_controller.dart';
import 'package:school_managment/features/setting/view/widget/change_password.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/device/device.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  SettingsPage({super.key});
  final iconPadding = 4.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? CColors.backgroundDark : Colors.white,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: getDividerColor())),
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
                leading: const Icon(Icons.language),
                title: Text(
                  CTexts.language,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(CTexts.selectPreferredLanguage),
                trailing: SizedBox(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: SizedBox(
                        child: DropdownButton<String>(
                          value: controller.language.value,
                          onChanged: controller.changeLanguage,
                          items: controller.availableLanguage
                              .map<DropdownMenuItem<String>>(
                            (Map<String, String> language) {
                              return DropdownMenuItem<String>(
                                value: language['code'],
                                child: Text(language['name']!),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Dark Mode Switch
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

              // Notifications Switch
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
            Divider(color: getDividerColor()),
            _buildSectionHeader(
                title: CTexts.accountSettings, context: context),
            _buildSettingsCard([
              // User Role Tile
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(
                  'User',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Obx(() => SizedBox(
                      width: 100,
                      child: Text(
                        "${controller.userRole.value}",
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ),

              // Change Password Tile
              ListTile(
                leading: const Icon(Iconsax.key),
                title: Text(
                  CTexts.changePassword,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(CTexts.updateYourPassword),
                trailing: const SizedBox(
                  width: 30,
                  child: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                onTap: () => Get.to(() => ChangePasswordPage()),
              ),

              // Update Profile Tile
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(
                  CTexts.updateProfile,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(CTexts.editYourPersonalAndContact),
                trailing: const SizedBox(
                  width: 30,
                  child: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                onTap: () => Get.toNamed('/updateProfile'),
              ),
            ]),
            Divider(color: getDividerColor()),
            _buildSectionHeader(
                title: CTexts.academicSettings, context: context),
            _buildSettingsCard([
              // Academic Year Tile
              ListTile(
                leading: const Icon(Iconsax.calendar),
                title: Text(
                  CTexts.academicYear,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Obx(() => SizedBox(
                      width: 100,
                      child: Text(
                        controller.academicYear.value,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                onTap: () => controller.changeAcademicYear(),
              ),

              // Class Grade Tile
              ListTile(
                leading: const Icon(Icons.grade_outlined),
                title: Text(
                  CTexts.classGrade,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Obx(() => SizedBox(
                      width: 100,
                      child: Text(
                        controller.classGrade.value,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                onTap: () => controller.changeClassGrade(),
              ),
            ]),
            Divider(color: getDividerColor()),
            _buildSectionHeader(title: CTexts.appInformation, context: context),
            _buildSettingsCard([
              // Privacy Policy Tile
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
                trailing: const SizedBox(
                  width: 30,
                  child: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                onTap: () => Get.toNamed('/privacyPolicy'),
              ),

              // Terms of Service Tile
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
                trailing: const SizedBox(
                  width: 30,
                  child: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                onTap: () => Get.toNamed('/termsOfService'),
              ),

              // About Tile
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.symmetric(horizontal: iconPadding),
                  child: const Icon(Icons.help_outline),
                ),
                title: Text(
                  CTexts.about,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: const SizedBox(
                  width: 30,
                  child: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                onTap: () => Get.toNamed('/about'),
              ),
            ]),
            const SizedBox(height: 20),
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
