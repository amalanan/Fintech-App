import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/illustrations.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SplashIllustration(isDark: isDark),
              ),
            ),
            // الخط السفلي الصغير (Home indicator) متل التصميم الأصلي
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Container(
                width: 120,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkTextPrimary.withOpacity(0.6)
                      : AppColors.lightTextPrimary.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
