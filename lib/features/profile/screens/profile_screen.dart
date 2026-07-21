import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/secondary_button.dart';
import '../../../core/providers/cart_provider.dart';
import '../../../core/providers/bookings_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsCount = ref.watch(cartProvider).length;
    final bookingsCount = ref.watch(bookingsProvider).length;

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: Text('PROFILE', style: AppTypography.title.copyWith(letterSpacing: 2.0)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.warmWhite,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
            ),
            const SizedBox(height: 16),
            Text('Pratik', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24)),
            const SizedBox(height: 4),
            Text('pratik@gmail.com', style: AppTypography.caption),
            const SizedBox(height: 32),
            _buildProfileMenuItem(
              context, 
              Icons.shopping_bag_outlined, 
              'My Cart', 
              badgeCount: cartItemsCount > 0 ? cartItemsCount : null,
              onTap: () => context.push('/cart'),
            ),
            _buildProfileMenuItem(context, Icons.favorite_outline, 'Wishlist'),
            _buildProfileMenuItem(
              context, 
              Icons.calendar_today_outlined, 
              'My Bookings',
              badgeCount: bookingsCount > 0 ? bookingsCount : null,
            ),
            _buildProfileMenuItem(context, Icons.card_membership, 'Club Membership', onTap: () => context.push('/club')),
            _buildProfileMenuItem(context, Icons.settings_outlined, 'Settings'),
            const SizedBox(height: 32),
            SecondaryButton(
              text: 'Log Out',
              onPressed: () {
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(BuildContext context, IconData icon, String title, {int? badgeCount, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.charcoalBlack),
      title: Row(
        children: [
          Text(title, style: AppTypography.body),
          if (badgeCount != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.secondaryGold,
                shape: BoxShape.circle,
              ),
              child: Text(
                badgeCount.toString(),
                style: const TextStyle(color: AppColors.charcoalBlack, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.lightGrey),
      contentPadding: EdgeInsets.zero,
      onTap: onTap ?? () {},
    );
  }
}
