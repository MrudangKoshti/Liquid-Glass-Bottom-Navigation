import 'dart:ui';

import 'package:flutter/material.dart';

import 'liquid_glass_nav_item.dart';
import 'liquid_glass_nav_style.dart';

class LiquidGlassFallbackNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<LiquidGlassNavItem> items;
  final ValueChanged<int> onTap;
  final LiquidGlassNavStyle style;

  const LiquidGlassFallbackNavBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: style.marginHorizontal,
          right: style.marginHorizontal,
          bottom: style.marginBottom,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(style.borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: style.height,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(style.borderRadius),
                border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
              ),
              child: Row(
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final isSelected = selectedIndex == index;

                  return Expanded(
                    child: InkWell(
                      onTap: () => onTap(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isSelected
                                  ? (item.selectedFallbackIcon ??
                                        item.fallbackIcon ??
                                        Icons.circle)
                                  : (item.fallbackIcon ??
                                        Icons.circle_outlined),
                              size: isSelected
                                  ? style.selectedIconSize
                                  : style.iconSize,
                              color: isSelected
                                  ? style.selectedItemColor
                                  : style.unselectedItemColor,
                            ),
                            if (style.showLabels) ...[
                              const SizedBox(height: 4),
                              Text(
                                item.label,
                                style:
                                    style.labelStyle ??
                                    TextStyle(
                                      fontSize: 11,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: isSelected
                                          ? style.selectedItemColor
                                          : style.unselectedItemColor,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
