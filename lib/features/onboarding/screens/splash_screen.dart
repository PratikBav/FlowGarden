import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 200,
            )
            .animate()
            .fade(duration: 1.seconds, curve: Curves.easeIn)
            .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0), curve: Curves.elasticOut, duration: 1500.ms)
            .shimmer(delay: 800.ms, duration: 1200.ms, color: AppColors.forestGreen.withValues(alpha: 0.3))
            .then(delay: 500.ms)
            .slideY(end: -0.2, curve: Curves.easeInOutCubic, duration: 800.ms),
            const SizedBox(height: 24),
            Text(
              'THE FLOW GARDEN',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                letterSpacing: 4.0,
                fontSize: 24,
              ),
            )
            .animate(delay: 1500.ms)
            .fade(duration: 800.ms)
            .slideY(begin: 0.5, end: 0, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }
}
