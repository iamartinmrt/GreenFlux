import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/mapper/stations_mapping.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';
import 'package:green_flux/domain/repositories/stations_repository.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

final stateStationsProvider = StateNotifierProvider<StationsStateNotifier, StationsList>((ref) {
  return StationsStateNotifier(ref.watch(stationsRepositoryProvider));
});

class StationsStateNotifier extends StateNotifier<StationsList>{
  final StationsRepository _repository;
  final int _searchGapTime = 500;
  Timer? _timer;
  String _previousSearch = "";

  StationsStateNotifier(this._repository) : super(const StationsList.idle());

  /// This function will be called everytime user type a new digit
  /// Therefore we need to capture the lastest [search] text and compare to
  /// search text of the responses of the API call to make sure we emit the
  /// latest search result only by [response.searchText == _previousSearch]
  void onSearch(String search) async {
    _previousSearch = search;
    if(search.isEmpty){
      state = const StationsList.idle();
      return;
    }
    state = const StationsList.loading();

    final response = await _repository.getStationsList(search);

    if(response.searchText == _previousSearch){
      response.networkResponse.whenOrNull(
          success: (List<DomainStations> listStations) {
            state = StationsList.data(addresses: StationsMapping.convertDomainStationsToStationPreview(listStations));
          },
          error: (error){
            state = StationsList.error(error: error.message);
          }
      );
    }
  }

  /// If user stop typing for [_searchGapTime], then we start making API call
  /// And update the list with the data that they have searched for
  onNewTextSearched(String newSearch){
    if(_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: _searchGapTime), () => onSearch(newSearch));
  }

}
