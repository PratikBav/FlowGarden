import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.read(cartProvider.notifier).totalPrice;

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: Text(
          'Shopping Cart',
          style: AppTypography.title.copyWith(fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.charcoalBlack),
          onPressed: () => context.pop(),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 64, color: AppColors.lightGrey),
                  const SizedBox(height: 16),
                  Text('Your cart is empty', style: AppTypography.title),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Continue Shopping',
                    onPressed: () => context.pop(),
                    isFullWidth: false,
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Dismissible(
                        key: Key(item.product.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          ref.read(cartProvider.notifier).removeProduct(item.product.id);
                        },
                        background: Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: AppColors.errorSoftRed,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 24),
                          child: const Icon(Icons.delete_outline, color: Colors.white, size: 32),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: item.product.imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.title,
                                      style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'CHF ${item.product.price.toStringAsFixed(2)}',
                                      style: AppTypography.body.copyWith(color: AppColors.forestGreen),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        _QuantityButton(
                                          icon: Icons.remove,
                                          onPressed: () {
                                            ref.read(cartProvider.notifier).updateQuantity(item.product.id, item.quantity - 1);
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Text(
                                            item.quantity.toString(),
                                            style: AppTypography.body.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        _QuantityButton(
                                          icon: Icons.add,
                                          onPressed: () {
                                            ref.read(cartProvider.notifier).updateQuantity(item.product.id, item.quantity + 1);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideX(begin: 0.1, end: 0, delay: Duration(milliseconds: 100 * index));
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal', style: AppTypography.body),
                            Text('CHF ${totalPrice.toStringAsFixed(2)}', style: AppTypography.body),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping', style: AppTypography.body),
                            Text('Calculated at checkout', style: AppTypography.caption),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: AppTypography.title.copyWith(fontSize: 18)),
                            Text('CHF ${totalPrice.toStringAsFixed(2)}', style: AppTypography.title.copyWith(fontSize: 18)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          text: 'Checkout',
                          onPressed: () {
                            context.push('/checkout');
                          },
                        ),
                      ],
                    ),
                  ),
                ).animate().slideY(begin: 1.0, end: 0, duration: 400.ms, curve: Curves.easeOutCirc),
              ],
            ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.charcoalBlack),
      ),
    );
  }
}
