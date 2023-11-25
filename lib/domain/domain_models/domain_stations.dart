import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_flux/core/constants/enums.dart';

part 'domain_stations.freezed.dart';

@freezed
class DomainStations with _$DomainStations {
  const factory DomainStations({
    required String address,
    required String city,
    required String country,
    required double lat,
    required double lon,
    required List<DomainEvses> evses,
  }) = _domainStations;
}

@freezed
class DomainEvses with _$DomainEvses {
  const factory DomainEvses({
    required String evseId,
    required EvsesStatus status,
    required EvsesConnectorType connectorType,
    required EvsesPowerType powerType,
  }) = _domainEvses;
}
