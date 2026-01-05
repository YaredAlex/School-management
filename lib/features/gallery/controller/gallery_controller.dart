import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/error/show_error.dart';
import 'package:school_managment/features/communication/model/gallery_model.dart';
import 'package:school_managment/util/constants/api_endpoints/api_endpoints.dart';
import 'package:school_managment/util/services/api_controller.dart';

class GalleryController extends GetxController {
  final RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[].obs;
  RxList<GalleryModel> gallery = RxList<GalleryModel>([]);
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchGallerImage();
  }

  @override
  void onReady() {
    super.onStart();
  }

  Future<void> fetchGallerImage() async {
    try {
      final res = await ApiService().get(CAPIEndPoint.gallery);
      final galleryData = <GalleryModel>[];
      final images = <String>[];
      for (var json in res['results']) {
        galleryData.add(GalleryModel.fromJson(json));
        images.add(json['image']);
      }
      events.value = [
        {'title': 'School Gallery', 'description': '', 'images': images},
      ];
      gallery.value = galleryData;
    } catch (e) {
      debugPrint(e.toString());
      showErrorPopup(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // void fetchEvents() {
  //   events.value = [
  //     {
  //       'title': 'Summer Festival',
  //       'date': '2024-07-15',
  //       'description': 'Annual summer celebration with music and food.',
  //       'images': [
  //         'https://149420097.v2.pressablecdn.com/wp-content/uploads/2021/02/web-BG-Feb-2021-1-1024x758.jpg',
  //         'https://resources.finalsite.net/images/f_auto,q_auto,t_image_size_2/v1664431955/icsaddiseduet/kiwip5nqotygdg6mxqyl/0T4A4007.jpg',
  //         'https://eng.yidaiyilu.gov.cn/wcm.files/upload/CMSydylyw/202206/202206020340028.jpg',
  //       ]
  //     },
  //   ];
  // }
}
