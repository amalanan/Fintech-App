import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/illustrations.dart';
import '../main.dart';

class _OnboardingData {
  final Widget illustration;
  final String title;
  final bool showSkip;

  _OnboardingData({
    required this.illustration,
    required this.title,
    this.showSkip = false,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  late final List<_OnboardingData> _pages = [
    _OnboardingData(
      illustration: const WelcomeIllustration(),
      title: 'Welcome To Crypto X',
      showSkip: false,
    ),
    _OnboardingData(
      illustration: const SecurityIllustration(),
      title: 'Transaction Security',
      showSkip: true,
    ),
    _OnboardingData(
      illustration: const MarketIllustration(),
      title: 'Fast And Reliable Market Updated',
      showSkip: true,
    ),
    _OnboardingData(
      illustration: const GetStartedIllustration(),
      title: 'Get Started Now!',
      showSkip: false,
    ),
  ];

  bool get _isLastPage => _currentPage == _pages.length - 1;

  void _goToNext() {
    if (_isLastPage) return;
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _skipToEnd() {
    _controller.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي: زر تبديل الوضع (لايت/دارك) + زر Skip
            SizedBox(
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IconButton(
                      onPressed: () {
                        themeModeNotifier.value =
                            isDark ? ThemeMode.light : ThemeMode.dark;
                      },
                      icon: Icon(
                        isDark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        color: textColor.withOpacity(0.7),
                        size: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child:
                        _pages[_currentPage].showSkip
                            ? TextButton(
                              onPressed: _skipToEnd,
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  color: textColor.withOpacity(0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: page.illustration),
                        const SizedBox(height: 48),
                        Text(
                          page.title,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 28),
              child:
                  _isLastPage
                      ? Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // TODO: انتقل لشاشة تسجيل الدخول
                            },
                            child: const Text('Login'),
                          ),
                          const SizedBox(height: 14),
                          OutlinedButton(
                            onPressed: () {
                              // TODO: انتقل لشاشة إنشاء حساب
                            },
                            child: const Text('Register'),
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _DashIndicator(
                            count: _pages.length,
                            currentIndex: _currentPage,
                            isDark: isDark,
                          ),
                          _NextButton(onTap: _goToNext),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

/// مؤشر التقدم على شكل شرطات (dashes) متل التصميم الأصلي
class _DashIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final bool isDark;

  const _DashIndicator({
    required this.count,
    required this.currentIndex,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDark ? AppColors.accentBlue : AppColors.primaryNavy;
    final inactiveColor =
        isDark ? AppColors.darkDashInactive : AppColors.lightDashInactive;

    return Row(
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(right: 6),
          width: isActive ? 22 : 10,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

/// زر التالي الدائري
class _NextButton extends StatelessWidget {
  final VoidCallback onTap;

  const _NextButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppColors.accentBlue : AppColors.primaryNavy;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: const Icon(
          Icons.arrow_forward_ios,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
