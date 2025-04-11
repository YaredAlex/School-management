import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/library/controller/library_controller.dart';
import 'package:school_managment/features/library/model/books.dart';
import 'package:school_managment/features/library/view/book_card.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/sizes.dart';

class LibraryScreen extends StatelessWidget {
  LibraryScreen({super.key});
  final double height = 160;
  final controller = Get.put(LibraryController());
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
                  title: CTexts.library,
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 24, right: 24, bottom: 16),
                    child: TextField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(CSizes.mdRadius),
                              borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(8),
                          prefixIcon: const Icon(
                            Iconsax.search_normal_1,
                            color: Colors.white,
                          ),
                          hintText: "Search courses or books",
                          fillColor: Colors.white.withOpacity(0.2),
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                          filled: true),
                      onSubmitted: (text) {
                        controller.filterBooks(text);
                      },
                    )),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CColors.backgroundDark
                    : CColors.backgroundPrimary,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //courseCard
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? CColors.backgroundDark
                    : CColors.backgroundPrimary,
              ),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var category in controller.categories)
                        _buildBookSection(
                            category: category,
                            books: controller.booksByCategory[category] ?? [],
                            context: context),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookSection(
      {required String category,
      required List<Book> books,
      required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(book: books[index]);
            },
          ),
        ),
      ],
    );
  }
}
