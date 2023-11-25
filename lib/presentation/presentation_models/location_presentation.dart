import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_presentation.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.denied() = _locationStateDenied;

  const factory LocationState.granted({
    required LatLonData latLong,
  }) = _locationStateGranted;
}

class LatLonData {
  final double lat;
  final double lon;

  const LatLonData({required this.lat, required this.lon});
}
