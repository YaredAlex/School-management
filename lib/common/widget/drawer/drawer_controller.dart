import 'package:get/get.dart';

class CDrawerController extends GetxController {
  var selectedIndex = 0.obs;
  final drawingList = [
    {
      'title': "Profile",
      'onTap': () {},
    }
  ];
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
