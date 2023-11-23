import 'package:freezed_annotation/freezed_annotation.dart';

part 'stations_presentation_models.freezed.dart';

@freezed
class StationsList with _$StationsList{
  const factory StationsList.idle() = _idle;

  const factory StationsList.loading() = _loading;

  const factory StationsList.error({required String error}) = _error;

  const factory StationsList.data({
    required List<String> addresses,
  }) = _stationsList;
}
