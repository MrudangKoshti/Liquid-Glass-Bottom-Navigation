import 'package:flutter/foundation.dart';

class LiquidGlassController extends ChangeNotifier {
  LiquidGlassController({int initialIndex = 0}) : _index = initialIndex;

  int _index;

  int get index => _index;

  set index(int value) {
    if (_index == value) return;
    _index = value;
    notifyListeners();
  }
}
