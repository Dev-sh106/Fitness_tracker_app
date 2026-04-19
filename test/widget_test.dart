import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_tracker_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FitnessTrackerApp());

    // Verify that we are on the BMI screen (or any initial screen text)
    expect(find.text('Check your BMI'), findsOneWidget);
  });
}
