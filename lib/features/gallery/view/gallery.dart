import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/grdi_view/grid_view.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/gallery/controller/gallery_controller.dart';
import 'package:school_managment/features/gallery/view/full_screen_view.dart';
import 'package:school_managment/util/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class GalleryScreen extends StatelessWidget {
  final GalleryController controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CHeaderSection(
              height: CSizes.topBarHeight,
              childern: [
                CAppBar(
                  title: "Gallery",
                  showLoading: false,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CColors.backgroundDark
                    : CColors.backgroundPrimary,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
                child: Column(
                  children: [
                    Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.events.length,
                          itemBuilder: (context, index) {
                            final event = controller.events[index];
                            return Card(
                              elevation: 0,
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event['title'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Date: ${event['date']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        SizedBox(height: 8),
                                        Text(event['description']),
                                      ],
                                    ),
                                  ),
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      int crossAxisCount =
                                          constraints.maxWidth > 600 ? 3 : 2;
                                      int itemCount = event['images'].length;
                                      int rowCount =
                                          (itemCount / crossAxisCount).ceil();

                                      // Calculate the height of the grid
                                      double aspectRatio =
                                          1.0; // Assuming square images
                                      double spacing =
                                          8.0; // This should match your gridDelegate's spacing
                                      double itemHeight =
                                          (constraints.maxWidth /
                                                  crossAxisCount) *
                                              aspectRatio;
                                      double totalSpacing =
                                          (rowCount - 1) * spacing;
                                      double gridHeight =
                                          (itemHeight * rowCount) +
                                              totalSpacing;

                                      return SizedBox(
                                        height: gridHeight,
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,
                                            childAspectRatio: aspectRatio,
                                            crossAxisSpacing: spacing,
                                            mainAxisSpacing: spacing,
                                          ),
                                          itemCount: itemCount,
                                          itemBuilder: (context, imageIndex) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(() =>
                                                    FullScreenImageView(
                                                      images: event['images'],
                                                      initialIndex: imageIndex,
                                                    ));
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl: event['images']
                                                    [imageIndex],
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
