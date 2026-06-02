import 'package:flutter_test/flutter_test.dart';
import 'package:my_app_fultter_test/main.dart';

void main() {
  testWidgets('Hello World UI Smoke Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title 'Antigravity' is present.
    expect(find.text('Antigravity'), findsOneWidget);

    // Verify that the main 'Hello, World!' heading is present.
    expect(find.text('Hello, World!'), findsOneWidget);
  });
}
