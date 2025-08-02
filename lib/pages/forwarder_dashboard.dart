import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'request_shipment_page.dart';
import 'inbox_page.dart';
import 'monitoring_page.dart';
import 'history_page.dart';

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
    Widget page;

    switch (title) {
      case 'Request Shipment':
        page = const RequestShipmentPage();
        break;
      case 'Inbox':
        page = const InboxPage();
        break;
      case 'Monitoring':
        page = const MonitoringPage();
        break;
      case 'History':
        page = const HistoryPage();
        break;
      default:
        page = const Scaffold(body: Center(child: Text('Coming soon...')));
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget _buildFlatMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () => _openMenu(context, title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loginizer – Dashboard'),
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '"Your cargo is our priority. Let the right movers come to you."',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildFlatMenuItem(context, Icons.send, 'Request Shipment'),
                  _buildFlatMenuItem(context, Icons.inbox, 'Inbox'),
                  _buildFlatMenuItem(
                    context,
                    Icons.track_changes,
                    'Monitoring',
                  ),
                  _buildFlatMenuItem(context, Icons.history, 'History'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
