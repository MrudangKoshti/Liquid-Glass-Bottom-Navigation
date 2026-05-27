import 'package:flutter/material.dart';

@immutable
class LiquidGlassNavStyle {
  final LiquidGlassPreset preset;
  final LiquidGlassSelectedStyle selectedStyle;
  final double intensity;
  final bool useNativeOnIOS;
  final bool forceFallback;
  final bool debugShowBounds;
  final bool enableDragIndicator;
  final int styleVersion;

  final LiquidGlassLayoutStyle layout;
  final LiquidGlassContainerStyle container;
  final LiquidGlassSelectedItemStyle selected;
  final LiquidGlassAnimationStyle animation;
  final LiquidGlassIconLabelStyle iconAndLabel;

  const LiquidGlassNavStyle({
    this.preset = LiquidGlassPreset.system,
    this.selectedStyle = LiquidGlassSelectedStyle.pill,
    this.intensity = 1.0,
    this.useNativeOnIOS = true,
    this.forceFallback = false,
    this.debugShowBounds = false,
    this.enableDragIndicator = true,
    this.styleVersion = 1,
    this.layout = const LiquidGlassLayoutStyle(),
    this.container = const LiquidGlassContainerStyle(),
    this.selected = const LiquidGlassSelectedItemStyle(),
    this.animation = const LiquidGlassAnimationStyle(),
    this.iconAndLabel = const LiquidGlassIconLabelStyle(),
  });

  LiquidGlassNavStyle copyWith({
    LiquidGlassPreset? preset,
    LiquidGlassSelectedStyle? selectedStyle,
    double? intensity,
    bool? useNativeOnIOS,
    bool? forceFallback,
    bool? debugShowBounds,
    bool? enableDragIndicator,
    int? styleVersion,
    LiquidGlassLayoutStyle? layout,
    LiquidGlassContainerStyle? container,
    LiquidGlassSelectedItemStyle? selected,
    LiquidGlassAnimationStyle? animation,
    LiquidGlassIconLabelStyle? iconAndLabel,
  }) {
    return LiquidGlassNavStyle(
      preset: preset ?? this.preset,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      intensity: intensity ?? this.intensity,
      useNativeOnIOS: useNativeOnIOS ?? this.useNativeOnIOS,
      forceFallback: forceFallback ?? this.forceFallback,
      debugShowBounds: debugShowBounds ?? this.debugShowBounds,
      enableDragIndicator: enableDragIndicator ?? this.enableDragIndicator,
      styleVersion: styleVersion ?? this.styleVersion,
      layout: layout ?? this.layout,
      container: container ?? this.container,
      selected: selected ?? this.selected,
      animation: animation ?? this.animation,
      iconAndLabel: iconAndLabel ?? this.iconAndLabel,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'preset': preset.index,
      'selectedStyle': selectedStyle.index,
      'intensity': intensity.clamp(0.0, 1.0),
      'useNativeOnIOS': useNativeOnIOS,
      'forceFallback': forceFallback,
      'debugShowBounds': debugShowBounds,
      'enableDragIndicator': enableDragIndicator,
      'styleVersion': styleVersion,
      ...layout.toMap(),
      ...container.toMap(),
      ...selected.toMap(),
      ...animation.toMap(),
      ...iconAndLabel.toMap(),
    };
  }

  double get height => layout.height;
  double get marginHorizontal => layout.marginHorizontal;
  double get marginBottom => layout.marginBottom;
  double get borderRadius => layout.borderRadius;
  Color? get tintColor => container.tintColor;
  Color get selectedItemColor => iconAndLabel.selectedItemColor;
  Color get unselectedItemColor => iconAndLabel.unselectedItemColor;
  double get iconSize => iconAndLabel.iconSize;
  double get selectedIconSize => iconAndLabel.selectedIconSize;
  TextStyle? get labelStyle => iconAndLabel.labelStyle;
  bool get showLabels => iconAndLabel.showLabels;
  bool get enableHaptics => iconAndLabel.enableHaptics;

  double get itemSpacing => layout.itemSpacing;
  double get verticalPadding => layout.verticalPadding;
  double get containerOpacity => container.opacity;
  double get containerBorderOpacity => container.borderOpacity;
  double get containerShadowOpacity => container.shadowOpacity;
  double get selectedPillOpacity => selected.opacity;
  double get selectedPillBorderOpacity => selected.borderOpacity;
  double get selectedPillShadowOpacity => selected.shadowOpacity;
  double get selectedPillHorizontalInset => selected.horizontalInset;
  double get selectedPillScale => selected.scale;
  double get chromaticAberrationOpacity => selected.chromaticAberrationOpacity;
  double get animationResponse => animation.response;
  double get animationDampingFraction => animation.dampingFraction;
}

