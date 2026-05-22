import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:cupertino_liquid_navbar/cupertino_liquid_navbar.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('bottom nav fallback tap flow works', (
    WidgetTester tester,
  ) async {
    var selected = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              bottomNavigationBar: LiquidGlassBottomNavBar(
                selectedIndex: selected,
                onTap: (value) => setState(() => selected = value),
                style: const LiquidGlassNavStyle(forceFallback: true),
                items: const [
                  LiquidGlassNavItem(label: 'Home', fallbackIcon: Icons.home),
                  LiquidGlassNavItem(
                    label: 'Search',
                    fallbackIcon: Icons.search,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(selected, 1);
  });
}
