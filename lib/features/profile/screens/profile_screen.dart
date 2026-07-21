import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/secondary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
            ),
            const SizedBox(height: 16),
            Text('Eleanor Shellstrop', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24)),
            const SizedBox(height: 4),
            Text('eleanor@example.com', style: AppTypography.caption),
            const SizedBox(height: 32),
            _buildProfileMenuItem(context, Icons.shopping_bag_outlined, 'My Orders'),
            _buildProfileMenuItem(context, Icons.favorite_outline, 'Wishlist'),
            _buildProfileMenuItem(context, Icons.calendar_today_outlined, 'My Bookings'),
            _buildProfileMenuItem(context, Icons.card_membership, 'Club Membership'),
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

  Widget _buildProfileMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.charcoalBlack),
      title: Text(title, style: AppTypography.body),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.lightGrey),
      contentPadding: EdgeInsets.zero,
      onTap: () {},
    );
  }
}
