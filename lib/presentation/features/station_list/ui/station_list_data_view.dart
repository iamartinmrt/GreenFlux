import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/color/color_palette.dart';
import 'package:green_flux/core/constants/assets.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/core/constants/enums.dart';
import 'package:green_flux/core/constants/text_styles.dart';
import 'package:green_flux/presentation/features/station_list/logic/state_stations_provider.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

class StationListDataView extends StatelessWidget {
  final List<StationLocationQuickPreview> stations;

  const StationListDataView(this.stations, {super.key});

  @override
  Widget build(BuildContext context) {
    if (stations.isEmpty) {
      return const _StationListEmpty();
    } else {
      return Flexible(
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: stations.length,
          itemBuilder: (context, index) {
            return _StationItemPreview(stations[index]);
          },
        ),
      );
    }
  }
}

class _StationListEmpty extends StatelessWidget {
  const _StationListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.noResultIcon, width: 70, height: 70),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(Constants.textNoStationResult,
                  style: TextStyles.header1),
            ),
          ],
        ),
      ),
    );
  }
}

class _StationItemPreview extends ConsumerWidget {
  final StationLocationQuickPreview station;

  const _StationItemPreview(this.station, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref
          .read(stateStationsProvider.notifier)
          .onStationTap(station.address),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: ColorPalette.white,
            borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: (station.status == StationStatus.available),
                      replacement: Image.asset(Assets.chargingStatus,
                          width: 35, height: 35),
                      child: Image.asset(Assets.availableStatus,
                          width: 35, height: 35),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Hero(
                        tag: "${station.address}-distance",
                        child: Text(station.distance ?? "",
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: "${station.address}-address",
                          child: Text(station.address,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Hero(
                          tag: "${station.address}-location",
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(station.city,
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Visibility(
                            visible: station.totalEvses.isNotEmpty,
                            child: Text(
                                "${station.availableEvses} / ${station.totalEvses} ${Constants.textAvailable}",
                                style: TextStyles.body1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset(Assets.rightArrow, width: 12, height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
