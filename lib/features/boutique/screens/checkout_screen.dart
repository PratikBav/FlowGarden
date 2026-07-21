import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/providers/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    // Simulate payment processing
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        ref.read(cartProvider.notifier).clearCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: Center(
        child: _isProcessing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.forestGreen),
                  const SizedBox(height: 24),
                  Text(
                    'Processing your order...',
                    style: AppTypography.title,
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1200.ms, color: AppColors.forestGreen.withOpacity(0.5)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, size: 80, color: AppColors.forestGreen)
                      .animate()
                      .scale(duration: 500.ms, curve: Curves.elasticOut),
                  const SizedBox(height: 24),
                  Text(
                    'Order Confirmed!',
                    style: Theme.of(context).textTheme.headlineLarge,
                  )
                  .animate()
                  .fade(duration: 500.ms)
                  .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Thank you for your purchase. A confirmation email will be sent shortly.',
                      style: AppTypography.body,
                      textAlign: TextAlign.center,
                    )
                    .animate(delay: 200.ms)
                    .fade(duration: 500.ms),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: PrimaryButton(
                      text: 'Return to Boutique',
                      onPressed: () {
                        context.go('/home');
                      },
                    )
                    .animate(delay: 400.ms)
                    .fade(duration: 500.ms),
                  ),
                ],
              ),
      ),
    );
  }
}
