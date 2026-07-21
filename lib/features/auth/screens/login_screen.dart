import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/inputs/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.charcoalBlack),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/onboarding');
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to access your luxury lifestyle hub.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.charcoalBlack.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 48),
              const CustomTextField(
                hintText: 'Email Address',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                hintText: 'Password',
                obscureText: true,
                prefixIcon: Icon(Icons.lock_outline),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: AppTypography.buttonText.copyWith(color: AppColors.forestGreen),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Sign In',
                onPressed: () {
                  context.go('/home');
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?', style: AppTypography.body),
                  TextButton(
                    onPressed: () {},
                    child: Text('Register', style: AppTypography.buttonText.copyWith(color: AppColors.forestGreen)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
