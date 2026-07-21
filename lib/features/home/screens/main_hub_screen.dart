import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../../boutique/screens/boutique_screen.dart';
import '../../wellness/screens/wellness_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../../core/widgets/layout/fade_indexed_stack.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/navigation_provider.dart';

class MainHubScreen extends ConsumerWidget {
  const MainHubScreen({super.key});

  final List<Widget> _pages = const [
    HomeScreen(),
    BoutiqueScreen(),
    WellnessScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: FadeIndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(navigationProvider.notifier).setTab(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Boutique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa_outlined),
            activeIcon: Icon(Icons.spa),
            label: 'Wellness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
