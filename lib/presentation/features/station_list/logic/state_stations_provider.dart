import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/core/handlers/url_handler.dart';
import 'package:green_flux/core/mapper/stations_mapping.dart';
import 'package:green_flux/core/router/router.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';
import 'package:green_flux/domain/repositories/stations_repository.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';
import 'package:collection/collection.dart';

final stateStationsProvider = StateNotifierProvider<StationsStateNotifier, StationsList>((ref) {
  return StationsStateNotifier(ref, ref.watch(stationsRepositoryProvider));
});

class StationsStateNotifier extends StateNotifier<StationsList>{
  final StationsRepository _repository;
  final int _searchGapTime = 500;
  Timer? _timer;
  String _previousSearch = "";
  final Ref ref;
  List<DomainStations> _fetchedStations = [];

  StationsStateNotifier(this.ref, this._repository) : super(const StationsList.idle());

  /// This function will be called everytime user type a new digit
  /// Therefore we need to capture the lastest [search] text and compare to
  /// search text of the responses of the API call to make sure we emit the
  /// latest search result only by [response.searchText == _previousSearch]
  void onSearch(String search) async {
    _previousSearch = search;
    if(search.isEmpty){
      _fetchedStations = [];
      state = const StationsList.idle();
      return;
    }
    state = const StationsList.loading();

    final response = await _repository.getStationsList(search);

    if(response.searchText == _previousSearch){
      response.networkResponse.whenOrNull(
          success: (List<DomainStations> listStations) {
            _fetchedStations = listStations;
            state = StationsList.data(addresses: StationsMapping.convertDomainStationsToStationPreview(listStations));
          },
          error: (error){
            _fetchedStations = [];
            state = StationsList.error(error: error.message);
          }
      );
    }
  }

  openMapForRouting(double lat, double long){
    UrlHandler.instance.openMap(lat.toString(), long.toString());
  }

  onStationTap(String selectedAddress){
    final DomainStations? domainStation = _fetchedStations.firstWhereOrNull((e) => (e.address == selectedAddress));
    if(domainStation != null){

      final StationDetail stationDetail = StationsMapping.convertDomainStationToStationDetail(domainStation, "TODO km");

      ref.read(routerProvider).push("${Constants.routeStationList}/${Constants.routeStationDetail}", extra: stationDetail);
    }
  }

  /// If user stop typing for [_searchGapTime], then we start making API call
  /// And update the list with the data that they have searched for
  onNewTextSearched(String newSearch){
    if(_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: _searchGapTime), () => onSearch(newSearch));
  }

}
