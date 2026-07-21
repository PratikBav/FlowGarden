import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/buttons/secondary_button.dart';
import '../../../core/providers/cart_provider.dart';
import '../../../dummy_data/mock_data.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = MockData.products.firstWhere(
      (p) => p.id == productId,
      orElse: () => MockData.products.first,
    );
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primaryWhite,
            elevation: 0,
            pinned: true,
            expandedHeight: 400,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.charcoalBlack),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_outline, color: AppColors.charcoalBlack),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      Text(
                        'CHF ${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.forestGreen),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.warning, size: 16),
                      const Icon(Icons.star, color: AppColors.warning, size: 16),
                      const Icon(Icons.star, color: AppColors.warning, size: 16),
                      const Icon(Icons.star, color: AppColors.warning, size: 16),
                      const Icon(Icons.star_half, color: AppColors.warning, size: 16),
                      const SizedBox(width: 8),
                      Text('4.8 (124 reviews)', style: AppTypography.caption),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    style: AppTypography.body,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          text: 'Add to Cart',
                          onPressed: () {
                            ref.read(cartProvider.notifier).addProduct(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} added to cart'),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'View Cart',
                                  onPressed: () => context.push('/cart'),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PrimaryButton(
                          text: 'Buy Now',
                          onPressed: () {
                            ref.read(cartProvider.notifier).addProduct(product);
                            context.push('/cart');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
