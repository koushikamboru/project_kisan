import 'package:flutter/material.dart';
import 'package:project_kisan/core/services/gemini_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _marketPrices = 'Loading market prices...';
  String _govtSchemes = 'Loading government schemes...';
  String _recentActivity = 'Loading recent activity...';

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    // Fetch market prices
    String marketPricesPrompt =
        "Get trending top marketing analysis for crops like tomato, potato, and onion. like stock market stocks";
    String marketPricesResponse = await GeminiService.getResponse(marketPricesPrompt);
    setState(() {
      _marketPrices = marketPricesResponse;
    });

    // Fetch government schemes
    String govtSchemesPrompt =
        "Get newly released government schemes for farmers like crop loans, solar support, subsidies for crops, agri vehicle etc.";
    String govtSchemesResponse = await GeminiService.getResponse(govtSchemesPrompt);
    setState(() {
      _govtSchemes = govtSchemesResponse;
    });

    // Fetch recent activity
    String recentActivityPrompt =
        "Do you want to examine the health of our crop to analysis and prevent disease and gain income, if there is no recent activity.";
    String recentActivityResponse =
        await GeminiService.getResponse(recentActivityPrompt);
    setState(() {
      _recentActivity = recentActivityResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Kisan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Voice Assistant Section
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.mic,
                      size: 60,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap to speak in your language',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'हिन्दी • English • ಕನ್ನಡ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: () {
                        // TODO: Implement crop diagnosis functionality
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'Scan for crop diagnosis',
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Actions Section
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickAction(
                      Icons.camera_alt, 'Crop Diagnosis', 'Take photo'),
                  _buildQuickAction(
                      Icons.trending_up, 'Market Prices', 'Live rates'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickAction(
                      Icons.account_balance, 'Govt Schemes', 'Find subsidies'),
                  _buildQuickAction(Icons.wb_sunny, 'Weather', '7-day forecast'),
                ],
              ),
              const SizedBox(height: 24),

              // Recent Activity Section
              const Text(
                'Recent Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInfoCard(context, _recentActivity),
              const SizedBox(height: 24),

              // Today's Market Section
              const Text(
                "Today's Market",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInfoCard(context, _marketPrices),
              const SizedBox(height: 24),

              // Available Schemes Section
              const Text(
                'Available Schemes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInfoCard(context, _govtSchemes),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.green,
          size: 40,
        ),
        const SizedBox(height: 8),
        Text(title),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(content),
      ),
    );
  }
}
