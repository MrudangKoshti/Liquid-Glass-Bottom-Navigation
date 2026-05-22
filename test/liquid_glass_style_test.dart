import 'package:cupertino_liquid_navbar/cupertino_liquid_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LiquidGlassNavStyle.toMap returns expected values', () {
    const style = LiquidGlassNavStyle(
      height: 80,
      marginHorizontal: 10,
      marginBottom: 8,
      borderRadius: 20,
      tintColor: Color(0xAA112233),
      selectedItemColor: Color(0xFF010203),
      unselectedItemColor: Color(0xFF040506),
      iconSize: 18,
      selectedIconSize: 22,
      showLabels: false,
      enableHaptics: false,
    );

    expect(style.toMap(), {
      'height': 80.0,
      'marginHorizontal': 10.0,
      'marginBottom': 8.0,
      'borderRadius': 20.0,
      'tintColor': const Color(0xAA112233).toARGB32(),
      'selectedItemColor': const Color(0xFF010203).toARGB32(),
      'unselectedItemColor': const Color(0xFF040506).toARGB32(),
      'iconSize': 18.0,
      'selectedIconSize': 22.0,
      'showLabels': false,
      'enableHaptics': false,
    });
  });
}
