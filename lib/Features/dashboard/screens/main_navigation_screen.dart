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
    MarketPricesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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
            child: const Icon(Icons.camera_alt),
            label: 'Scan',
            onTap: () => _onItemTapped(1),
          ),
          SpeedDialChild(
            child: const Icon(Icons.storefront),
            label: 'Market',
            onTap: () => _onItemTapped(2),
          ),
          SpeedDialChild(
            child: const Icon(Icons.person),
            label: 'Profile',
            onTap: () => _onItemTapped(3),
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
