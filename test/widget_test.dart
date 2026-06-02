import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app_fultter_test/main.dart';

void main() {
  testWidgets('Navigation and Explore details flow test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // 1. Verify Home screen elements.
    expect(find.text('Antigravity'), findsOneWidget);
    expect(find.text('Hello, World!'), findsOneWidget);

    // 2. Tap Explore tab icon in bottom navigation bar.
    await tester.tap(find.byIcon(Icons.explore_outlined));
    await tester.pumpAndSettle();

    // 3. Verify Explore screen title.
    expect(find.text('Explore'), findsWidgets);
    expect(find.text('Stunning Layouts'), findsOneWidget);

    // 4. Tap 'Stunning Layouts' card.
    await tester.tap(find.text('Stunning Layouts'));
    await tester.pumpAndSettle();

    // 5. Verify Detail screen is visible.
    expect(find.text('Details'), findsOneWidget);
    expect(find.text('OVERVIEW'), findsOneWidget);

    // 6. Tap custom back button.
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();

    // 7. Verify we are back on Explore feed.
    expect(find.text('Stunning Layouts'), findsOneWidget);
  });
}