enum LiquidGlassPreset { system, subtle, balanced, vivid }

enum LiquidGlassSelectedStyle { none, pill, bubble }

enum LiquidGlassMaterialStyle {
  system,
  ultraThin,
  thin,
  regular,
  thick,
  chrome,
}

@immutable
class LiquidGlassLayoutStyle {
  final double height;
  final double marginHorizontal;
  final double marginBottom;
  final double borderRadius;
  final double itemSpacing;
  final double verticalPadding;

  const LiquidGlassLayoutStyle({
    this.height = 72,
    this.marginHorizontal = 16,
    this.marginBottom = 12,
    this.borderRadius = 32,
    this.itemSpacing = 8,
    this.verticalPadding = 8,
  });

  Map<String, Object?> toMap() {
    return {
      'height': height,
      'marginHorizontal': marginHorizontal,
      'marginBottom': marginBottom,
      'borderRadius': borderRadius,
      'itemSpacing': itemSpacing,
      'verticalPadding': verticalPadding,
    };
  }
}

@immutable
class LiquidGlassContainerStyle {
  final Color? tintColor;
  final LiquidGlassMaterialStyle materialStyle;
  final double opacity;
  final double borderOpacity;
  final double shadowOpacity;

  const LiquidGlassContainerStyle({
    this.tintColor,
    this.materialStyle = LiquidGlassMaterialStyle.ultraThin,
    this.opacity = 1.0,
    this.borderOpacity = 0.45,
    this.shadowOpacity = 0.08,
  });

  Map<String, Object?> toMap() {
    return {
      'tintColor': tintColor?.toARGB32(),
      'containerMaterialStyle': materialStyle.index,
      'containerOpacity': opacity,
      'containerBorderOpacity': borderOpacity,
      'containerShadowOpacity': shadowOpacity,
    };
  }
}

@immutable
class LiquidGlassSelectedItemStyle {
  final LiquidGlassMaterialStyle materialStyle;
  final double opacity;
  final double borderOpacity;
  final double shadowOpacity;
  final double horizontalInset;
  final double scale;
  final double chromaticAberrationOpacity;

  const LiquidGlassSelectedItemStyle({
    this.materialStyle = LiquidGlassMaterialStyle.thin,
    this.opacity = 1.0,
    this.borderOpacity = 0.65,
    this.shadowOpacity = 0.10,
    this.horizontalInset = 2,
    this.scale = 1.0,
    this.chromaticAberrationOpacity = 0.75,
  });

  Map<String, Object?> toMap() {
    return {
      'selectedMaterialStyle': materialStyle.index,
      'selectedPillOpacity': opacity,
      'selectedPillBorderOpacity': borderOpacity,
      'selectedPillShadowOpacity': shadowOpacity,
      'selectedPillHorizontalInset': horizontalInset,
      'selectedPillScale': scale,
      'chromaticAberrationOpacity': chromaticAberrationOpacity,
    };
  }
}

@immutable
class LiquidGlassAnimationStyle {
  final double response;
  final double dampingFraction;

  const LiquidGlassAnimationStyle({
    this.response = 0.28,
    this.dampingFraction = 0.85,
  });

  Map<String, Object?> toMap() {
    return {
      'animationResponse': response,
      'animationDampingFraction': dampingFraction,
    };
  }
}

@immutable
class LiquidGlassIconLabelStyle {
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double iconSize;
  final double selectedIconSize;
  final TextStyle? labelStyle;
  final bool showLabels;
  final bool enableHaptics;

  const LiquidGlassIconLabelStyle({
    this.selectedItemColor = const Color(0xFF000000),
    this.unselectedItemColor = const Color(0x99000000),
    this.iconSize = 22,
    this.selectedIconSize = 24,
    this.labelStyle,
    this.showLabels = true,
    this.enableHaptics = true,
  });

  Map<String, Object?> toMap() {
    return {
      'selectedItemColor': selectedItemColor.toARGB32(),
      'unselectedItemColor': unselectedItemColor.toARGB32(),
      'iconSize': iconSize,
      'selectedIconSize': selectedIconSize,
      'showLabels': showLabels,
      'enableHaptics': enableHaptics,
    };
  }
}
