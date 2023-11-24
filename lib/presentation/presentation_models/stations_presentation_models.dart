import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_flux/core/constants/enums.dart';

part 'stations_presentation_models.freezed.dart';

@freezed
class StationsList with _$StationsList{
  const factory StationsList.idle() = _idle;

  const factory StationsList.loading() = _loading;

  const factory StationsList.error({required String error}) = _error;

  const factory StationsList.data({
    required List<StationLocationQuickPreview> addresses,
  }) = _stationsList;
}

@freezed
class StationLocationQuickPreview with _$StationLocationQuickPreview{
  const factory StationLocationQuickPreview({
    required String address,
    required String city,
    required String totalEvses,
    required String availableEvses,
    required StationStatus status,
  }) = _stationLocationQuickPreview;
}
