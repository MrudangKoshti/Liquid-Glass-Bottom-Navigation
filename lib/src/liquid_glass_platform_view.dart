import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'liquid_glass_nav_item.dart';
import 'liquid_glass_nav_style.dart';

class LiquidGlassPlatformView extends StatefulWidget {
  final int selectedIndex;
  final List<LiquidGlassNavItem> items;
  final ValueChanged<int> onTap;
  final LiquidGlassNavStyle style;

  const LiquidGlassPlatformView({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    required this.style,
  });

  @override
  State<LiquidGlassPlatformView> createState() =>
      _LiquidGlassPlatformViewState();
}

class _LiquidGlassPlatformViewState extends State<LiquidGlassPlatformView> {
  MethodChannel? _channel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.style.height + widget.style.marginBottom,
      child: UiKitView(
        viewType: 'cupertino_liquid_navbar/native_navbar',
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: {
          'selectedIndex': widget.selectedIndex,
          'items': widget.items.map((e) => e.toMap()).toList(),
          'style': widget.style.toMap(),
        },
        onPlatformViewCreated: _onPlatformViewCreated,
      ),
    );
  }

  void _onPlatformViewCreated(int id) {
    _channel = MethodChannel('cupertino_liquid_navbar/native_navbar_$id');
    _channel!.setMethodCallHandler((call) async {
      if (call.method == 'onTap') {
        final index = call.arguments as int;
        widget.onTap(index);
      }
    });
  }

  @override
  void didUpdateWidget(covariant LiquidGlassPlatformView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_channel == null) return;

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _channel!.invokeMethod('updateSelectedIndex', widget.selectedIndex);
    }

    if (!listEquals(oldWidget.items, widget.items)) {
      _channel!.invokeMethod(
        'updateItems',
        widget.items.map((e) => e.toMap()).toList(),
      );
    }

    if (oldWidget.style != widget.style) {
      _channel!.invokeMethod('updateStyle', widget.style.toMap());
    }
  }
}
