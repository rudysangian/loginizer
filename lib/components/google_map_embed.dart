// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GoogleMapEmbed extends StatelessWidget {
  final String viewId;
  final double lat;
  final double lng;
  final int zoom;

  const GoogleMapEmbed({
    Key? key,
    required this.viewId,
    required this.lat,
    required this.lng,
    this.zoom = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      final element = html.DivElement()
        ..id = viewId
        ..style.width = '100%'
        ..style.height = '100vh';

      js.context.callMethod('initMapWithParams', [lat, lng, zoom]);
      return element;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Peta Google (Embed Modular)')),
      body: HtmlElementView(viewType: viewId),
    );
  }
}
