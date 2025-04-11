import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/features/profile/controller/profile_controller.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/device/device.dart';
import 'package:school_managment/util/image_constant.dart';
import 'package:school_managment/util/sizes.dart';

class UserDetails extends StatelessWidget {
  UserDetails({super.key});
  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileHeader(context),
        const SizedBox(height: 24),
        // Personal Info Section
        _buildSectionTitle(context, CTexts.personalInformation),
        const SizedBox(height: 12),
        _buildDetailCard(
          context,
          [
            DetailItem(
              title: CTexts.dateOfBirth,
              value: "${profileController.dateOfBirth}",
              icon: Icons.cake,
            ),
            DetailItem(
              title: CTexts.age,
              value: "${profileController.age}",
              icon: Icons.person,
            ),
            DetailItem(
              title: CTexts.address,
              value: "${profileController.address}",
              icon: Icons.location_on,
            ),
          ],
        ),

        const SizedBox(height: 20),
// Parent Info Section
        _buildSectionTitle(context, CTexts.parentInformation),
        const SizedBox(height: 12),
        _buildDetailCard(
          context,
          [
            DetailItem(
              title: CTexts.fatherName,
              value: "${profileController.fatherName}",
              icon: Icons.person_outline,
            ),
            DetailItem(
              title: CTexts.motherName,
              value: "${profileController.motherName}",
              icon: Icons.person_outline,
            ),
            DetailItem(
              title: CTexts.phoneNumber,
              value: "+251 ${profileController.parentPhone}",
              icon: Icons.phone,
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Academic Info Section
        _buildSectionTitle(context, CTexts.academicInformation),
        const SizedBox(height: 12),
        _buildDetailCard(
          context,
          [
            DetailItem(
              title: CTexts.academicYear,
              value: "${profileController.academicYear}",
              icon: Icons.school,
            ),
            DetailItem(
              title: CTexts.dateOfAdission,
              value: "${profileController.dateOfAdmission}",
              icon: Icons.calendar_today,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildDetailCard(BuildContext context, List<DetailItem> items) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CSizes.mdRadius),
        color: getContainerBg(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length * 2 - 1, (index) {
          if (index % 2 == 0) {
            return _buildDetailItem(context, items[index ~/ 2]);
          } else {
            return Divider(
              height: 1,
              thickness: 1,
              color: getDividerColor(),
              indent: 16,
              endIndent: 16,
            );
          }
        }),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, DetailItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? Colors.blueGrey.shade800
                  : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              color: Get.isDarkMode ? Colors.blue.shade200 : Colors.blue,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Get.isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Avatar
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink.shade100,
            ),
            child: profileController.imgUrl != null &&
                    profileController.imgUrl != 'default-profile.png'
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      profileController.imgUrl ?? CImageConstant.socialIcon,
                      fit: BoxFit.cover,
                    ),
                  )
                : CircleAvatar(
                    radius: 28,
                    backgroundImage: const AssetImage(CImageConstant.avatarF),
                    backgroundColor: Colors.pink.shade100,
                  ),
          ),

          const SizedBox(height: 16),

          // Student Name
          Text(
            "${profileController.name} ${profileController.fatherName}",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          // Class and Section
          Text(
            "${CTexts.classGrade} ${profileController.student_class} | ${CTexts.section} ${profileController.section}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Get.isDarkMode
                      ? Colors.grey.shade400
                      : Colors.grey.shade600,
                ),
            textAlign: TextAlign.center,
          ),
          // const SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: () {
          //     // Handle profile button tap
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.deepPurple,
          //     foregroundColor: Colors.white,
          //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //   ),
          //   child: const Text("Profile"),
          // ),
        ],
      ),
    );
  }
}

class DetailItem {
  final String title;
  final String value;
  final IconData icon;

  DetailItem({
    required this.title,
    required this.value,
    required this.icon,
  });
}
