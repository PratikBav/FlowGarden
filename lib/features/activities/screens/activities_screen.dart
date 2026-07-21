import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/providers/bookings_provider.dart';

class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primaryWhite,
            elevation: 0,
            pinned: true,
            title: Text('Activities & Events', style: AppTypography.title),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'Curated experiences designed to elevate your mind, body, and spirit.',
                style: AppTypography.body,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final isEvent = index % 2 == 0;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.lightGrey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: CachedNetworkImage(
                            imageUrl: isEvent
                                ? 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80'
                                : 'https://images.unsplash.com/photo-1551632811-561732d1e306?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: isEvent ? AppColors.forestGreen.withOpacity(0.1) : AppColors.secondaryGold.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      isEvent ? 'Special Event' : 'Daily Activity',
                                      style: AppTypography.caption.copyWith(
                                        color: isEvent ? AppColors.forestGreen : AppColors.secondaryGold,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    isEvent ? 'Aug 15 • 18:00' : 'Daily • 08:00',
                                    style: AppTypography.caption,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                isEvent ? 'Full Moon Sound Bath' : 'Sunrise Vinyasa Flow',
                                style: AppTypography.title.copyWith(fontSize: 18),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isEvent
                                    ? 'Join us under the full moon for a transformative sound healing journey.'
                                    : 'Start your morning with a powerful and energizing outdoor yoga flow.',
                                style: AppTypography.body,
                              ),
                              const SizedBox(height: 16),
                              PrimaryButton(
                                text: 'Reserve Spot',
                                onPressed: () {
                                  final title = isEvent ? 'Full Moon Sound Bath' : 'Sunrise Vinyasa Flow';
                                  final booking = Booking(
                                    id: DateTime.now().toString(),
                                    title: title,
                                    date: DateTime.now().add(const Duration(days: 3)),
                                    location: 'The Garden Deck',
                                    type: 'Activity',
                                  );
                                  ref.read(bookingsProvider.notifier).addBooking(booking);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Spot reserved for $title!'),
                                      backgroundColor: AppColors.forestGreen,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 4,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
