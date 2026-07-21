import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/providers/bookings_provider.dart';

class RentalsScreen extends ConsumerStatefulWidget {
  const RentalsScreen({super.key});

  @override
  ConsumerState<RentalsScreen> createState() => _RentalsScreenState();
}

class _RentalsScreenState extends ConsumerState<RentalsScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> rentals = [
    {
      'title': 'Villa Serenity',
      'location': 'Ibiza, Spain',
      'price': 'CHF 1,200/night',
      'guests': 'Up to 8 guests',
      'image': 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
      'description': 'A breathtaking minimalist villa overlooking the Mediterranean Sea. Features a private infinity pool, fully equipped outdoor kitchen, and private access to a secluded beach.',
    },
    {
      'title': 'Chalet Blanc',
      'location': 'Swiss Alps',
      'price': 'CHF 2,500/night',
      'guests': 'Up to 12 guests',
      'image': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
      'description': 'Ultimate luxury ski-in/ski-out chalet with panoramic mountain views. Includes a private chef, heated indoor pool, sauna, and a state-of-the-art cinema room.',
    },
    {
      'title': 'Casa Sol',
      'location': 'Tulum, Mexico',
      'price': 'CHF 800/night',
      'guests': 'Up to 6 guests',
      'image': 'https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
      'description': 'An eco-luxury jungle retreat steps away from pristine white sand beaches. Designed with sustainable materials featuring open-air showers and a rooftop yoga deck.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalBlack,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: rentals.length,
            itemBuilder: (context, index) {
              final rental = rentals[index];
              return _buildRentalPage(context, rental, index);
            },
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'LUXURY RENTALS',
                style: AppTypography.title.copyWith(color: AppColors.primaryWhite, letterSpacing: 3.0),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              children: List.generate(
                rentals.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryWhite,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRentalPage(BuildContext context, Map<String, String> rental, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: rental['image']!,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.transparent,
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primaryWhite.withOpacity(0.3)),
                ),
                child: Text(
                  rental['location']!,
                  style: AppTypography.caption.copyWith(color: AppColors.primaryWhite, fontWeight: FontWeight.bold),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5, end: 0),
              const SizedBox(height: 16),
              Text(
                rental['title']!,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.primaryWhite, fontWeight: FontWeight.bold),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.5, end: 0),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    rental['price']!,
                    style: AppTypography.title.copyWith(color: AppColors.secondaryGold),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.group_outlined, color: AppColors.lightGrey, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rental['guests']!,
                    style: AppTypography.caption.copyWith(color: AppColors.lightGrey),
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.5, end: 0),
              const SizedBox(height: 24),
              Text(
                rental['description']!,
                style: AppTypography.body.copyWith(color: AppColors.primaryWhite.withOpacity(0.9)),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.5, end: 0),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Reserve Dates',
                backgroundColor: AppColors.primaryWhite,
                textColor: AppColors.charcoalBlack,
                onPressed: () {
                  final booking = Booking(
                    id: DateTime.now().toString(),
                    title: rental['title']!,
                    date: DateTime.now().add(const Duration(days: 30)),
                    location: rental['location']!,
                    type: 'Rental',
                  );
                  ref.read(bookingsProvider.notifier).addBooking(booking);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${rental['title']} added to your bookings!'),
                      backgroundColor: AppColors.forestGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.5, end: 0),
              const SizedBox(height: 48), // Padding for bottom nav
            ],
          ),
        ),
      ],
    );
  }
}
