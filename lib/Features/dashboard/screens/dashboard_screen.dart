// lib/Features/dashboard/screens/dashboard_screen.dart
import 'package:flutter/material.dart';

// UPDATED: This is now a stateless widget as it no longer manages navigation state.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // UPDATED: Removed the Scaffold, BottomNavigationBar, and FloatingActionButton.
    // It now only returns the content for the dashboard.
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kToolbarHeight - 10),
              // 1. Custom AppBar
              const _CustomAppBar(),
              const SizedBox(height: 24),

              // 2. Voice Input Section
              const _VoiceInputSection(),
              const SizedBox(height: 32),

              // 3. Quick Actions Section
              const _SectionHeader(title: 'Quick Actions'),
              const _QuickActionsGrid(),
              const SizedBox(height: 32),

              // 4. Recent Activity Section
              const _SectionHeader(title: 'Recent Activity'),
              const SizedBox(height: 16),
              const _RecentActivityList(),
              const SizedBox(height: 32),

              // 5. Today's Market Section
              const _SectionHeader(title: "Today's Market"),
              const SizedBox(height: 16),
              const _TodaysMarketList(),
              const SizedBox(height: 32),

              // 6. Available Schemes Section
              _SectionHeader(
                title: 'Available Schemes',
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ),
              const SizedBox(height: 16),
              const _AvailableSchemesList(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ALL THE HELPER WIDGETS BELOW THIS LINE REMAIN THE SAME
// ... (_SectionHeader, _CustomAppBar, _VoiceInputSection, etc.)
// (No changes needed for the helper widgets, so they are omitted here for brevity)
class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const _SectionHeader({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// Section 1: Custom AppBar
class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Project Kisan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            const CircleAvatar(child: Icon(Icons.person)),
          ],
        ),
      ],
    );
  }
}

/// Section 2: Voice Input
class _VoiceInputSection extends StatelessWidget {
  const _VoiceInputSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2F4F4F), // Dark Slate Gray
              ),
              child: IconButton(
                icon: const Icon(Icons.mic, color: Colors.white),
                iconSize: 30,
                padding: const EdgeInsets.all(24),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap to speak in your language',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              'हिन्दी • English • Kannada',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}

/// Section 3: Quick Actions
class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 10,
      childAspectRatio: 1.4,
      children: const [
        _QuickActionCard(
          icon: Icons.camera_alt,
          title: 'Crop Diagnosis',
          subtitle: 'Take photo',
        ),
        _QuickActionCard(
          icon: Icons.show_chart,
          title: 'Market Prices',
          subtitle: 'Live rates',
        ),
        _QuickActionCard(
          icon: Icons.account_balance,
          title: 'Govt Schemes',
          subtitle: 'Find subsidies',
        ),
        _QuickActionCard(
          icon: Icons.wb_sunny,
          title: 'Weather',
          subtitle: '7-day forecast',
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: Theme.of(context).primaryColor),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section 4: Recent Activity
class _RecentActivityList extends StatelessWidget {
  const _RecentActivityList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.bug_report, color: Colors.redAccent),
            title: const Text('Tomato Leaf Blight Detected'),
            subtitle: const Text('2 hours ago • Treatment suggested'),
            onTap: () {},
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(
              Icons.currency_rupee,
              color: Colors.greenAccent,
            ),
            title: const Text('Onion Prices Updated'),
            subtitle: const Text('₹45/kg • 15% increase from yesterday'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

/// Section 5: Today's Market
class _TodaysMarketList extends StatelessWidget {
  const _TodaysMarketList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _MarketPriceItem(
            name: 'Tomato',
            price: '₹52/kg',
            change: '+5%',
            isPositive: true,
          ),
          SizedBox(width: 16),
          _MarketPriceItem(
            name: 'Potato',
            price: '₹28/kg',
            change: '-2%',
            isPositive: false,
          ),
          SizedBox(width: 16),
          _MarketPriceItem(
            name: 'Onion',
            price: '₹45/kg',
            change: '+15%',
            isPositive: true,
          ),
        ],
      ),
    );
  }
}

class _MarketPriceItem extends StatelessWidget {
  final String name;
  final String price;
  final String change;
  final bool isPositive;

  const _MarketPriceItem({
    required this.name,
    required this.price,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Spacer(),
            Text(price, style: const TextStyle(fontSize: 18)),
            Text(
              change,
              style: TextStyle(color: isPositive ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section 6: Available Schemes
class _AvailableSchemesList extends StatelessWidget {
  const _AvailableSchemesList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SchemeInfoCard(
          icon: Icons.water_drop,
          iconColor: Colors.blue,
          title: 'Drip Irrigation Subsidy',
          details: 'Up to 90% subsidy • Apply by March 31',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _SchemeInfoCard(
          icon: Icons.eco,
          iconColor: Colors.green,
          title: 'Organic Farming Support',
          details: '₹31,000 per hectare • New applications open',
          onTap: () {},
        ),
      ],
    );
  }
}

class _SchemeInfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String details;
  final VoidCallback onTap;

  const _SchemeInfoCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.details,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(details),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
