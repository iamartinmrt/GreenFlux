import 'package:green_flux/core/constants/enums.dart';
import 'package:green_flux/data/rest/data_models/stations_data_models.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';
import 'package:collection/collection.dart';

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
                  connectorType: EvsesConnectorType.findConnectorType(e.connectorType),
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
        distance: "12.6 km",
        totalEvses: totalEvses.toString(),
        status: availableEvses > (totalEvses / 2)
            ? StationStatus.available
            : StationStatus.charging,
        availableEvses: availableEvses.toString(),
      );
    }).toList();
  }

  static StationDetail convertDomainStationToStationDetail(
      DomainStations domainStations, String distance) {

    final connectorType = groupConnectorsBy(domainStations);

    return StationDetail(
      address: domainStations.address,
      location: "${domainStations.city}, ${domainStations.country}",
      distance: distance,
      lat: domainStations.lat,
      lon: domainStations.lon,
      connectorList: connectorType,
    );
  }

  /// Sorting connector based on their Connector type and power type
  /// Grouping items with same connector type in same map group and convert it
  /// to [List<ConnectorTypeListing>] to emit to UI
  static List<ConnectorTypeListing> groupConnectorsBy(
      DomainStations domainStations) {
    final Map<String, List<DomainEvses>> byConnectorType =
        groupBy(domainStations.evses, (e) => e.connectorType.displayName);

    List<ConnectorTypeListing> connectorType = [];

    byConnectorType.forEach((String key, List<DomainEvses> values) {
      List<SpeedTypeListing> speedTypes = [];
      groupBy(values, (e) => e.powerType)
          .forEach((EvsesPowerType key, List<DomainEvses> values) {
        List<EvsesStatus> evsesList = [];
        groupBy(values, (e) => e.status)
            .forEach((EvsesStatus key, List<DomainEvses> value) {
          evsesList.addAll(value.map((e) => e.status).toList());
        });
        speedTypes.add(SpeedTypeListing(
          speedType: key.displayName,
          evsesStatuses: evsesList,
        ));
      });
      connectorType.add(ConnectorTypeListing(
        connectorType: key,
        speedTypes: speedTypes,
      ));
    });

    return connectorType;
  }
}
