import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/grdi_view/grid_view.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/home/view/widgets/home/academics.dart';
import 'package:school_managment/features/home/view/widgets/home/carousel.dart';
import 'package:school_managment/features/home/view/widgets/home/notice_card.dart';
import 'package:school_managment/features/setting/view/setting.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/image_constant.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/text/texts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CHeaderSection(
            height: CSizes.topBarHeight,
            childern: [
              CAppBar(
                title: CTexts.userName,
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       "Hello John!",
              //       style: Theme.of(context)
              //           .textTheme
              //           .headlineMedium!
              //           .apply(color: Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? CColors.backgroundDark
                  : CColors.backgroundPrimary,
            ),
            child: Column(
              children: [
                //Body of home
                //Carousel Image
                ImageCarousel(),
                //Acadamics
                const Academics(),
                const SizedBox(
                  height: CSizes.defaultSpace,
                ),
                //Notice
                const HomeNotice(),
                const SizedBox(
                  height: CSizes.defaultSpace,
                ),
                //parental service
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CTexts.parentalService,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 160,
                        child: CGrideView(
                          column: 2,
                          childrenHeight: 150,
                          children: [
                            ParentalCard(
                              onTap: () {
                                Get.to(() => SettingsPage());
                              },
                              title: CTexts.setting,
                              subtitle: CTexts.settingSubtitle,
                              assetIcon: CImageConstant.settingIcon,
                              backgroundColor: CColors.orange,
                              circularBgColor: CColors.c2,
                            ),
                            ParentalCard(
                              onTap: () {},
                              title: CTexts.message,
                              subtitle: CTexts.messageSubtitle,
                              assetIcon: CImageConstant.messageIcon,
                              backgroundColor: CColors.periwinkleBlue,
                              circularBgColor: CColors.c1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ParentalCard extends StatelessWidget {
  const ParentalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.assetIcon,
    required this.backgroundColor,
    required this.circularBgColor,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final String assetIcon;
  final Color backgroundColor;
  final Color circularBgColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
            top: CSizes.itemSpacing, left: CSizes.itemSpacing),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(CSizes.mdRadius)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(color: Colors.white),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: const Color.fromARGB(255, 248, 248, 248)),
                ),
              ],
            ),
            Positioned(
              bottom: -20,
              right: -25,
              child: CircularContainer(
                radius: 100,
                bgColor: circularBgColor,
              ),
            ),
            Positioned(
                bottom: 4,
                right: 4,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset(assetIcon),
                )),
          ],
        ),
      ),
    );
  }
}

class HomeNotice extends StatelessWidget {
  const HomeNotice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CTexts.notice,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: CSizes.itemSpacing,
          ),
          Container(
            padding: const EdgeInsets.all(CSizes.itemSpacing),
            decoration: BoxDecoration(
                color: Get.isDarkMode ? CColors.cardBgDark : Colors.white,
                borderRadius: BorderRadius.circular(CSizes.mdRadius)),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                NoticeCard(
                  date: "12-09-2024",
                  text:
                      "Dear student your registration is pending register for next semester",
                ),
                SizedBox(
                  height: 16,
                ),
                NoticeCard(
                  date: "12-10-2024",
                  text:
                      "We are pleased to inform you that there has been change in school rules and regulation",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
