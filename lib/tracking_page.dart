import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  Position? _currentPosition;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("❌ Izin lokasi ditolak");
    }
  }

  void _startTracking() {
    _timer = Timer.periodic(Duration(seconds: 30), (_) async {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() => _currentPosition = pos);

      // 📍 Simulasi kirim data
      print('📡 Lokasi: ${pos.latitude}, ${pos.longitude}');
    });
  }

  void _stopTracking() {
    _timer?.cancel();
    print('🛑 Tracking dihentikan');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LOGINIZER Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              _currentPosition != null
                  ? "📍 ${_currentPosition!.latitude}, ${_currentPosition!.longitude}"
                  : "Menunggu lokasi...",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTracking,
              child: Text("Mulai Tracking"),
            ),
            ElevatedButton(
              onPressed: _stopTracking,
              child: Text("Stop Tracking"),
            ),
          ],
        ),
      ),
    );
  }
}
