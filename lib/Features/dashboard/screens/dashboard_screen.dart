// lib/Features/dashboard/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../../../core/services/scheme_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final SchemeService _schemeService = SchemeService();
  String _schemeInfo = '';

  Future<void> _getSchemeInfo(String query) async {
    String info = await _schemeService.getSchemeInfo(query);
    setState(() {
      _schemeInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Government Schemes')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _getSchemeInfo('subsidies for drip irrigation'),
            child: Text('Get Scheme Info'),
          ),
          Text(_schemeInfo),
        ],
      ),
    );
  }
}
