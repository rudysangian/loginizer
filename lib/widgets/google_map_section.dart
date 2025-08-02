import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapSection extends StatefulWidget {
  const GoogleMapSection({super.key});

  @override
  State<GoogleMapSection> createState() => _GoogleMapSectionState();
}

class _GoogleMapSectionState extends State<GoogleMapSection> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(-6.9271, 107.6348); // Bandung
  final Set<Marker> _markers = {};
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _addKapalMarker(); // ⛴️ Tambahkan kapal sejak awal
  }

  void _addKapalMarker() {
    _markers.add(
      Marker(
        markerId: const MarkerId("kapal"),
        position: const LatLng(-6.9310, 107.6350),
        infoWindow: const InfoWindow(title: "🚢 Kapal di Area Labuh"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  Future<void> _getCurrentLocationAndAddMarker() async {
    setState(() => _loading = true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('GPS belum aktif.')));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izin lokasi tidak diberikan.')),
        );
        return;
      }
    }

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final LatLng userLatLng = LatLng(position.latitude, position.longitude);

    // Hapus truk lama dulu
    _markers.removeWhere((m) => m.markerId.value == "truk");

    // Tambahkan marker baru
    _markers.add(
      Marker(
        markerId: const MarkerId("truk"),
        position: userLatLng,
        infoWindow: const InfoWindow(title: "🚚 Truk Anda"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    mapController.animateCamera(CameraUpdate.newLatLngZoom(userLatLng, 14));

    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📍 Lokasi berhasil dikirim.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: _loading
                ? const Text("Mengirim...")
                : const Text("Kirim Lokasi"),
            onPressed: _loading ? null : _getCurrentLocationAndAddMarker,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
