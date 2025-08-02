import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverLocationPage extends StatefulWidget {
  const DriverLocationPage({super.key});

  @override
  State<DriverLocationPage> createState() => _DriverLocationPageState();
}

class _DriverLocationPageState extends State<DriverLocationPage> {
  GoogleMapController? _mapController;
  LatLng? _driverLatLng;
  BitmapDescriptor? _truckIcon;
  BitmapDescriptor? _shipIcon;
  bool isLoading = false;
  String? token;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = ModalRoute.of(context)?.settings.arguments as String?;
    _loadCustomIcons();
    _getCurrentLocation();
  }

  Future<void> _loadCustomIcons() async {
    final truck = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(19, 19)),
      'assets/images/truck_marker.png',
    );
    final ship = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(19, 19)),
      'assets/images/triangle_ship.png',
    );
    setState(() {
      _truckIcon = truck;
      _shipIcon = ship;
    });
  }

  Future<void> _getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showMessage('❌ GPS tidak aktif');
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showMessage('❌ Izin lokasi ditolak');
        return;
      }
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _driverLatLng = LatLng(position.latitude, position.longitude);
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_driverLatLng!, 15),
    );

    await _sendLocation(); // 🟡 langsung kirim lokasi ke server
  }

  Future<void> _sendLocation() async {
    if (_driverLatLng == null) {
      _showMessage('❌ Lokasi belum tersedia');
      return;
    }

    setState(() => isLoading = true);

    final url = Uri.parse('http://31.97.106.175:5000/api/location');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'lat': _driverLatLng!.latitude,
        'lng': _driverLatLng!.longitude,
      }),
    );

    if (response.statusCode == 200) {
      _showMessage('✅ Lokasi berhasil dikirim');
    } else {
      _showMessage('❌ Gagal kirim lokasi: ${response.body}');
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final shipMarkers = <Marker>{
      if (_shipIcon != null)
        Marker(
          markerId: const MarkerId('kapal1'),
          position: const LatLng(-6.220581, 107.916280),
          icon: _shipIcon!,
          infoWindow: const InfoWindow(title: 'KM PATIMBAN BARU'),
          rotation: 45.0,
          anchor: const Offset(0.5, 0.5),
        ),
      if (_shipIcon != null)
        Marker(
          markerId: const MarkerId('kapal2'),
          position: const LatLng(-6.209218, 107.924005),
          icon: _shipIcon!,
          infoWindow: const InfoWindow(title: 'KM TEST LAGI'),
          rotation: 135.0,
          anchor: const Offset(0.5, 0.5),
        ),
    };

    final truckMarker = (_driverLatLng != null && _truckIcon != null)
        ? {
            Marker(
              markerId: const MarkerId('driver'),
              position: _driverLatLng!,
              icon: _truckIcon!,
              infoWindow: const InfoWindow(title: 'Lokasi Saya (Truk)'),
            ),
          }
        : <Marker>{};

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Navigator.canPop(context) ? const BackButton() : null,
        title: const Text('Truck and Vessel'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: (_truckIcon == null || _shipIcon == null)
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-6.2, 107.9),
                zoom: 13,
              ),
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {...shipMarkers, ...truckMarker},
            ),
    );
  }
}
