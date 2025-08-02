import 'package:flutter/material.dart';

class OwnerOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Order Muatan'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(child: Text('Form input barang, tujuan, truk & kapal')),
    );
  }
}
