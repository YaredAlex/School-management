import 'package:flutter/material.dart';
import 'package:school_managment/common/widget/loading_indicator/circular_loading.dart';

import 'package:school_managment/util/constants/colors/colors.dart';

/// A non-dismissible loading dialog that shows a message and the minimal loading indicator
class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog(
      {Key? key, this.message = 'Please wait while processing...'})
      : super(key: key);

  /// Show a non-dismissible loading dialog
  static Future<void> show(BuildContext context,
      {String message = 'Please wait while processing...'}) {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Dialog cannot be dismissed by tapping outside
      builder: (BuildContext context) {
        return LoadingDialog(message: message);
      },
    );
  }

  /// Hide the loading dialog
  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        elevation: 8,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularLoadingIndicator(),
              const SizedBox(height: 24),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
