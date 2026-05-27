import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'liquid_glass_fallback_nav_bar.dart';
import 'liquid_glass_nav_item.dart';
import 'liquid_glass_nav_style.dart';
import 'liquid_glass_platform_view.dart';

class LiquidGlassBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<LiquidGlassNavItem> items;
  final ValueChanged<int> onTap;
  final LiquidGlassNavStyle style;

  const LiquidGlassBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    this.style = const LiquidGlassNavStyle(),
  }) : assert(items.length >= 2, 'At least 2 nav items are required.'),
       assert(
         selectedIndex >= 0 && selectedIndex < items.length,
         'selectedIndex must be inside items range.',
       );

  @override
  Widget build(BuildContext context) {
    final shouldUseNativeIOS =
        defaultTargetPlatform == TargetPlatform.iOS &&
        style.useNativeOnIOS &&
        !style.forceFallback;

    if (shouldUseNativeIOS) {
      return LiquidGlassPlatformView(
        selectedIndex: selectedIndex,
        items: items,
        onTap: onTap,
        style: style,
      );
    }

    return LiquidGlassFallbackNavBar(
      selectedIndex: selectedIndex,
      items: items,
      onTap: onTap,
      style: style,
    );
  }
}
