import 'package:flutter/material.dart';

@immutable
class LiquidGlassNavStyle {
  final double height;
  final double marginHorizontal;
  final double marginBottom;
  final double borderRadius;
  final Color? tintColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double iconSize;
  final double selectedIconSize;
  final TextStyle? labelStyle;
  final bool showLabels;
  final bool enableHaptics;
  final bool useNativeOnIOS;
  final bool forceFallback;

  const LiquidGlassNavStyle({
    this.height = 72,
    this.marginHorizontal = 16,
    this.marginBottom = 12,
    this.borderRadius = 32,
    this.tintColor,
    this.selectedItemColor = const Color(0xFF000000),
    this.unselectedItemColor = const Color(0x99000000),
    this.iconSize = 22,
    this.selectedIconSize = 24,
    this.labelStyle,
    this.showLabels = true,
    this.enableHaptics = true,
    this.useNativeOnIOS = true,
    this.forceFallback = false,
  });

  Map<String, Object?> toMap() {
    return {
      'height': height,
      'marginHorizontal': marginHorizontal,
      'marginBottom': marginBottom,
      'borderRadius': borderRadius,
      'tintColor': tintColor?.toARGB32(),
      'selectedItemColor': selectedItemColor.toARGB32(),
      'unselectedItemColor': unselectedItemColor.toARGB32(),
      'iconSize': iconSize,
      'selectedIconSize': selectedIconSize,
      'showLabels': showLabels,
      'enableHaptics': enableHaptics,
    };
  }
}
