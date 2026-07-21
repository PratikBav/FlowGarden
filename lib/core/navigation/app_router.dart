import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/main_hub_screen.dart';
import '../../features/boutique/screens/product_details_screen.dart';
import '../../features/boutique/screens/cart_screen.dart';
import '../../features/boutique/screens/checkout_screen.dart';
import '../../features/activities/screens/activities_screen.dart';
import '../../features/rentals/screens/rentals_screen.dart';
import '../../features/concierge/screens/concierge_screen.dart';
import '../../features/club/screens/club_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic))),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MainHubScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/product/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ProductDetailsScreen(productId: id),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic))),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CartScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(Tween(begin: const Offset(0, 1), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic))),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/checkout',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CheckoutScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/activities',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ActivitiesScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/rentals',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const RentalsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/concierge',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ConciergeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/club',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ClubScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(Tween(begin: const Offset(0, 1), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic))),
              child: child,
            );
          },
        ),
      ),
    ],
  );
}

