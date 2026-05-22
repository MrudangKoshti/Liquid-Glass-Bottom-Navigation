# cupertino_liquid_navbar

A Flutter plugin that provides an iOS-native bottom navigation bar experience with a Flutter glass-style fallback on non-native or unsupported platforms.

## Platform Support

| Platform | Behavior |
|---|---|
| iOS 26+ | Native Liquid Glass |
| iOS < 26 | Native material fallback |
| Android | Flutter fallback |
| Web | Flutter fallback |
| macOS/Windows/Linux | Flutter fallback |

## Installation

```yaml
dependencies:
  cupertino_liquid_navbar: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Basic Usage

```dart
import 'package:cupertino_liquid_navbar/cupertino_liquid_navbar.dart';
import 'package:flutter/material.dart';
```

## `LiquidGlassScaffold` Usage

```dart
LiquidGlassScaffold(
  selectedIndex: index,
  onTap: (value) => setState(() => index = value),
  items: const [
    LiquidGlassNavItem(
      label: 'Home',
      sfSymbol: 'house',
      selectedSfSymbol: 'house.fill',
      fallbackIcon: Icons.home_outlined,
      selectedFallbackIcon: Icons.home,
    ),
    LiquidGlassNavItem(
      label: 'Search',
      sfSymbol: 'magnifyingglass',
      fallbackIcon: Icons.search,
    ),
  ],
  body: pages[index],
)
```

## `LiquidGlassBottomNavBar` Usage

```dart
LiquidGlassBottomNavBar(
  selectedIndex: index,
  onTap: (value) => setState(() => index = value),
  style: const LiquidGlassNavStyle(
    forceFallback: false,
    useNativeOnIOS: true,
  ),
  items: const [
    LiquidGlassNavItem(label: 'Home', sfSymbol: 'house', fallbackIcon: Icons.home),
    LiquidGlassNavItem(label: 'Search', sfSymbol: 'magnifyingglass', fallbackIcon: Icons.search),
  ],
)
```

## SF Symbols Note

On iOS native rendering, `sfSymbol` and `selectedSfSymbol` are used with `Image(systemName:)`.

## Fallback Note

On Android, Web, Desktop, and when `forceFallback: true`, the widget uses a pure Flutter glass-style fallback with blur and Material icons.

## Limitations

- True Liquid Glass is available only on supported Apple OS versions.
- Non-iOS platforms use a Flutter approximation.
- Native iOS changes require a full rebuild, not only hot reload.
- Use `forceFallback` to test fallback mode quickly.
