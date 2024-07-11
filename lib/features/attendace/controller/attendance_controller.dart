import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final RxList<Map<String, dynamic>> absentDates = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAbsentDates();
  }

  void fetchAbsentDates() {
    // Simulating API call or database fetch
    absentDates.value = [
      {'date': '2024-07-01', 'reason': 'Sick'},
      {'date': '2024-07-05', 'reason': 'Family emergency'},
      {'date': '2024-07-10', 'reason': 'Doctor appointment'},
    ];
  }
}
