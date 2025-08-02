import 'package:flutter/material.dart';

class OrderKapalPage extends StatefulWidget {
  const OrderKapalPage({super.key});

  @override
  State<OrderKapalPage> createState() => _OrderKapalPageState();
}

class _OrderKapalPageState extends State<OrderKapalPage> {
  final _formKey = GlobalKey<FormState>();
  String pelabuhanAsal = '';
  String pelabuhanTujuan = '';
  String jenisMuatan = '';
  DateTime? estimasiTanggal;

  void _submitOrder() {
    if (_formKey.currentState!.validate() && estimasiTanggal != null) {
      // Simulasikan submit ke backend/logika lainnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Order Kapal terkirim!\n'
            'Asal: $pelabuhanAsal\n'
            'Tujuan: $pelabuhanTujuan\n'
            'Tanggal: ${estimasiTanggal!.toIso8601String().split("T")[0]}',
          ),
        ),
      );
      Navigator.pop(context); // Kembali ke dashboard
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        estimasiTanggal = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Kapal')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Pelabuhan Asal'),
                onChanged: (val) => pelabuhanAsal = val,
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pelabuhan Tujuan',
                ),
                onChanged: (val) => pelabuhanTujuan = val,
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Jenis Muatan'),
                onChanged: (val) => jenisMuatan = val,
                validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  estimasiTanggal == null
                      ? 'Pilih Estimasi Tanggal'
                      : 'Estimasi: ${estimasiTanggal!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitOrder,
                child: const Text('Kirim Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
