import 'package:cupertino_liquid_navbar/cupertino_liquid_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const items = [
    LiquidGlassNavItem(label: 'Home', fallbackIcon: Icons.home),
    LiquidGlassNavItem(label: 'Search', fallbackIcon: Icons.search),
  ];

  testWidgets('throws assertion for invalid selectedIndex', (tester) async {
    expect(
      () => LiquidGlassBottomNavBar(
        selectedIndex: 2,
        items: items,
        onTap: (_) {},
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  testWidgets('throws assertion for less than 2 items', (tester) async {
    expect(
      () => LiquidGlassBottomNavBar(
        selectedIndex: 0,
        items: const [
          LiquidGlassNavItem(label: 'Only', fallbackIcon: Icons.home),
        ],
        onTap: (_) {},
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  testWidgets('fallback widget renders correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: LiquidGlassBottomNavBar(
            selectedIndex: 0,
            items: items,
            onTap: (_) {},
            style: const LiquidGlassNavStyle(forceFallback: true),
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.byType(InkWell), findsNWidgets(2));
  });

  testWidgets('tapping fallback item calls onTap', (tester) async {
    var tappedIndex = -1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: LiquidGlassBottomNavBar(
            selectedIndex: 0,
            items: items,
            onTap: (index) => tappedIndex = index,
            style: const LiquidGlassNavStyle(forceFallback: true),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Search'));
    expect(tappedIndex, 1);
  });

  testWidgets('forceFallback uses fallback widget', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: LiquidGlassBottomNavBar(
            selectedIndex: 0,
            items: items,
            onTap: (_) {},
            style: const LiquidGlassNavStyle(forceFallback: true),
          ),
        ),
      ),
    );

    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(InkWell), findsNWidgets(2));
  });
}
