import 'package:flutter/material.dart';

import 'liquid_glass_bottom_nav_bar.dart';
import 'liquid_glass_nav_item.dart';
import 'liquid_glass_nav_style.dart';

class LiquidGlassScaffold extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final List<LiquidGlassNavItem> items;
  final ValueChanged<int> onTap;
  final LiquidGlassNavStyle style;
  final bool extendBody;

  const LiquidGlassScaffold({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    this.style = const LiquidGlassNavStyle(),
    this.extendBody = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody,
      body: body,
      bottomNavigationBar: LiquidGlassBottomNavBar(
        selectedIndex: selectedIndex,
        items: items,
        onTap: onTap,
        style: style,
      ),
    );
  }
}
