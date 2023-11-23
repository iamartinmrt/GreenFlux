import 'package:green_flux/data/rest/data_models/stations_data_models.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';

class StationsMapping {
  static DomainStations convertDataStationsToDomainStations(
      ResponseGetStations apiStations) {
    return DomainStations(
      address: apiStations.address,
      city: apiStations.city,
      country: apiStations.country,
      lat: apiStations.lat,
      lon: apiStations.lon,
      evses: apiStations.evses
          .map((e) => DomainEvses(
                evseId: e.evseId,
                status: e.status,
                connectorType: e.connectorType,
                powerType: e.powerType,
              ))
          .toList(),
    );
  }
}
