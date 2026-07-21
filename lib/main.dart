import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FlowGardenApp(),
    ),
  );
}

class FlowGardenApp extends StatelessWidget {
  const FlowGardenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'The Flow Garden',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const _SlowScrollBehavior(),
    );
  }
}

class _SlowScrollBehavior extends MaterialScrollBehavior {
  const _SlowScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics().applyTo(const _SlowScrollPhysics());
  }

  // Also enable dragging by mouse to make it easier to test on web/desktop
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class _SlowScrollPhysics extends ScrollPhysics {
  const _SlowScrollPhysics({super.parent});

  @override
  _SlowScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SlowScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Slow down dragging (touch/mouse drag) by 50%
    return super.applyPhysicsToUserOffset(position, offset * 0.5);
  }
}
