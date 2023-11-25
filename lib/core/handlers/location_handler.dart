import 'package:geolocator/geolocator.dart';
import 'package:green_flux/presentation/presentation_models/location_presentation.dart';

class LocationHandler {
  static String calculateDistance(
      LatLonData userLatLon, LatLonData stationLatLon) {
    final double distance = Geolocator.distanceBetween(
        userLatLon.lat, userLatLon.lon, stationLatLon.lat, stationLatLon.lon);
    String formattedDistance = "";
    // If more than 1000 meter, show kilometer
    if (distance > 1000) {
      formattedDistance = "${(distance / 1000).toStringAsFixed(1)} km";
    } else {
      formattedDistance = "${distance.toInt()} m";
    }
    return formattedDistance;
  }
}
