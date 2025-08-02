// history_page.dart
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {'id': 'REQ-000', 'status': 'Completed', 'date': '18 Jul 2025'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('History – Past Shipments')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            child: ListTile(
              title: Text('Request ID: ${item['id']}'),
              subtitle: Text(
                'Date: ${item['date']} | Status: ${item['status']}',
              ),
            ),
          );
        },
      ),
    );
  }
}
