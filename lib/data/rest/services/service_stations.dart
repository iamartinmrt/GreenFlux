import 'package:dio/dio.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/data/rest/data_models/stations_data_models.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/dio.dart';

part 'service_stations.g.dart';

@RestApi()
abstract class StationsService implements FacadeStationsService {
  factory StationsService(Dio dio, {String baseUrl}) = _StationsService;

  @override
  @GET('/locations?q={search}')
  @Extra({Constants.customTimeOut: 10000})
  Future<ResponseGetStations> getStationsList(
    @CancelRequest() CancelToken cancelToken,
    @Path("search") String search,
  );
}

abstract class FacadeStationsService {
  Future<ResponseGetStations> getStationsList(
    CancelToken cancelToken,
    String search,
  );
}
