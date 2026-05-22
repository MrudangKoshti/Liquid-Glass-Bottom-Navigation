import 'package:flutter_test/flutter_test.dart';

import 'package:cupertino_liquid_navbar_example/main.dart';

void main() {
  testWidgets('example app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const LiquidNavbarExampleApp());
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Force fallback'), findsOneWidget);
  });
}
