// monitoring_page.dart
import 'package:flutter/material.dart';

class MonitoringPage extends StatelessWidget {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeShipments = [
      {'id': 'REQ-001', 'status': 'On the way', 'driver': 'Andi – B 1234 XYZ'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Monitoring – Active Shipments')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: activeShipments.length,
        itemBuilder: (context, index) {
          final item = activeShipments[index];
          return Card(
            child: ListTile(
              title: Text('Request ID: ${item['id']}'),
              subtitle: Text(
                'Status: ${item['status']}\nDriver: ${item['driver']}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
