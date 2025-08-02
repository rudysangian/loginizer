import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forwarder_dashboard.dart';
import 'forwarder_register_page.dart'; // pastikan file ini ada

class ForwarderLoginPage extends StatefulWidget {
  const ForwarderLoginPage({super.key});

  @override
  State<ForwarderLoginPage> createState() => _ForwarderLoginPageState();
}

class _ForwarderLoginPageState extends State<ForwarderLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('forwarderName', _nameController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ForwarderDashboard(forwarderName: _nameController.text),
        ),
      );
    }
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForwarderRegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Forwarder')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Login as Forwarder',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Forwarder Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name mandatory' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _login, child: const Text('Login')),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _goToRegister,
                child: const Text("Don't have an account? Register here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
