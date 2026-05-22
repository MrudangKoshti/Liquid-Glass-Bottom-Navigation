import 'package:cupertino_liquid_navbar/cupertino_liquid_navbar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LiquidGlassNavItem.toMap returns expected map', () {
    const item = LiquidGlassNavItem(
      label: 'Home',
      sfSymbol: 'house',
      selectedSfSymbol: 'house.fill',
    );

    expect(item.toMap(), {
      'label': 'Home',
      'sfSymbol': 'house',
      'selectedSfSymbol': 'house.fill',
    });
  });
}
