import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/buttons/secondary_button.dart';

class ClubScreen extends StatelessWidget {
  const ClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primaryWhite,
            elevation: 0,
            pinned: true,
            title: Text('The Club', style: AppTypography.title),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.workspace_premium, size: 80, color: AppColors.secondaryGold),
                  const SizedBox(height: 24),
                  Text(
                    'Exclusive Membership',
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Join an exclusive community of like-minded individuals. Gain priority access to retreats, private events, and our dedicated lifestyle managers.',
                    style: AppTypography.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  _buildPricingCard(
                    context,
                    title: 'Annual Membership',
                    price: 'CHF 2,500',
                    features: [
                      'Priority booking for all events',
                      '24/7 Concierge access',
                      'Exclusive member-only dinners',
                      'Complimentary wellness assessment',
                    ],
                    isPopular: true,
                  ),
                  const SizedBox(height: 24),
                  _buildPricingCard(
                    context,
                    title: 'Monthly Membership',
                    price: 'CHF 250',
                    features: [
                      'Standard booking access',
                      'Business hours Concierge access',
                      'Member community access',
                    ],
                    isPopular: false,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(BuildContext context, {required String title, required String price, required List<String> features, required bool isPopular}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isPopular ? AppColors.charcoalBlack : AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isPopular ? AppColors.charcoalBlack : AppColors.lightGrey),
        boxShadow: isPopular
            ? [BoxShadow(color: AppColors.charcoalBlack.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondaryGold,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'MOST POPULAR',
                style: AppTypography.caption.copyWith(color: AppColors.charcoalBlack, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            title,
            style: AppTypography.title.copyWith(color: isPopular ? AppColors.primaryWhite : AppColors.charcoalBlack),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: isPopular ? AppColors.primaryWhite : AppColors.charcoalBlack),
          ),
          const SizedBox(height: 24),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 20, color: isPopular ? AppColors.secondaryGold : AppColors.forestGreen),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: AppTypography.body.copyWith(color: isPopular ? AppColors.primaryWhite : AppColors.charcoalBlack),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          isPopular
              ? PrimaryButton(
                  text: 'Apply Now',
                  onPressed: () {},
                  backgroundColor: AppColors.secondaryGold,
                  textColor: AppColors.charcoalBlack,
                )
              : SecondaryButton(
                  text: 'Learn More',
                  onPressed: () {},
                ),
        ],
      ),
    );
  }
}
