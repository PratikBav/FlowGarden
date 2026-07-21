import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../dummy_data/mock_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroBanner(context),
                _buildSectionTitle(context, 'Featured Categories'),
                _buildCategoriesList(),
                _buildSectionTitle(context, 'Trending Boutique'),
                _buildTrendingProducts(),
                _buildSectionTitle(context, 'Wellness & Healing'),
                _buildWellnessPromo(context),
                _buildSectionTitle(context, 'Luxury Rentals'),
                _buildRentalsList(),
                _buildNewsletter(context),
                const SizedBox(height: 100), // padding for bottom nav
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.primaryWhite,
      elevation: 0,
      pinned: true,
      centerTitle: true,
      title: Text(
        'THE FLOW GARDEN',
        style: AppTypography.title.copyWith(letterSpacing: 2.0),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.charcoalBlack),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: AppColors.charcoalBlack),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
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
              AppColors.charcoalBlack.withOpacity(0.7),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Become the best\nversion of yourself',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.primaryWhite,
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'Explore Wellness',
                onPressed: () {},
                isFullWidth: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'View All',
              style: AppTypography.buttonText.copyWith(color: AppColors.forestGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    final categories = [
      {'name': 'Yoga', 'icon': Icons.self_improvement},
      {'name': 'Massage', 'icon': Icons.spa},
      {'name': 'Retreats', 'icon': Icons.holiday_village},
      {'name': 'Boutique', 'icon': Icons.shopping_bag_outlined},
      {'name': 'Concierge', 'icon': Icons.room_service_outlined},
    ];
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.warmWhite,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Icon(cat['icon'] as IconData, color: AppColors.forestGreen),
                ),
                const SizedBox(height: 8),
                Text(cat['name'] as String, style: AppTypography.caption),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingProducts() {
    final products = MockData.products;
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                context.push('/product/${product.id}');
              },
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(product.title, style: AppTypography.body.copyWith(fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text('CHF ${product.price.toStringAsFixed(2)}', style: AppTypography.body.copyWith(color: AppColors.forestGreen)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWellnessPromo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1545205597-3d9d02c29597?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.charcoalBlack.withOpacity(0.4),
        ),
        alignment: Alignment.center,
        child: Text(
          'Book a Session',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.primaryWhite),
        ),
      ),
    );
  }

  Widget _buildRentalsList() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Luxury Villa Retreat', style: AppTypography.title.copyWith(fontSize: 18)),
                  Text('Ibiza, Spain', style: AppTypography.caption),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsletter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.warmWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Join The Club',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Subscribe to get exclusive access to our retreats and luxury offerings.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: 'Subscribe',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
