import 'package:flutter/material.dart';

class RequestShipmentPage extends StatelessWidget {
  const RequestShipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController fromController = TextEditingController();
    final TextEditingController toController = TextEditingController();
    final TextEditingController itemController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
    final TextEditingController phoneController =
        TextEditingController(); // new

    return Scaffold(
      appBar: AppBar(title: const Text('Request Shipment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: fromController,
                decoration: const InputDecoration(labelText: 'Pickup Location'),
              ),
              TextFormField(
                controller: toController,
                decoration: const InputDecoration(labelText: 'Destination'),
              ),
              TextFormField(
                controller: itemController,
                decoration: const InputDecoration(
                  labelText: 'Item Description',
                ),
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight/Volume'),
              ),
              TextFormField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                ),
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Mobilephone (WhatsApp)',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Shipment request sent!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
