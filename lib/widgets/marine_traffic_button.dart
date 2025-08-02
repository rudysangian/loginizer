import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MarineTrafficButton extends StatelessWidget {
  const MarineTrafficButton({super.key});

  void _launchMarineTraffic() async {
    final Uri url = Uri.parse(
      'https://www.marinetraffic.com/en/ais/home/centerx:107.4/centery:-6.7/zoom:10',
    );
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _launchMarineTraffic,
      icon: Icon(Icons.open_in_browser),
      label: const Text('Buka MarineTraffic.com'),
    );
  }
}
