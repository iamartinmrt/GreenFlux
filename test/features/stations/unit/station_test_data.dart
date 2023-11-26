part of 'stations_unit_test.dart';


Position get _testPosition =>
    Position(
      longitude: 1.1,
      latitude: 1.1,
      timestamp: DateTime.now(),
      accuracy: 1.1,
      altitude: 1.1,
      altitudeAccuracy: 1.1,
      heading: 1.1,
      headingAccuracy: 1.1,
      speed: 1.1,
      speedAccuracy: 1.1,
    );

StationsListSearchResponse _testDomainStationsEmptyResponse(search) =>
    StationsListSearchResponse(
      networkResponse: const NetworkResponse.success([]),
      searchText: search,
    );

StationsListSearchResponse _testDomainStationsErrorResponse(search) =>
    StationsListSearchResponse(
      networkResponse: const NetworkResponse.error(ErrorResponse()),
      searchText: search,
    );

StationsListSearchResponse _testDomainStationsSuccessResponse(search) =>
    StationsListSearchResponse(
      networkResponse: const NetworkResponse.success([
        DomainStations(
            address: "",
            city: "",
            country: "",
            lat: 1.1,
            lon: 1.1,
            evses: []
        ),
      ]),
      searchText: search,
    );

StationsListSearchResponse _testDomainStationsMismatchResponse(search) =>
    StationsListSearchResponse(
      networkResponse: const NetworkResponse.success([]),
      searchText: "$search - mismatch",
    );

List<ResponseGetStations> _createApiLayerStationObject() {
  final stationListJson = _readFromFileToJson("station_list.json");
  final List<ResponseGetStations> stationList =
  stationListJson.map((i) => ResponseGetStations.fromJson(i)).cast<ResponseGetStations>().toList();
  return stationList;
}

dynamic _readFromFileToJson(String file) {
  final fileText = File("test/assets/json/$file").readAsStringSync();
  final fileJson = json.decode(fileText);
  return fileJson;
}
