import 'package:flutter/material.dart';

class PopupMessage extends StatelessWidget {
  final String title;
  final String message;
  final bool success;
  final Duration duration;
  final bool showCloseButton;
  final VoidCallback? onDismiss;

  const PopupMessage({
    Key? key,
    required this.title,
    required this.message,
    this.success = true,
    this.duration = const Duration(seconds: 2),
    this.showCloseButton = true,
    this.onDismiss,
  }) : super(key: key);

  void _close(BuildContext context, [bool? result]) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(result);
    }
    onDismiss?.call();
  }

  @override
  Widget build(BuildContext context) {
    final icon = success ? Icons.check_circle_outline : Icons.error_outline;
    final color = success ? Color(0xff007B45) : Color(0xffC3211D);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) onDismiss?.call();
      },
      child: Material(
        color: Colors.black45,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 56, color: color),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (message.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _close(context, true),
                        child: const Text('OK'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
