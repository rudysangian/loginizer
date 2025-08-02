import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../iframe_element.dart'; // ⬅️ Sudah otomatis web-only

class IframeWidget extends StatelessWidget {
  final String viewType;
  final String src;
  final double width;
  final double height;

  const IframeWidget({
    Key? key,
    required this.viewType,
    required this.src,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      initIframeView();
      return SizedBox(
        width: width,
        height: height,
        child: HtmlElementView(viewType: viewType),
      );
    } else {
      return const Center(child: Text('Iframe hanya tersedia di Web.'));
    }
  }
}
