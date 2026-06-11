import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app_fultter_test/main.dart';

void main() {
  testWidgets('Neobank Navigation and UI Render Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // 1. Verify Home Dashboard elements are present.
    expect(find.text('Good morning, Terry'), findsOneWidget);
    expect(find.text('Your balance'), findsOneWidget);
    expect(find.text('Your cards'), findsOneWidget);
    expect(find.text('Transactions'), findsOneWidget);

    // 2. Navigate to Map tab
    await tester.tap(find.byIcon(Icons.map_outlined));
    await tester.pumpAndSettle();
    expect(find.text('ATM Locator'), findsOneWidget);

    // 3. Navigate to Transfer tab
    await tester.tap(find.byIcon(Icons.swap_horizontal_circle_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Transfer Funds'), findsOneWidget);

    // 4. Navigate to Settings tab
    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);

    // 5. Navigate to Profile tab
    await tester.tap(find.text('Profile')); // Profile nav item label
    await tester.pumpAndSettle();
    expect(find.text('Personal info'), findsOneWidget);
    expect(find.text('Account info'), findsOneWidget);
  });
}
