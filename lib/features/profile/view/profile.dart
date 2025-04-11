import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/profile/controller/profile_controller.dart';
import 'package:school_managment/features/profile/view/widget/details.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/sizes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final double height = CSizes.topBarHeight;
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CHeaderSection(
              height: height,
              childern: [
                CAppBar(
                  showLeading: false,
                  title: CTexts.profile,
                ),
              ],
            ),
            // Content
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CColors.backgroundDark
                    : CColors.backgroundPrimary,
              ),
              child: Column(
                children: [
                  //details
                  UserDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
