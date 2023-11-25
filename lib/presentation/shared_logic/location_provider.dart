import 'package:geolocator/geolocator.dart';
import 'package:green_flux/presentation/presentation_models/location_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.g.dart';

@Riverpod(keepAlive: true)
class StateLocation extends _$StateLocation {
  @override
  FutureOr<LocationState> build() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return const LocationState.denied();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const LocationState.denied();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return const LocationState.denied();
    }
    final Position position = await Geolocator.getCurrentPosition();
    return LocationState.granted(
      latLong: LatLonData(lat: position.latitude, lon: position.longitude),
    );
  }
}
