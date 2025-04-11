import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/util/image_constant.dart';
import 'package:school_managment/util/routes/routes.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:shimmer/shimmer.dart'; // Add this package to your pubspec.yaml

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  CAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.showLeading = true,
    this.isLoading = false,
    this.showGreeting = false,
    this.showProfile = false,
  });
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final bool showLeading;
  final bool isLoading;
  final bool showGreeting;
  final bool showProfile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.itemSpacing),
      child: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: showProfile ? kToolbarHeight + 10 : kToolbarHeight,
        centerTitle: showGreeting ? false : true,
        automaticallyImplyLeading: true,
        leadingWidth: 60,
        leading: _buildLeading(context),
        title: _buildTitle(context),
        actions: showProfile ? _buildDefaultActions(context) : actions,
      ),
    );
  }

  Widget? _buildTitle(BuildContext context) {
    if (showGreeting) {
      return Center(
          widthFactor: 1,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hi 👋\n',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: Colors.white),
                ),
                TextSpan(
                  text: title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: Colors.white),
                ),
              ],
            ),
          ));
    } else {
      return Text(
        title!,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: Colors.white),
      );
    }
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) {
      return leading;
    } else if (showLeading) {
      return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: () {
          Get.toNamed(CRoutes.profile);
        },
        icon: const CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(CImageConstant.avatarF),
        ),
      );
    }
    return null;
  }

  List<Widget> _buildDefaultActions(BuildContext context) {
    return [
      IconButton(
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
        icon: const Icon(
          Iconsax.menu_1,
          size: 28,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
