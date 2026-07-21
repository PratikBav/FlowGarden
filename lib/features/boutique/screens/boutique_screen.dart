import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/inputs/custom_text_field.dart';
import '../../../core/widgets/cards/product_card.dart';
import '../../../dummy_data/mock_data.dart';
import 'package:go_router/go_router.dart';

class BoutiqueScreen extends StatefulWidget {
  const BoutiqueScreen({super.key});

  @override
  State<BoutiqueScreen> createState() => _BoutiqueScreenState();
}

class _BoutiqueScreenState extends State<BoutiqueScreen> {
  final List<String> _categories = ['All', 'Skincare', 'Wellness', 'Spa', 'Sleep'];
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: Text('BOUTIQUE', style: AppTypography.title.copyWith(letterSpacing: 2.0)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline, color: AppColors.charcoalBlack),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.charcoalBlack),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const Expanded(
                  child: CustomTextField(
                    hintText: 'Search products...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: AppColors.warmWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: AppColors.charcoalBlack),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: AppColors.forestGreen,
                    backgroundColor: AppColors.primaryWhite,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.primaryWhite : AppColors.charcoalBlack,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: MockData.products.length,
              itemBuilder: (context, index) {
                final product = MockData.products[index];
                return Stack(
                  children: [
                    ProductCard(
                      imageUrl: product.imageUrl,
                      title: product.title,
                      price: 'CHF ${product.price.toStringAsFixed(2)}',
                      index: index,
                      onTap: () {
                        context.push('/product/${product.id}');
                      },
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_outline, size: 20, color: AppColors.charcoalBlack),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
