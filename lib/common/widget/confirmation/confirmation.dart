import 'package:flutter/material.dart';
import 'package:school_managment/util/device/device.dart';

/// A customizable confirmation dialog component.
///
/// This dialog presents a message to the user with confirmation and cancel options.
/// It's fully customizable and provides a clean, modern design out of the box.
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;

  final String confirmButtonText;

  final String cancelButtonText;

  final VoidCallback? onConfirm;

  final VoidCallback? onCancel;

  final bool isDestructive;

  final IconData? icon;

  final Color? iconColor;

  final Duration animationDuration;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmButtonText = 'Yes',
    this.cancelButtonText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
    this.icon,
    this.iconColor,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : super(key: key);

  /// Static method to show the confirmation dialog
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmButtonText = 'Yes',
    String cancelButtonText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDestructive = false,
    IconData? icon,
    Color? iconColor,
    Duration animationDuration = const Duration(milliseconds: 250),
  }) async {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Confirmation Dialog',
      transitionDuration: animationDuration,
      pageBuilder: (context, animation1, animation2) {
        return Container(); // Not used but required
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity:
                Tween<double>(begin: 0.5, end: 1.0).animate(curvedAnimation),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: ConfirmationDialog(
                title: title,
                message: message,
                confirmButtonText: confirmButtonText,
                cancelButtonText: cancelButtonText,
                onConfirm: onConfirm != null
                    ? () {
                        Navigator.of(context).pop(true);
                        onConfirm();
                      }
                    : () => Navigator.of(context).pop(true),
                onCancel: onCancel != null
                    ? () {
                        Navigator.of(context).pop(false);
                        onCancel();
                      }
                    : () => Navigator.of(context).pop(false),
                isDestructive: isDestructive,
                icon: icon,
                iconColor: iconColor,
              ),
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final confirmColor =
        isDestructive ? Colors.red[700] : theme.colorScheme.primary;

    return Container(
      width: deviceWidth(context) * 0.8,
      constraints: BoxConstraints(maxWidth: deviceWidth(context) * 0.8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title section
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            // Icon (if provided)
            if (icon != null) ...[
              const SizedBox(height: 24),
              Icon(
                icon,
                size: 64,
                color: iconColor ?? confirmColor,
              ),
            ],

            // Message
            const SizedBox(height: 16),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel button
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: theme.dividerColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(cancelButtonText),
                  ),
                ),
                const SizedBox(width: 16),

                // Confirm button
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: confirmColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      confirmButtonText,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
