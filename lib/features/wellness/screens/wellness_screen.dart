import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/providers/bookings_provider.dart';

class WellnessScreen extends ConsumerStatefulWidget {
  const WellnessScreen({super.key});

  @override
  ConsumerState<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends ConsumerState<WellnessScreen> {
  int selectedDateIndex = 0;

  final services = [
    {
      'title': 'Vinyasa Yoga Flow',
      'image': 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      'duration': '60 min',
      'price': 'CHF 80',
      'time': '09:00 AM',
    },
    {
      'title': 'Deep Tissue Massage',
      'image': 'https://images.unsplash.com/photo-1600334089648-b0d9d3028eb2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      'duration': '90 min',
      'price': 'CHF 150',
      'time': '11:00 AM',
    },
    {
      'title': 'Sound Bath Meditation',
      'image': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      'duration': '45 min',
      'price': 'CHF 60',
      'time': '02:00 PM',
    },
  ];

  final practitioners = [
    {
      'name': 'Dr. Elena',
      'specialty': 'Ayurveda',
      'image': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'Master Li',
      'specialty': 'Acupuncture',
      'image': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'Sarah',
      'specialty': 'Yoga Guide',
      'image': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'Marcus',
      'specialty': 'Physiotherapy',
      'image': 'https://images.unsplash.com/photo-1618077360395-f3068be8e001?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
    },
  ];

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
            title: Text('WELLNESS', style: AppTypography.title.copyWith(letterSpacing: 2.0)),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDatePicker(),
                const SizedBox(height: 32),
                _buildSectionTitle('Featured Practitioners'),
                _buildPractitioners(),
                const SizedBox(height: 32),
                _buildSectionTitle('Available Sessions'),
              ],
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildServiceCard(index);
                },
                childCount: services.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildDatePicker() {
    final now = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 14,
        itemBuilder: (context, index) {
          final date = now.add(Duration(days: index));
          final isSelected = index == selectedDateIndex;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDateIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.forestGreen : AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.forestGreen : AppColors.lightGrey.withOpacity(0.3),
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppColors.forestGreen.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    days[date.weekday - 1],
                    style: AppTypography.caption.copyWith(
                      color: isSelected ? AppColors.primaryWhite : AppColors.charcoalBlack.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${date.day}',
                    style: AppTypography.title.copyWith(
                      color: isSelected ? AppColors.primaryWhite : AppColors.charcoalBlack,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPractitioners() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: practitioners.length,
        itemBuilder: (context, index) {
          final p = practitioners[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: CachedNetworkImageProvider(p['image']!),
                ),
                const SizedBox(height: 8),
                Text(p['name']!, style: AppTypography.body.copyWith(fontWeight: FontWeight.bold)),
                Text(p['specialty']!, style: AppTypography.caption),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).scale(delay: Duration(milliseconds: 100 * index));
        },
      ),
    );
  }

  Widget _buildServiceCard(int index) {
    final service = services[index];
    return GestureDetector(
      onTap: () {
        final booking = Booking(
          id: DateTime.now().toString(),
          title: service['title']!,
          date: DateTime.now().add(Duration(days: selectedDateIndex)),
          location: 'The Flow Garden Studio',
          type: 'Wellness',
        );
        ref.read(bookingsProvider.notifier).addBooking(booking);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${service['title']} booked successfully!'),
            backgroundColor: AppColors.forestGreen,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: CachedNetworkImageProvider(service['image']!),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.charcoalBlack.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.charcoalBlack.withOpacity(0.8),
              ],
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryWhite.withOpacity(0.5)),
                  ),
                  child: Text(service['time']!, style: AppTypography.caption.copyWith(color: AppColors.primaryWhite, fontWeight: FontWeight.bold)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['title']!,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.primaryWhite, fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.schedule, color: AppColors.lightGrey, size: 16),
                          const SizedBox(width: 4),
                          Text(service['duration']!, style: AppTypography.caption.copyWith(color: AppColors.lightGrey)),
                        ],
                      ),
                      Text(service['price']!, style: AppTypography.body.copyWith(color: AppColors.primaryWhite, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 150 * index)).slideY(begin: 0.1, end: 0, delay: Duration(milliseconds: 150 * index));
  }
}
