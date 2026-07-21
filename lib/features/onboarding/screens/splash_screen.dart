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
            .fade(duration: 1.seconds)
            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0), curve: Curves.easeOutCubic),
            const SizedBox(height: 24),
            Text(
              'THE FLOW GARDEN',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                letterSpacing: 4.0,
                fontSize: 24,
              ),
            )
            .animate(delay: 500.ms)
            .fade(duration: 800.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }
}
