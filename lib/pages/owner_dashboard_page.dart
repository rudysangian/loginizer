import 'package:flutter/material.dart';

class OwnerDashboardPage extends StatelessWidget {
  final String nama;
  final String perusahaan;

  const OwnerDashboardPage({required this.nama, required this.perusahaan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard $perusahaan'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(child: Text('Status semua order milik $nama')),
    );
  }
}
