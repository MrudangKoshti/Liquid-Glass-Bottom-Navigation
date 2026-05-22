import 'package:flutter/widgets.dart';

@immutable
class LiquidGlassNavItem {
  final String label;

  /// SF Symbol name for native iOS rendering.
  /// Example: house.fill, magnifyingglass, person.fill
  final String? sfSymbol;

  /// Flutter fallback icon for Android, Web, Desktop, and fallback mode.
  final IconData? fallbackIcon;

  /// Optional selected SF Symbol.
  final String? selectedSfSymbol;

  /// Optional selected Flutter fallback icon.
  final IconData? selectedFallbackIcon;

  const LiquidGlassNavItem({
    required this.label,
    this.sfSymbol,
    this.fallbackIcon,
    this.selectedSfSymbol,
    this.selectedFallbackIcon,
  }) : assert(
          sfSymbol != null || fallbackIcon != null,
          'Either sfSymbol or fallbackIcon must be provided.',
        );

  Map<String, Object?> toMap() {
    return {
      'label': label,
      'sfSymbol': sfSymbol,
      'selectedSfSymbol': selectedSfSymbol,
    };
  }
}
