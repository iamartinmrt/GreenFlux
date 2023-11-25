import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/presentation/features/station_list/logic/state_stations_provider.dart';
import 'package:green_flux/presentation/features/station_list/ui/station_list_data_view.dart';
import 'package:green_flux/presentation/features/station_list/ui/station_list_error_view.dart';
import 'package:green_flux/presentation/features/station_list/ui/station_list_idle_view.dart';
import 'package:green_flux/presentation/features/station_list/ui/station_list_loading_view.dart';
import 'package:green_flux/presentation/features/station_list/ui/station_list_search_bar.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

class StationListPage extends ConsumerWidget {
  const StationListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const StationListSearchBar(),
          ref.watch(stateStationsProvider).when(
                idle: () => const StationListIdleView(),
                loading: () => const StationListLoadingView(),
                error: (error) => StationListErrorView(error),
                data: (List<StationLocationQuickPreview> previews) => StationListDataView(previews),
              ),
        ],
      ),
    );
  }
}
