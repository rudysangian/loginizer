// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui_web' as ui;
import 'dart:convert';
import 'package:flutter/material.dart';

class VesselMapWidget extends StatelessWidget {
  final String viewID = 'gmap-canvas';

  @override
  Widget build(BuildContext context) {
    // Registrasi tampilan Google Maps untuk platform web
    ui.platformViewRegistry.registerViewFactory(viewID, (int viewId) {
      final element = html.DivElement()
        ..id = viewID
        ..style.width = '100%'
        ..style.height = '100vh';
      return element;
    });

    // Kirim data kapal setelah frame selesai dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        final vessels = [
          {
            'name': 'KM PATIMBAN Ahmad',
            'lat': -6.220581,
            'lng': 107.916280,
            'heading': 90,
          },
          {
            'name': 'KM TEST Rizaldi',
            'lat': -6.209218,
            'lng': 107.924005,
            'heading': 135,
          },
        ];

        final encoded = jsonEncode(vessels);
        html.window.dispatchEvent(
          html.CustomEvent('loadMap', detail: {'vessels': encoded, 'zoom': 14}),
        );
      });
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Vessel Map Patimban'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: HtmlElementView(viewType: viewID),
    );
  }
}

// Tetap dipakai di route '/vessel-map' → dari menu drawer
class VesselMapWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VesselMapWidget();
  }
}
