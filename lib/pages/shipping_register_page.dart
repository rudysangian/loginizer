import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShippingRegisterPage extends StatefulWidget {
  final VoidCallback? onRegisterSuccess;

  const ShippingRegisterPage({Key? key, this.onRegisterSuccess})
    : super(key: key);

  @override
  State<ShippingRegisterPage> createState() => _ShippingRegisterPageState();
}

class _ShippingRegisterPageState extends State<ShippingRegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<TextEditingController> shipControllers = [TextEditingController()];

  Future<void> handleRegister() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        shipControllers.any((controller) => controller.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ All fields are required')),
      );
      return;
    }

    final List<String> ships = shipControllers.map((c) => c.text).toList();

    final url = Uri.parse('http://31.97.106.175:5000/api/register_shipping');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': nameController.text,
          'hp': phoneController.text,
          'password': passwordController.text,
          'kapal': ships,
        }),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        FocusScope.of(context).unfocus();

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('✅ ${result['message']}')));

        await Future.delayed(const Duration(milliseconds: 700));

        if (context.mounted) {
          widget.onRegisterSuccess?.call();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '❌ Registration failed: ${result['error'] ?? response.body}',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ Network error: $e')));
    }
  }

  void addShipField() {
    setState(() {
      shipControllers.add(TextEditingController());
    });
  }

  void removeShipField(int index) {
    setState(() {
      shipControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Line Registration'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Owned Ships',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              ...shipControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Ship Name ${index + 1}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (shipControllers.length > 1)
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          onPressed: () => removeShipField(index),
                        ),
                    ],
                  ),
                );
              }),
              TextButton.icon(
                onPressed: addShipField,
                icon: const Icon(Icons.add),
                label: const Text('Add Another Ship'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.indigo,
                ),
                onPressed: handleRegister,
                child: const Text('Register Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
