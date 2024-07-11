import 'package:get/get.dart';

class GalleryController extends GetxController {
  final RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void fetchEvents() {
    // Simulating API call or database fetch
    events.value = [
      {
        'title': 'Summer Festival',
        'date': '2024-07-15',
        'description': 'Annual summer celebration with music and food.',
        'images': [
          'https://149420097.v2.pressablecdn.com/wp-content/uploads/2021/02/web-BG-Feb-2021-1-1024x758.jpg',
          'https://resources.finalsite.net/images/f_auto,q_auto,t_image_size_2/v1664431955/icsaddiseduet/kiwip5nqotygdg6mxqyl/0T4A4007.jpg',
          'https://eng.yidaiyilu.gov.cn/wcm.files/upload/CMSydylyw/202206/202206020340028.jpg',
        ]
      },
      {
        'title': 'Science Fair',
        'date': '2024-08-20',
        'description': 'Showcasing student projects and innovations.',
        'images': [
          'https://images.squarespace-cdn.com/content/v1/5a539a8918b27dae0bc53f3c/1652889398042-HGPFU807LDRXZTG0LVQ2/660A6016.jpg',
          'https://images.squarespace-cdn.com/content/v1/5a539a8918b27dae0bc53f3c/1652889398042-HGPFU807LDRXZTG0LVQ2/660A6016.jpg',
        ]
      },
      // Add more events as needed
    ];
  }
}
