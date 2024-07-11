import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({
    super.key,
    required this.date,
    required this.text,
  });
  final String date;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CSizes.mdRadius),
            color: Get.isDarkMode ? CColors.cardBgDark2 : CColors.cardBgGrey),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                date,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ));
  }
}
