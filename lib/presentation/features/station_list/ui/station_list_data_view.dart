import 'package:flutter/material.dart';
import 'package:green_flux/core/color/color_palette.dart';
import 'package:green_flux/core/constants/assets.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/core/constants/enums.dart';
import 'package:green_flux/core/constants/text_styles.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

class StationListDataView extends StatelessWidget {
  final List<StationLocationQuickPreview> stations;

  const StationListDataView(this.stations, {super.key});

  @override
  Widget build(BuildContext context) {
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

class _StationItemPreview extends StatelessWidget {
  final StationLocationQuickPreview station;

  const _StationItemPreview(this.station, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: (station.status == StationStatus.available),
                replacement: Image.asset(Assets.chargingStatus, width: 35, height: 35),
                child: Image.asset(Assets.availableStatus, width: 35, height: 35),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(station.address,
                          style: TextStyles.title1,
                          overflow: TextOverflow.ellipsis),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(station.city,
                            style: TextStyles.body2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Visibility(
                          visible: station.totalEvses.isNotEmpty,
                          child: Text(
                              "${station.availableEvses} / ${station.totalEvses} available",
                              style: TextStyles.body1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
