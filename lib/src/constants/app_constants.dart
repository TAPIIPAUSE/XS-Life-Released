import 'package:global_configuration/global_configuration.dart';
import 'package:latlong2/latlong.dart';

class AppConstants {
  // Location for the map
  static final kmuttLocation = LatLng(
      GlobalConfiguration().get("lat"), GlobalConfiguration().get("long"));

  // The zoom variable for the map
  static final mapZoom = GlobalConfiguration().get("map_zoom");
}
