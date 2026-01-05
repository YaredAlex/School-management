import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/util/constants/colors/colors.dart';

class NoTimeTableCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onRefresh;

  const NoTimeTableCard({
    Key? key,
    this.message = 'No timetable found',
    this.icon = Icons.event_busy,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Get.isDarkMode ? CColors.cardBgDark : Colors.white,
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // side: BorderSide(
        //   color: Get.isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
        //   width: 1,
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[800],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'There are no scheduled classes to display at this time',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// Usage example
class TimeTableEmptyState extends StatelessWidget {
  final VoidCallback? onRefresh;

  const TimeTableEmptyState({Key? key, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: NoTimeTableCard(
          message: 'No classes scheduled',
          onRefresh: onRefresh,
        ),
      ),
    );
  }
}
