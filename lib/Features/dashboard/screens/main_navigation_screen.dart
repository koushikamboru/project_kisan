// lib/Features/dashboard/screens/main_navigation_screen.dart
import 'package:flutter/material.dart';
import 'package:Kisan/Features/auth/screens/profile_screen.dart';
import 'package:Kisan/Features/dashboard/screens/dashboard_screen.dart';
import 'package:Kisan/Features/diagnosis/screens/camera_view_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:Kisan/Features/market_prices/screens/market_prices_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const CameraViewScreen(),
    const Center(child: Text('Market Page')),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _pages[0];
      case 1:
        return _pages[1];
      case 3:
        return _pages[2];
      case 4:
        return _pages[3];
      default:
        return _pages[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(),
      floatingActionButton: SpeedDial(
        // UPDATED: The main icon is now a menu icon. It will toggle the menu.
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: 'Profile',
            onTap: () => _onItemTapped(4),
          ),
          // ADDED: The "Voice" action is now an option within the menu.
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
        // REMOVED: The 'onPress' property was removed from here to allow the
        // default open/close behavior.
      ),
    );
  }
}
