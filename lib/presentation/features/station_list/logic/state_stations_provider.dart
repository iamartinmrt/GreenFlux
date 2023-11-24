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
  final int _searchGapTime = 1;
  Timer? _timer;

  StationsStateNotifier(this._repository) : super(const StationsList.idle());

  void onSearch(String search) async {
    state = const StationsList.loading();
    await Future.delayed(const Duration(seconds: 5));
    final response = await _repository.getStationsList(search);
    response.when(
      success: (List<DomainStations> list) {
        state = StationsList.data(addresses: StationsMapping.convertDomainStationsToStationPreview(list));
      },
      error: (error){
        state = StationsList.error(error: error);
      }
    );
  }

  /// If user stop typing for [_searchGapTime], then we start making API call
  /// And update the list with the data that they have searched for
  onNewTextSearched(String newSearch){
    if(_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(seconds: _searchGapTime), () => onSearch(newSearch));
  }

}
