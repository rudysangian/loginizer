import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForwarderRegisterPage extends StatefulWidget {
  final VoidCallback? onRegisterSuccess;

  const ForwarderRegisterPage({Key? key, this.onRegisterSuccess})
    : super(key: key);

  @override
  State<ForwarderRegisterPage> createState() => _ForwarderRegisterPageState();
}

class _ForwarderRegisterPageState extends State<ForwarderRegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> handleRegister() async {
    if (nameController.text.isEmpty ||
        companyController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ All fields are required')),
      );
      return;
    }

    final url = Uri.parse('http://31.97.106.175:5000/api/register-forwarder');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': nameController.text,
          'perusahaan': companyController.text,
          'hp': phoneController.text,
          'password': passwordController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forwarder Registration'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Contact Person Name',
                ),
              ),
              TextField(
                controller: companyController,
                decoration: const InputDecoration(labelText: 'Company Name'),
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
              const SizedBox(height: 20),
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
