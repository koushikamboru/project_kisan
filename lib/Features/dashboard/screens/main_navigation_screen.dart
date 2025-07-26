// lib/Features/dashboard/screens/main_navigation_screen.dart
import 'package:flutter/material.dart';
import '../../../Features/auth/profile_screen.dart';
import '../../../Features/dashboard/screens/dashboard_screen.dart';
import '../../../Features/disease_diagnosis/camera_view_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../../Features/market_prices/market_prices_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    const CameraViewScreen(),
    MarketPricesScreen(), // FIXED: Use actual MarketPricesScreen
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getCurrentPage() {
    // FIXED: Use _currentIndex directly, fallback to DashboardScreen
    if (_currentIndex >= 0 && _currentIndex < _pages.length) {
      return _pages[_currentIndex];
    }
    return _pages[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        buttonSize: const Size(60.0, 60.0),
        childrenButtonSize: const Size(60.0, 60.0),
        spacing: 12,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.home),
            label: 'Home',
            onTap: () => _onItemTapped(0),
          ),
          SpeedDialChild(
            child: const Icon(Icons.qr_code_scanner),
            label: 'Scan',
            onTap: () => _onItemTapped(1),
          ),
          SpeedDialChild(
            child: const Icon(Icons.storefront),
            label: 'Market',
            onTap: () => _onItemTapped(2), // FIXED: Use tab index
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: 'Profile',
            onTap: () => _onItemTapped(3), // FIXED: Use tab index
          ),
          SpeedDialChild(
            child: const Icon(Icons.mic),
            label: 'Voice',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Voice Action Tapped!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
