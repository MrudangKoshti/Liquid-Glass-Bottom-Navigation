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

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildPage('Home'),
      _buildPage('Search'),
      _buildPage('Orders'),
      _buildPage('Profile'),
    ];

    return LiquidGlassScaffold(
      selectedIndex: index,
      onTap: (value) => setState(() => index = value),
      style: LiquidGlassNavStyle(forceFallback: forceFallback),
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
        LiquidGlassNavItem(
          label: 'Orders',
          sfSymbol: 'bag',
          selectedSfSymbol: 'bag.fill',
          fallbackIcon: Icons.shopping_bag_outlined,
          selectedFallbackIcon: Icons.shopping_bag,
        ),
        LiquidGlassNavItem(
          label: 'Profile',
          sfSymbol: 'person',
          selectedSfSymbol: 'person.fill',
          fallbackIcon: Icons.person_outline,
          selectedFallbackIcon: Icons.person,
        ),
      ],
      body: Stack(
        children: [
          pages[index],
          Positioned(
            top: 60,
            right: 20,
            child: Row(
              children: [
                const Text('Force fallback'),
                Switch(
                  value: forceFallback,
                  onChanged: (value) {
                    setState(() => forceFallback = value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFE0E9), Color(0xFFB5FFFC), Color(0xFFFFF6B7)],
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
