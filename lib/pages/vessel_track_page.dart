import 'package:flutter/material.dart';
import 'package:ipm_web/widgets/google_map_section.dart';
import 'package:ipm_web/widgets/marine_traffic_button.dart';

class VesselTrackPage extends StatelessWidget {
  const VesselTrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Navigator.canPop(context) ? BackButton() : null,
        title: Row(
          children: const [
            Icon(Icons.map, color: Colors.white),
            SizedBox(width: 8),
            Text('Peta Kapal & Truk - Patimban'),
          ],
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: const [
          Expanded(flex: 3, child: GoogleMapSection()),
          Expanded(flex: 1, child: Center(child: MarineTrafficButton())),
        ],
      ),
    );
  }
}
