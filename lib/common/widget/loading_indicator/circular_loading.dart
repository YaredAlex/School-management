import 'package:flutter/material.dart';
import 'package:school_managment/util/constants/colors/colors.dart';

class CircularLoadingIndicator extends StatefulWidget {
  const CircularLoadingIndicator({super.key});

  @override
  State<CircularLoadingIndicator> createState() =>
      _MinimalLoadingIndicatorState();
}

class _MinimalLoadingIndicatorState extends State<CircularLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(); // Infinite rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 6.28319, // 2 * pi radians
          child: child,
        );
      },
      child: Container(
        width: 36,
        height: 36,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              CColors.primary,
              CColors.primary.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            CColors.primary, // A contrasting color to your background
          ),
        ),
      ),
    );
  }
}
