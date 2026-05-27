import 'package:cupertino_liquid_navbar/cupertino_liquid_navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LiquidNavbarExampleApp());
}

class LiquidNavbarExampleApp extends StatelessWidget {
  const LiquidNavbarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupertino Liquid Navbar Example',
      theme: ThemeData(useMaterial3: true),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int index = 0;
  bool forceFallback = false;
  bool showDebugBounds = false;

  LiquidGlassPreset preset = LiquidGlassPreset.balanced;
  LiquidGlassSelectedStyle selectedStyle = LiquidGlassSelectedStyle.bubble;
  LiquidGlassMaterialStyle containerMaterial =
      LiquidGlassMaterialStyle.ultraThin;
  LiquidGlassMaterialStyle selectedMaterial = LiquidGlassMaterialStyle.thin;

  double intensity = 1.0;
  double chromatic = 0.72;
  double containerBorder = 0.52;
  double selectedBorder = 0.78;
  double selectedShadow = 0.16;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPage('Home'),
      _buildPage('Calls'),
      _buildPage('Communities'),
      _buildPage('Chats'),
    ];

    final style = LiquidGlassNavStyle(
      preset: preset,
      selectedStyle: selectedStyle,
      intensity: intensity,
      forceFallback: forceFallback,
      debugShowBounds: showDebugBounds,
      layout: const LiquidGlassLayoutStyle(
        height: 76,
        borderRadius: 36,
        itemSpacing: 6,
        verticalPadding: 7,
      ),
      container: LiquidGlassContainerStyle(
        materialStyle: containerMaterial,
        borderOpacity: containerBorder,
        shadowOpacity: 0.12,
      ),
      selected: LiquidGlassSelectedItemStyle(
        materialStyle: selectedMaterial,
        borderOpacity: selectedBorder,
        shadowOpacity: selectedShadow,
        chromaticAberrationOpacity: chromatic,
      ),
      iconAndLabel: const LiquidGlassIconLabelStyle(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
      ),
      animation: const LiquidGlassAnimationStyle(
        response: 0.24,
        dampingFraction: 0.84,
      ),
    );

    return LiquidGlassScaffold(
      selectedIndex: index,
      onTap: (value) => setState(() => index = value),
      style: style,
      items: const [
        LiquidGlassNavItem(
          label: 'Home',
          sfSymbol: 'house',
          selectedSfSymbol: 'house.fill',
          fallbackIcon: Icons.home_outlined,
          selectedFallbackIcon: Icons.home,
        ),
        LiquidGlassNavItem(
          label: 'Calls',
          sfSymbol: 'phone',
          selectedSfSymbol: 'phone.fill',
          fallbackIcon: Icons.call_outlined,
          selectedFallbackIcon: Icons.call,
        ),
        LiquidGlassNavItem(
          label: 'Communities',
          sfSymbol: 'person.3',
          selectedSfSymbol: 'person.3.fill',
          fallbackIcon: Icons.groups_outlined,
          selectedFallbackIcon: Icons.groups,
        ),
        LiquidGlassNavItem(
          label: 'Chats',
          sfSymbol: 'bubble.left.and.bubble.right',
          selectedSfSymbol: 'bubble.left.and.bubble.right.fill',
          fallbackIcon: Icons.chat_bubble_outline,
          selectedFallbackIcon: Icons.chat,
        ),
      ],
      body: Stack(
        children: [
          pages[index],
          Positioned(top: 52, left: 16, right: 16, child: _controlPanel()),
        ],
      ),
    );
  }

  Widget _controlPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: _enumDropdown(
                    'Preset',
                    LiquidGlassPreset.values,
                    preset,
                    (v) => setState(() => preset = v),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _enumDropdown(
                    'Selected',
                    LiquidGlassSelectedStyle.values,
                    selectedStyle,
                    (v) => setState(() => selectedStyle = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _enumDropdown(
                    'Container',
                    LiquidGlassMaterialStyle.values,
                    containerMaterial,
                    (v) => setState(() => containerMaterial = v),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _enumDropdown(
                    'Selected',
                    LiquidGlassMaterialStyle.values,
                    selectedMaterial,
                    (v) => setState(() => selectedMaterial = v),
                  ),
                ),
              ],
            ),
            _slider(
              'Intensity',
              intensity,
              0,
              1.3,
              (v) => setState(() => intensity = v),
            ),
            _slider(
              'Chromatic',
              chromatic,
              0,
              1.2,
              (v) => setState(() => chromatic = v),
            ),
            _slider(
              'Container Border',
              containerBorder,
              0,
              1,
              (v) => setState(() => containerBorder = v),
            ),
            _slider(
              'Selected Border',
              selectedBorder,
              0,
              1,
              (v) => setState(() => selectedBorder = v),
            ),
            _slider(
              'Selected Shadow',
              selectedShadow,
              0,
              0.4,
              (v) => setState(() => selectedShadow = v),
            ),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Fallback'),
                    value: forceFallback,
                    onChanged: (v) => setState(() => forceFallback = v),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Debug Bounds'),
                    value: showDebugBounds,
                    onChanged: (v) => setState(() => showDebugBounds = v),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: FutureBuilder<LiquidGlassCapabilities>(
                future: LiquidGlassCapabilities.query(),
                builder: (context, snapshot) {
                  final caps = snapshot.data;
                  if (caps == null) {
                    return const Text('Capabilities: loading...');
                  }
                  return Text(
                    'Capabilities: material=${caps.supportsMaterial}, compositing=${caps.supportsAdvancedCompositing}, symbols=${caps.supportsSymbolEffects}',
                    style: const TextStyle(fontSize: 11),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(width: 120, child: Text(label)),
        Expanded(
          child: Slider(value: value, min: min, max: max, onChanged: onChanged),
        ),
      ],
    );
  }

  Widget _enumDropdown<T>(
    String label,
    List<T> values,
    T selected,
    ValueChanged<T> onChanged,
  ) {
    return DropdownButtonFormField<T>(
      initialValue: selected,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        border: const OutlineInputBorder(),
      ),
      items: values
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(e.toString().split('.').last),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }

  Widget _buildPage(String title) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE9E7FF), Color(0xFFFFF1D1), Color(0xFFD6FFFA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
