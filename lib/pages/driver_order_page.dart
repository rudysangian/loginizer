import 'package:flutter/material.dart';

class DriverOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Saya (Truk)'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(child: Text('Daftar order yang ditugaskan ke truk ini')),
    );
  }
}
