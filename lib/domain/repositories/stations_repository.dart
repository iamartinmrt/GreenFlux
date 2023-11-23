import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/mapper/stations_mapping.dart';
import 'package:green_flux/core/network/network_response.dart';
import 'package:green_flux/data/rest/service_provider/service_providers.dart';
import 'package:green_flux/data/rest/services/service_stations.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';
import 'package:dio/dio.dart';

final stationsRepositoryProvider = Provider<StationsRepository>(
    (ref) => StationsRepository(ref.watch(serviceStationsProvider)));

class StationsRepository {
  final FacadeStationsService _stationsService;
  CancelToken _cancelToken = CancelToken();

  StationsRepository(this._stationsService);

  Future<NetworkResponse<List<DomainStations>>> getStationsList(String search) async {
    try{
      _cancelToken.cancel();
      _cancelToken = CancelToken();
      final response = await _stationsService.getStationsList(_cancelToken, search);
      return NetworkResponse.success(StationsMapping.convertDataStationsToDomainStations(response));
    }catch(error){
      return NetworkResponse.error(error.toString());
    }
  }
}
