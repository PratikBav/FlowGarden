import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_garden/main.dart';

void main() {
  testWidgets('App launches successfully smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: FlowGardenApp()));

    // The app routes to Splash screen initially, so we check if the splash screen content is there.
    expect(find.text('THE FLOW GARDEN'), findsOneWidget);
  });
}
