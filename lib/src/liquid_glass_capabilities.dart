import 'package:flutter/services.dart';

class LiquidGlassCapabilities {
  final bool supportsMaterial;
  final bool supportsAdvancedCompositing;
  final bool supportsSymbolEffects;

  const LiquidGlassCapabilities({
    required this.supportsMaterial,
    required this.supportsAdvancedCompositing,
    required this.supportsSymbolEffects,
  });

  static const MethodChannel _channel = MethodChannel(
    'cupertino_liquid_navbar/capabilities',
  );

  static Future<LiquidGlassCapabilities> query() async {
    final map = await _channel.invokeMapMethod<String, dynamic>(
      'getCapabilities',
    );
    return LiquidGlassCapabilities(
      supportsMaterial: map?['supportsMaterial'] as bool? ?? false,
      supportsAdvancedCompositing:
          map?['supportsAdvancedCompositing'] as bool? ?? false,
      supportsSymbolEffects: map?['supportsSymbolEffects'] as bool? ?? false,
    );
  }
}
