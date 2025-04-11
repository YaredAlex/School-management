import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MinimalLoadingIndicator extends StatefulWidget {
  const MinimalLoadingIndicator({Key? key}) : super(key: key);

  @override
  State<MinimalLoadingIndicator> createState() =>
      _MinimalLoadingIndicatorState();
}

class _MinimalLoadingIndicatorState extends State<MinimalLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 2,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: LoadingPainter(value: _controller.value),
            size: const Size(80, 2),
          );
        },
      ),
    );
  }
}

class LoadingPainter extends CustomPainter {
  final double value;

  LoadingPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    // Background line
    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      backgroundPaint,
    );

    // Animated line
    final foregroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Animate a line that grows from left to right, then shrinks from left to right
    double start;
    double end;

    if (value < 0.5) {
      // Growing phase (0.0 to 0.5)
      start = 0;
      end = size.width * (value * 2);
    } else {
      // Shrinking phase (0.5 to 1.0)
      start = size.width * ((value - 0.5) * 2);
      end = size.width;
    }

    canvas.drawLine(
      Offset(start, size.height / 2),
      Offset(end, size.height / 2),
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant LoadingPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
