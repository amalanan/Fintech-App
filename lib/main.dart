import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

/// للتحكم بالوضع (لايت/دارك) من أي مكان بالتطبيق أثناء العرض التجريبي.
/// بمشروعك الحقيقي ممكن تربطه مع shared_preferences أو provider/riverpod.
final ValueNotifier<ThemeMode> themeModeNotifier =
ValueNotifier(ThemeMode.system);

void main() {
  runApp(const CryptoXApp());
}

class CryptoXApp extends StatelessWidget {
  const CryptoXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Crypto X',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
