import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_managment/common/widget/appbar/app_bar.dart';
import 'package:school_managment/common/widget/header_section/header_section.dart';
import 'package:school_managment/features/time_table/controller/time_table_controller.dart';
import 'package:school_managment/features/time_table/model/time_table_model.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/sizes.dart';

class TimeTableScreen extends StatelessWidget {
  TimeTableScreen({Key? key}) : super(key: key);

  final double height = CSizes.topBarHeight;
  final TimeTableController controller = Get.put(TimeTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CHeaderSection(
            height: height,
            childern: [
              CAppBar(
                showLeading: false,
                title: CTexts.timeTable,
              ),
              // _buildDateSelector(context),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? CColors.backgroundDark
                  : CColors.backgroundPrimary,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
              child: Container(
                color: Get.isDarkMode ? CColors.backgroundDark : Colors.white,
                child: RefreshIndicator(
                  onRefresh: controller.onRefresh,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: controller.weeklyTimeTable.entries.map((entry) {
                      return _buildDayExpansionTile(
                          context: context,
                          day: entry.key,
                          entries: entry.value);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Obx(() {
      final date = controller.selectedDate.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 32,
            ),
            onPressed: () => controller.changeDate(-1),
          ),
          Text(
            DateFormat('MMMM d, yyyy').format(date),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: Colors.white),
          ),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              size: 32,
            ),
            onPressed: () => controller.changeDate(1),
          ),
        ],
      );
    });
  }

  Widget _buildDayExpansionTile(
      {required BuildContext context,
      required String day,
      required List<TimeTableEntry> entries}) {
    // Sort entries by start time
    entries.sort((a, b) =>
        a.startTime.hour * 60 +
        a.startTime.minute -
        (b.startTime.hour * 60 + b.startTime.minute));

    return ExpansionTile(
      title: Text(day, style: Theme.of(context).textTheme.titleMedium),
      children: entries.map((entry) => _buildTimeTableCard(entry)).toList(),
      initiallyExpanded: true,
      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      childrenPadding: EdgeInsets.zero,
      shape: Border.all(
          color: Colors.transparent), // Removes the border when expanded
      collapsedShape: Border(
        bottom: BorderSide(
          color: Get.isDarkMode ? CColors.borderDark : CColors.borderLight,
          width: 1.0,
        ),
      ),
    );
  }

  Widget _buildTimeTableCard(TimeTableEntry entry) {
    return Card(
      elevation: 0,
      color: Get.isDarkMode ? CColors.cardBgDark : Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        title:
            Text(entry.subject, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_getTimeRangeString(entry)),
            if (entry.teacher != null) Text('Teacher: ${entry.teacher}'),
          ],
        ),
        trailing: Text(_getTimeLengthString(entry)),
      ),
    );
  }

  String _getTimeRangeString(TimeTableEntry entry) {
    return '${_formatTimeOfDay(entry.startTime)} - ${_formatTimeOfDay(entry.endTime)}';
  }

  String _getTimeLengthString(TimeTableEntry entry) {
    final startMinutes = entry.startTime.hour * 60 + entry.startTime.minute;
    final endMinutes = entry.endTime.hour * 60 + entry.endTime.minute;
    final lengthMinutes = endMinutes - startMinutes;
    final hours = lengthMinutes ~/ 60;
    final minutes = lengthMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dateTime);
  }
}
