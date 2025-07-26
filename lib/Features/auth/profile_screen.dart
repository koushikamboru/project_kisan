// lib/Features/auth/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Kisan/Features/auth/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryGreen = Color(0xFF388E3C);
  static const Color lightGreyBackground = Color(0xFFF7F9F7);
  static const Color secondaryTextColor = Colors.black54;

  // Function to show the logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Are you sure you want to log out?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                // Perform logout action
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);

                // Close the dialog and navigate to the login screen
                Navigator.of(dialogContext).pop();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreyBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: lightGreyBackground,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(),
              const SizedBox(height: 30),
              _buildFarmDetailsCard(),
              const SizedBox(height: 20),
              _buildMenuItems(context), // Pass context here
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the list of menu items
  Widget _buildMenuItems(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(context, Icons.person_outline, 'Personal Information'),
          _buildMenuItem(context, Icons.eco_outlined, 'Crop Management'),
          _buildMenuItem(
            context,
            Icons.bar_chart_outlined,
            'Market Preferences',
          ),
          _buildMenuItem(context, Icons.language_outlined, 'Language & Region'),
          _buildMenuItem(
            context,
            Icons.notifications_outlined,
            'Notifications',
          ),
          _buildMenuItem(
            context,
            Icons.privacy_tip_outlined,
            'Privacy & Security',
          ),
          _buildMenuItem(context, Icons.help_outline, 'Help & Support'),
          _buildMenuItem(context, Icons.logout, 'Logout', isLogout: true),
        ],
      ),
    );
  }

  // Helper for a single menu item
  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red.shade700 : primaryGreen),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isLogout ? Colors.red.shade700 : Colors.black87,
        ),
      ),
      // UPDATED: Conditionally hide the trailing icon for the logout button
      trailing:
          isLogout
              ? null
              : const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
      onTap: () {
        // UPDATED: Handle menu item tap
        if (isLogout) {
          // Show confirmation dialog on logout tap
          _showLogoutConfirmationDialog(context);
        } else {
          // Handle other menu item taps
        }
      },
    );
  }

  // Other helper widgets (_buildProfileHeader, _buildFarmDetailsCard, etc.)
  // remain the same and are omitted here for brevity.
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[200],
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.black54,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Rajesh Kumar',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Farmer - Maharashtra',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              'Member since Jan 2025',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFarmDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.agriculture, color: primaryGreen),
              SizedBox(width: 8),
              Text(
                'Farm Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          _buildDetailRow('Farm Size', '2.5 acres'),
          _buildDetailRow('Primary Crop', 'Tomatoes'),
          _buildDetailRow('Location', 'Nashik, Maharashtra'),
          _buildDetailRow('Soil Type', 'Black Cotton'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: secondaryTextColor),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
