import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CSizes.mdRadius),
          color: Get.isDarkMode ? CColors.cardBgDark : Colors.white),
      child: Column(
        children: [
          const DetailCell(
            children: [
              ExpandedText(
                title: "Acadamic Year",
                subtitle: "2024 - 2025",
              ),
              SizedBox(
                width: 24,
              ),
              ExpandedText(
                title: "Date of Admission",
                subtitle: "1 oct 2020",
              ),
            ],
          ),
          Divider(
            color: Get.isDarkMode ? CColors.borderDark : CColors.borderLight,
          ),
          const DetailCell(
            children: [
              ExpandedText(
                title: "Father name",
                subtitle: "Snow Fall",
              ),
              SizedBox(
                width: 24,
              ),
              ExpandedText(
                title: "Mother name",
                subtitle: "Eleni Snow",
              ),
            ],
          ),
          Divider(
            color: Get.isDarkMode ? CColors.borderDark : CColors.borderLight,
          ),
          const DetailCell(
            children: [
              ExpandedText(
                title: "Date of birth",
                subtitle: "01-10-2019",
              ),
              SizedBox(
                width: 24,
              ),
              ExpandedText(
                title: "Age",
                subtitle: "4",
              ),
            ],
          ),
          Divider(
            color: Get.isDarkMode ? CColors.borderDark : CColors.borderLight,
          ),
          const DetailCell(
            children: [
              ExpandedText(
                title: "Parent Phone",
                subtitle: "+251 0908978678",
              ),
              SizedBox(
                width: 24,
              ),
            ],
          ),
          Divider(
            color: Get.isDarkMode ? CColors.borderDark : CColors.borderLight,
          ),
          const DetailCell(
            children: [
              ExpandedText(
                title: "Address",
                subtitle: "Garment, Addis Ababa",
              ),
              SizedBox(
                width: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailCell extends StatelessWidget {
  const DetailCell({
    super.key,
    required this.children,
  });
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: children,
      ),
    );
  }
}

class ExpandedText extends StatelessWidget {
  const ExpandedText({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(
            height: 8,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    ));
  }
}
