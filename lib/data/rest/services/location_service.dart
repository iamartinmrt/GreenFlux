import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_flux/presentation/presentation_models/location_presentation.dart';

final stateLocationService = Provider<FacadeLocationService>((ref) => LocationService());

class LocationService implements FacadeLocationService{
  @override
  Future<LocationPermission> checkPermission() async => await Geolocator.checkPermission();

  @override
  Future<Position> getCurrentPosition() async => await Geolocator.getCurrentPosition();

  @override
  Future<bool> isLocationServiceEnabled() async => await Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> requestPermission() async => await Geolocator.requestPermission();

  @override
  Future<String?> getCityNameByCoordinates(LatLonData location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.lat,
      location.lon,
    );
    return placemarks[0].locality;
  }

}

abstract class FacadeLocationService{
  Future<bool> isLocationServiceEnabled();
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
  Future<Position> getCurrentPosition();
  Future<String?> getCityNameByCoordinates(LatLonData location);
}