import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/domain/domain_models/domain_stations.dart';
import 'package:green_flux/domain/repositories/stations_repository.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

final stateStationsProvider = StateNotifierProvider<StationsStateNotifier, StationsList>((ref) {
  return StationsStateNotifier(ref.watch(stationsRepositoryProvider));
});

class StationsStateNotifier extends StateNotifier<StationsList>{
  final StationsRepository _repository;

  StationsStateNotifier(this._repository) : super(const StationsList.idle()){
    onSearch("Amsterdam");
  }

  void onSearch(String search) async {
    state = const StationsList.loading();
    final response = await _repository.getStationsList(search);
    response.when(
      success: (List<DomainStations> list) {
        state = StationsList.data(addresses: list.map((e) => e.address).toList());
      },
      error: (error){
        state = StationsList.error(error: error);
      }
    );
  }

}
