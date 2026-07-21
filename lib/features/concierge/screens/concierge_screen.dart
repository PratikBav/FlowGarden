import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';

class ConciergeScreen extends StatelessWidget {
  const ConciergeScreen({super.key});

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
            title: Text('Concierge', style: AppTypography.title),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1578683010236-d716f9a3f461?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.charcoalBlack.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Your Personal Lifestyle Manager',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: AppColors.primaryWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bespoke Services',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'From private jet charters to exclusive restaurant reservations, our concierge team is available 24/7 to fulfill your every request.',
                        style: AppTypography.body,
                      ),
                      const SizedBox(height: 32),
                      _buildServiceItem('Travel Arrangements', Icons.flight_takeoff),
                      const SizedBox(height: 16),
                      _buildServiceItem('Private Events', Icons.event),
                      const SizedBox(height: 16),
                      _buildServiceItem('Dining Reservations', Icons.restaurant),
                      const SizedBox(height: 16),
                      _buildServiceItem('Personal Shopping', Icons.shopping_bag),
                      const SizedBox(height: 40),
                      PrimaryButton(
                        text: 'Request Service',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warmWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondaryGold, size: 28),
          const SizedBox(width: 16),
          Text(title, style: AppTypography.body.copyWith(fontWeight: FontWeight.w600)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: AppColors.charcoalBlack),
        ],
      ),
    );
  }
}
