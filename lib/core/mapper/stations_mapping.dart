import 'package:green_flux/core/constants/enums.dart';
import 'package:green_flux/data/rest/data_models/stations_data_models.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

class StationsMapping {
  static List<DomainStations> convertDataStationsToDomainStations(
      List<ResponseGetStations> apiStationsList) {
    return apiStationsList.map((apiStations) {
      return DomainStations(
        address: apiStations.address,
        city: apiStations.city,
        country: apiStations.country,
        lat: apiStations.lat,
        lon: apiStations.lon,
        evses: apiStations.evses
            .map((e) => DomainEvses(
                  evseId: e.evseId,
                  status: EvsesStatus.findStatus(e.status),
                  connectorType: e.connectorType,
                  powerType: EvsesPowerType.findPowerType(e.powerType),
                ))
            .toList(),
      );
    }).toList();
  }

  static List<StationLocationQuickPreview>
      convertDomainStationsToStationPreview(List<DomainStations> domainList) {
    return domainList.map((e) {
      final int totalEvses = e.evses.length;
      final int availableEvses =
          e.evses.where((e) => e.status == EvsesStatus.available).length;
      return StationLocationQuickPreview(
        address: e.address,
        city: e.city,
        totalEvses: totalEvses.toString(),
        status: availableEvses > (totalEvses / 2)
            ? StationStatus.available
            : StationStatus.charging,
        availableEvses: availableEvses.toString(),
      );
    }).toList();
  }
}
