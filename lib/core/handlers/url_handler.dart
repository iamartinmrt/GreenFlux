import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class UrlHandler{
  UrlHandler._();

  static final UrlHandler instance = UrlHandler._();

  void openMap(String lat, String lon){
    String mapUrl;
    if (Platform.isIOS) {
      mapUrl = Uri.encodeFull("https://maps.apple.com/?ll=$lat,$lon");
    } else {
      mapUrl = Uri.encodeFull("https://www.google.com/maps/search/?api=1&query=$lat,$lon");
    }
    launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
  }
}