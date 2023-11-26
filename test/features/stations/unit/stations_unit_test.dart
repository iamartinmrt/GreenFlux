import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_flux/core/network/error_response.dart';
import 'package:green_flux/core/network/network_response.dart';
import 'package:green_flux/data/rest/data_models/stations_data_models.dart';
import 'package:green_flux/data/rest/service_provider/service_providers.dart';
import 'package:green_flux/data/rest/services/location_service.dart';
import 'package:green_flux/data/rest/services/service_stations.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';
import 'package:green_flux/domain/repositories/stations_repository.dart';
import 'package:green_flux/presentation/features/station_list/logic/state_stations_provider.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stations_unit_test.mocks.dart';

part 'station_test_data.dart';
part 'stations_custom_matchers.dart';

@GenerateMocks([FacadeStationsService, FacadeStationsRepository, FacadeLocationService])
void main() {
  settingUpLocationProviderMock(ProviderContainer container){
    when((container.read(stateLocationService) as MockFacadeLocationService).isLocationServiceEnabled())
        .thenAnswer((realInvocation) async => true);
    when((container.read(stateLocationService) as MockFacadeLocationService).checkPermission())
        .thenAnswer((realInvocation) async => LocationPermission.always);
    when((container.read(stateLocationService) as MockFacadeLocationService).requestPermission())
        .thenAnswer((realInvocation) async => LocationPermission.always);
    when((container.read(stateLocationService) as MockFacadeLocationService).getCurrentPosition())
        .thenAnswer((realInvocation) async => _testPosition);
    when((container.read(stateLocationService) as MockFacadeLocationService).getCityNameByCoordinates(any))
        .thenAnswer((realInvocation) async => "");
  }

  group("Happy path testing Data/Domain layer", () {
    test("Converting Json to data layer object", () {
      final stationList = _createApiLayerStationObject();
      expect(stationList, isNotEmpty);
    });

    final container = ProviderContainer(
      overrides: [
        serviceStationsProvider.overrideWith((ref) => MockFacadeStationsService()),
        stateLocationService.overrideWith((ref) => MockFacadeLocationService()),
      ],
    );

    setUpAll(() async {
      when((container.read(serviceStationsProvider) as MockFacadeStationsService).getApiStationsList(any, any))
          .thenAnswer((realInvocation) => Future.value(_createApiLayerStationObject()));
      settingUpLocationProviderMock(container);
    });

    test("Prepare domain station objects to emit", () async {
      expect(await container.read(stationsRepositoryProvider).getStationsList("Amsterdam"), isDomainStationsResponse);
    });
  });

  group("Happy path testing Data/Domain layer", () {
    const String emptyListResponse = "Empty list";
    const String successResponse = "Success response";
    const String errorResponse = "Error response";
    const String mismatchResponse = "Mismatch response";

    final container = ProviderContainer(
      overrides: [
        serviceStationsProvider.overrideWith((ref) => MockFacadeStationsService()),
        stateLocationService.overrideWith((ref) => MockFacadeLocationService()),
        stationsRepositoryProvider.overrideWith((ref) => MockFacadeStationsRepository()),
      ],
    );

    setUpAll(() async {
      settingUpLocationProviderMock(container);
      when((container.read(stationsRepositoryProvider) as MockFacadeStationsRepository).getStationsList(emptyListResponse))
          .thenAnswer((realInvocation) async => _testDomainStationsEmptyResponse(emptyListResponse));
      when((container.read(stationsRepositoryProvider) as MockFacadeStationsRepository).getStationsList(successResponse))
          .thenAnswer((realInvocation) async => _testDomainStationsSuccessResponse(successResponse));
      when((container.read(stationsRepositoryProvider) as MockFacadeStationsRepository).getStationsList(errorResponse))
          .thenAnswer((realInvocation) async => _testDomainStationsErrorResponse(errorResponse));
      when((container.read(stationsRepositoryProvider) as MockFacadeStationsRepository).getStationsList(mismatchResponse))
          .thenAnswer((realInvocation) async => _testDomainStationsMismatchResponse(mismatchResponse));
      container.read(stateStationsProvider);
      await Future.delayed(Duration.zero);
    });

    test("If no search text, don't fetch stations", () async {
      expect(container.read(stateStationsProvider), const StationsList.idle());
      container.read(stateStationsProvider.notifier).onSearch("", true);
      expect(container.read(stateStationsProvider), const StationsList.idle());
    });

    test("Receiving empty list stations on app initials", () async {
      expect(container.read(stateStationsProvider), const StationsList.idle());
      container.read(stateStationsProvider.notifier).onSearch(emptyListResponse, true);
      expect(container.read(stateStationsProvider), const StationsList.loading(isLockUser: true));
      await Future.delayed(Duration.zero);
      expect(container.read(stateStationsProvider), const StationsList.idle());
    });

    test("Receiving empty list stations on user search", () async {
      container.read(stateStationsProvider.notifier).onSearch(emptyListResponse, false);
      expect(container.read(stateStationsProvider), const StationsList.loading(isLockUser: false));
      await Future.delayed(Duration.zero);
      expect(container.read(stateStationsProvider), const StationsList.data(stations: []));
    });

    test("Receiving error response on user search", () async {
      container.read(stateStationsProvider.notifier).onSearch(errorResponse, false);
      expect(container.read(stateStationsProvider), const StationsList.loading(isLockUser: false));
      await Future.delayed(Duration.zero);
      expect(container.read(stateStationsProvider), _hasErrorState(isA<String>()));
    });

    test("Receiving success response on user search", () async {
      container.read(stateStationsProvider.notifier).onSearch(successResponse, false);
      expect(container.read(stateStationsProvider), const StationsList.loading(isLockUser: false));
      await Future.delayed(Duration.zero);
      expect(container.read(stateStationsProvider), _hasDataState(isNotEmpty));
    });

    test("Receiving mismatch response on user search", () async {
      container.read(stateStationsProvider.notifier).onSearch(mismatchResponse, false);
      expect(container.read(stateStationsProvider), const StationsList.loading(isLockUser: false));
      await Future.delayed(Duration.zero);
      expect(container.read(stateStationsProvider), const StationsList.loading(isLockUser: false));
    });
  });
}




