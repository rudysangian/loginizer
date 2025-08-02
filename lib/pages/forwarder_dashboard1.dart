import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_kapal_page.dart'; // pastikan file ini sudah ada

class ForwarderDashboard extends StatelessWidget {
  final String forwarderName;

  const ForwarderDashboard({required this.forwarderName, super.key});

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('forwarderName');
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _openMenu(BuildContext context, String title) {
    if (title == 'Order Kapal') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OrderKapalPage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$title coming soon')));
    }
  }

  Widget _buildMenuCard(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () => _openMenu(context, title),
      child: Card(
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Forwarder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $forwarderName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    Icons.directions_boat,
                    'Vessel Order',
                  ),
                  _buildMenuCard(context, Icons.local_shipping, 'Truck Order'),
                  _buildMenuCard(context, Icons.track_changes, 'Monitoring'),
                  _buildMenuCard(context, Icons.history, 'Historical'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
