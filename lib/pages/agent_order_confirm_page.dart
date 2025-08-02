import 'package:flutter/material.dart';

class AgentOrderConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Muatan Kapal'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text('Daftar order yang harus dikonfirmasi agen kapal'),
      ),
    );
  }
}
