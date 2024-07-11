import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/CircularImage/circular_image.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/profile/view/widget/details.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/text/texts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  final double height = 190;
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
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // Get.back();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: CSizes.defaultSpace, right: CSizes.defaultSpace),
                  child: Row(
                    children: [
                      const CCircleAvatar(
                        radius: 40,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CTexts.userName,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .apply(color: Colors.white),
                          ),
                          Text(
                            CTexts.userSub,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                )
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
                  //
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(CSizes.mdRadius),
                        color: Get.isDarkMode
                            ? CColors.cardBgDark
                            : CColors.lightPurple),
                    child: Text(
                      "Profile",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  //details
                  const UserDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
