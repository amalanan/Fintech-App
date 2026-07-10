import 'package:flutter/material.dart';

/// أسماء ملفات الصور — حطي صورك بمجلد assets/images/ بنفس هالأسامي
/// (أو غيّري الأسامي هون لتطابق ملفاتك انتِ)
class IllustrationAssets {
  static const String splash = 'assets/illustrations/splash.png';
  static const String welcome = 'assets/illustrations/onBoarding1.png';
  static const String security = 'assets/illustrations/onBoarding2.png';
  static const String market = 'assets/illustrations/onBoarding3.png';
  static const String getStarted = 'assets/illustrations/onBoarding4.png';
  static const String rightCheck = 'assets/illustrations/Right.png';
}

/// ويدجت موحّد لعرض صورة الرسم التوضيحي
/// - إذا الصورة مش موجودة بعد (لسا ما ضفتيها)، بيظهر مكانها placeholder
///   رمادي فيه أيقونة صورة، بدل ما يطلع كراش أحمر بنص الشاشة.
class AppIllustration extends StatelessWidget {
  final String assetPath;
  final double height;
  final double width;
  final BoxFit fit;

  const AppIllustration({
    super.key,
    required this.assetPath,
    this.height = 220,
    this.width = 220,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(
        assetPath,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.image_outlined, size: 42, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}

/// 1) شاشة السبلاش
class SplashIllustration extends StatelessWidget {
  final bool isDark; // تركتها موجودة لأنها مستخدمة بـ splash_screen.dart
  const SplashIllustration({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return const AppIllustration(
      assetPath: IllustrationAssets.splash,
      height: 200,
      width: 200,
    );
  }
}

/// 2) Welcome to Crypto X
class WelcomeIllustration extends StatelessWidget {
  const WelcomeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppIllustration(assetPath: IllustrationAssets.welcome);
  }
}

/// 3) Transaction Security
class SecurityIllustration extends StatelessWidget {
  const SecurityIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppIllustration(assetPath: IllustrationAssets.security);
  }
}

/// 4) Fast And Reliable Market
class MarketIllustration extends StatelessWidget {
  const MarketIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppIllustration(assetPath: IllustrationAssets.market);
  }
}

/// 5) Get Started Now
class GetStartedIllustration extends StatelessWidget {
  const GetStartedIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppIllustration(assetPath: IllustrationAssets.getStarted);
  }
}
