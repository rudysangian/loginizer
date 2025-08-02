// inbox_page.dart
import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responses = [
      {
        'vendor': 'PT. Sinar Logistik',
        'price': 'Rp1.200.000',
        'eta': '3 hours',
      },
      {
        'vendor': 'CV. Karya Angkut',
        'price': 'Rp1.150.000',
        'eta': '2.5 hours',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Inbox – Vendor Responses')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: responses.length,
        itemBuilder: (context, index) {
          final item = responses[index];
          return Card(
            child: ListTile(
              title: Text(item['vendor']!),
              subtitle: Text('Offer: ${item['price']} | ETA: ${item['eta']}'),
              trailing: const Icon(Icons.check_circle_outline),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You selected ${item['vendor']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
