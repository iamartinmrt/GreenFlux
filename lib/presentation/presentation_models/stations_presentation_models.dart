import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_flux/core/constants/enums.dart';
import 'package:green_flux/core/network/network_response.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';

part 'stations_presentation_models.freezed.dart';

@freezed
class StationsList with _$StationsList {
  const factory StationsList.idle() = _idle;

  const factory StationsList.loading({required bool isLockUser}) = _loading;

  const factory StationsList.error({required String error}) = _error;

  const factory StationsList.data({
    required List<StationLocationQuickPreview> addresses,
  }) = _stationsList;
}

@freezed
class StationLocationQuickPreview with _$StationLocationQuickPreview {
  const factory StationLocationQuickPreview({
    required String address,
    required String city,
    required String? distance,
    required String totalEvses,
    required String availableEvses,
    required StationStatus status,
  }) = _stationLocationQuickPreview;
}

@freezed
class StationsListSearchResponse with _$StationsListSearchResponse {
  const factory StationsListSearchResponse({
    required NetworkResponse<List<DomainStations>> networkResponse,
    required String searchText,
  }) = _stationsListSearchResponse;
}

@freezed
class StationDetail with _$StationDetail{
  const factory StationDetail({
    required String address,
    required String location,
    required String? distance,
    required List<ConnectorTypeListing> connectorList,
    required double lat,
    required double lon,
}) = _stationDetail;
}

@freezed
class ConnectorTypeListing with _$ConnectorTypeListing {
  const factory ConnectorTypeListing({
    required String connectorType,
    required List<SpeedTypeListing> speedTypes,
  }) = _connectorTypeListing;
}

@freezed
class SpeedTypeListing with _$SpeedTypeListing {
  const factory SpeedTypeListing({
    required String speedType,
    required List<EvsesStatus> evsesStatuses,
  }) = _speedTypeListing;
}
