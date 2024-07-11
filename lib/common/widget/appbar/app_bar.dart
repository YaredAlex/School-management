import 'package:flutter/material.dart';
import 'package:school_managment/util/sizes.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  CAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.showLoading = true,
  });
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CSizes.itemSpacing),
      child: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: kToolbarHeight,
        centerTitle: false,
        automaticallyImplyLeading: true,
        leadingWidth: 40,
        title: title != null
            ? Text(
                title!,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: Colors.white),
              )
            : null,
        leading: leading != null
            ? leading
            : showLoading
                ? IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  )
                : null,
        actions: [
          //Notification
          IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {},
              icon: const Icon(Icons.notifications)),
          //User
          // IconButton(
          //     visualDensity: VisualDensity.compact,
          //     onPressed: () {},
          //     icon: const CircleAvatar(
          //       backgroundColor: Color.fromARGB(255, 150, 132, 248),
          //       radius: 25,
          //     )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
