import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/mapper/stations_mapping.dart';
import 'package:green_flux/core/network/error_response.dart';
import 'package:green_flux/core/network/network_response.dart';
import 'package:green_flux/data/rest/service_provider/service_providers.dart';
import 'package:green_flux/data/rest/services/service_stations.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

final stationsRepositoryProvider = Provider<StationsRepository>((ref) => StationsRepository(ref.watch(serviceStationsProvider)));

class StationsRepository {
  final FacadeStationsService _stationsService;
  CancelToken _cancelToken = CancelToken();

  StationsRepository(this._stationsService);

  Future<StationsListSearchResponse> getStationsList(String search) async {
    try {
      _cancelToken.cancel();
      _cancelToken = CancelToken();
      final response = await _stationsService.getStationsList(_cancelToken, search);
      return StationsListSearchResponse(
        networkResponse: NetworkResponse.success(StationsMapping.convertDataStationsToDomainStations(response)),
        searchText: search,
      );
    } on DioException catch (error) {
      if (error.type == DioExceptionType.cancel) {
        return StationsListSearchResponse(
          searchText: search,
          networkResponse: const NetworkResponse.canceled(),
        );
      }
      return StationsListSearchResponse(
        searchText: search,
        networkResponse: NetworkResponse.error(ErrorResponse.fromDio(error)),
      );
    }
  }
}
