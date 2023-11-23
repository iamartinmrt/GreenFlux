import 'package:json_annotation/json_annotation.dart';

part 'stations_data_models.g.dart';

@JsonSerializable()
class ResponseGetStations {
  @JsonKey(name: "address")
  final String address;

  @JsonKey(name: "city")
  final String city;

  @JsonKey(name: "country")
  final String country;

  @JsonKey(name: "latitude")
  final double lat;

  @JsonKey(name: "longitude")
  final double lon;

  @JsonKey(name: "evses")
  final List<ResponseEvses> evses;

  ResponseGetStations({
    required this.address,
    required this.city,
    required this.country,
    required this.lat,
    required this.lon,
    required this.evses,
  });

  factory ResponseGetStations.fromJson(Map<String, dynamic> json) => _$ResponseGetStationsFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGetStationsToJson(this);
}

@JsonSerializable()
class ResponseEvses {
  @JsonKey(name: "evseId")
  final String evseId;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "connectorType")
  final String connectorType;

  @JsonKey(name: "powerType")
  final String powerType;

  ResponseEvses({
    required this.evseId,
    required this.status,
    required this.connectorType,
    required this.powerType,
  });

  factory ResponseEvses.fromJson(Map<String, dynamic> json) => _$ResponseEvsesFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseEvsesToJson(this);
}
