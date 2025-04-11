import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/loading_indicator/minimal_loading.dart';
import 'package:school_managment/features/auth/controller/auth_controller.dart';
import 'package:school_managment/util/device/device.dart';
import 'package:school_managment/util/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _showLoading = false;
  final AuthController authController = Get.find();

  @override
  void initState() {
    //check if user have valid token
    authController.checkCredential();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Delay to allow native splash to settle
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward().then((_) {
        setState(() {
          _showLoading = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF6E57EB), // Exactly match splash color
        width: deviceWidth(context),
        height: deviceHeight(context),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Matching logo, center-aligned
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: Image.asset(
                    CImageConstant.logo, // Same as flutter_native_splash image
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // App Name
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  "Tech Academy",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Tagline
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  "Learning Without Limits",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const Spacer(flex: 2),

              if (_showLoading) const MinimalLoadingIndicator(),
              if (_showLoading) const SizedBox(height: 16),
              if (_showLoading)
                const Text(
                  "Verifying your account",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
