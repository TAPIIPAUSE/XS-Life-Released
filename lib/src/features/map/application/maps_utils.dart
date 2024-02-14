import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:xs_life/src/common_widgets/map_sheet.dart';

class MapUtils {
  static Future<void> openMap(BuildContext context, String title, double latitude, double longitude) async {
    final availableMaps = await MapLauncher.installedMaps;
    if (availableMaps.isNotEmpty) {
      MapsSheet.show(
        context: context,
        onMapTap: (map) {
          map.showMarker(
            coords: Coords(latitude, longitude),
            title: title
          );
        },
      );
    } else {
      Uri googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
      if (await canLaunchUrl(googleUrl)) {
        await launchUrl(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }
}