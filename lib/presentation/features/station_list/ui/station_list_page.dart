import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/presentation/features/station_list/logic/state_stations_provider.dart';

class StationListPage extends ConsumerWidget {
  const StationListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(stateStationsProvider).when(
            idle: () => const SizedBox(),
            loading: () => const Text("Loading..."),
            error: (error) => Text(error),
            data: (address) => Text(address.join("///// ")),
          ),
    );
  }
}
