import 'package:flutter/material.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/utils/widgets/app_background_widget.dart';
import 'package:todo_list/utils/widgets/first_onboarding_decoration_widget.dart';
import 'package:todo_list/views/home/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPageData {
  final Widget? decoration;
  final String title;
  final String description;

  const OnboardingPageData({
    this.decoration,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  final Widget Function()? ctaTrailingIconBuilder;

  const OnboardingScreen({
    super.key,
    this.ctaTrailingIconBuilder,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      decoration: FirstOnboardingDecorations(),
      title: 'Task Management &\n To-Do List',
      description:
          'This productive tool is designed to help\n you better manage your task\n project-wise conveniently!',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('seenOnboarding', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) => setState(() => currentPage = index),
            itemBuilder: (context, index) {
              final page = pages[index];
              return LayoutBuilder(
                builder: (context, constraints) {
                  final isLandscapeOrTablet =
                      constraints.maxWidth > 600 ||
                      MediaQuery.of(context).orientation == Orientation.landscape;

                  if (isLandscapeOrTablet) {
                    return _LandscapePage(
                      page: page,
                      index: index,
                      pagesLength: pages.length,
                      onFinish: _finishOnboarding,
                      ctaTrailingIconBuilder: widget.ctaTrailingIconBuilder,
                    );
                  }

                  return _PortraitPage(
                    page: page,
                    index: index,
                    pagesLength: pages.length,
                    onFinish: _finishOnboarding,
                    ctaTrailingIconBuilder: widget.ctaTrailingIconBuilder,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─── Portrait layout ──────────────────────────────────────────────────────────

class _PortraitPage extends StatelessWidget {
  final OnboardingPageData page;
  final int index;
  final int pagesLength;
  final VoidCallback onFinish;
  final Widget Function()? ctaTrailingIconBuilder;

  const _PortraitPage({
    required this.page,
    required this.index,
    required this.pagesLength,
    required this.onFinish,
    this.ctaTrailingIconBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final hasCta = index == pagesLength - 1;
        // Reserve space for text, button, and vertical gaps, then use the rest for decoration.
        final reservedHeight = hasCta ? 250.0 : 180.0;
        final decorationHeight = (constraints.maxHeight - reservedHeight).clamp(180.0, 460.0);

        return ClipRect(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (page.decoration != null)
                      SizedBox(
                        height: decorationHeight,
                        child: page.decoration!,
                      ),
                    const SizedBox(height: 24),
                    _TextBlock(page: page),
                    const SizedBox(height: 40),
                    if (index == pagesLength - 1)
                      _CtaButton(onFinish: onFinish, ctaTrailingIconBuilder: ctaTrailingIconBuilder),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Landscape / tablet layout ────────────────────────────────────────────────

class _LandscapePage extends StatelessWidget {
  final OnboardingPageData page;
  final int index;
  final int pagesLength;
  final VoidCallback onFinish;
  final Widget Function()? ctaTrailingIconBuilder;

  const _LandscapePage({
    required this.page,
    required this.index,
    required this.pagesLength,
    required this.onFinish,
    this.ctaTrailingIconBuilder,
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Illustration on the left half
          if (page.decoration != null)
            Expanded(
              child: ClipRect(child: page.decoration!),
            ),
          const SizedBox(width: 32),
          // Text + CTA on the right half
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TextBlock(page: page),
                const SizedBox(height: 40),
                if (index == pagesLength - 1)
                  _CtaButton(onFinish: onFinish, ctaTrailingIconBuilder: ctaTrailingIconBuilder),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared sub-widgets ───────────────────────────────────────────────────────

class _TextBlock extends StatelessWidget {
  final OnboardingPageData page;
  const _TextBlock({required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: AppTheme.onboardingTitle,
        ),
        const SizedBox(height: 16),
        Text(
          page.description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CtaButton extends StatelessWidget {
  final VoidCallback onFinish;
  final Widget Function()? ctaTrailingIconBuilder;
  const _CtaButton({required this.onFinish, this.ctaTrailingIconBuilder});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppTheme.themeLavender),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      onPressed: onFinish,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Let's Start",
                style: AppTheme.buttonText.copyWith(color: AppTheme.themeWhite),
              ),
            ),
          ),
          if (ctaTrailingIconBuilder != null) ctaTrailingIconBuilder!(),
        ],
      ),
    );
  }
}
