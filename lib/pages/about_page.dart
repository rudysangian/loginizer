import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'oSBdA90FsrI',
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('About LOGINIZER'),
            centerTitle: true,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'LOGINIZER',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Smart Logistics Coordination',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  'LOGINIZER is a smart logistics coordination tool designed to streamline port operations and transport activities through better synchronization. '
                  'Inspired by the Integrated Port Model (IPM) framework, LOGINIZER simplifies the complexity of port processes into actionable digital steps that '
                  'connect vessel agents, truck drivers, customs brokers, and terminal operators in real time.',
                  style: TextStyle(fontSize: 15, height: 1.5),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                const Text(
                  'By focusing on coordination, rather than just automation, LOGINIZER helps reduce waiting times, prevent bottlenecks, and ensure that all parties '
                  'involved in port logistics are informed and aligned. It is built for modern logistics players who demand precision, visibility, and accountability.',
                  style: TextStyle(fontSize: 15, height: 1.5),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: player,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
