// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

void initIframeView() {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory('vessel-iframe', (int viewId) {
    final iframe = IFrameElement()
      ..src =
          'https://www.marinetraffic.com/en/ais/embed/zoom:12/centerx:107.734/centery:-6.740/maptype:1'
      ..style.border = 'none';
    return iframe;
  });
}
