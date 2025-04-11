import 'package:flutter/material.dart';

/// A popup dialog to display error messages with a dismiss button
class ErrorPopup extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback? onDismiss;
  final String? title;

  const ErrorPopup({
    Key? key,
    required this.message,
    this.buttonText = 'Dismiss',
    this.onDismiss,
    this.title,
  }) : super(key: key);

  /// Static method to show the error popup
  static void show(
    BuildContext context, {
    required String message,
    String buttonText = 'Dismiss',
    VoidCallback? onDismiss,
    String? title,
  }) {
    showDialog(
      context: context,
      builder: (context) => ErrorPopup(
        message: message,
        buttonText: buttonText,
        onDismiss: onDismiss,
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Error Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 40,
              color: Colors.red[700],
            ),
          ),
          const SizedBox(height: 16),

          // Title
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red[800],
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Message
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),

          // Dismiss Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onDismiss != null) {
                  onDismiss!();
                }
              },
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

/// An inline error message widget to display within the UI flow
class InlineErrorMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final VoidCallback? onDismiss;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const InlineErrorMessage({
    Key? key,
    required this.message,
    this.icon = Icons.error_outline,
    this.onDismiss,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: Colors.red[700],
                  size: 20,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 14,
                  ),
                ),
              ),
              if (onDismiss != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.close,
                    color: Colors.red[700],
                    size: 18,
                  ),
                  onPressed: onDismiss,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Example of how to use these widgets
class ErrorWidgetDemo extends StatelessWidget {
  const ErrorWidgetDemo({Key? key}) : super(key: key);

  void _showErrorPopup(BuildContext context) {
    ErrorPopup.show(
      context,
      title: 'Connection Error',
      message:
          'Unable to connect to the server. Please check your internet connection and try again.',
      onDismiss: () {
        // Handle dismiss callback
        debugPrint('Error popup dismissed');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Widget Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _showErrorPopup(context),
              child: const Text('Show Error Popup'),
            ),
            const SizedBox(height: 20),
            const InlineErrorMessage(
              message:
                  'Invalid email address format. Please enter a valid email address.',
            ),
            const SizedBox(height: 16),
            InlineErrorMessage(
              message: 'Your password must be at least 8 characters long.',
              onDismiss: () {
                debugPrint('Inline error dismissed');
              },
            ),
          ],
        ),
      ),
    );
  }
}
