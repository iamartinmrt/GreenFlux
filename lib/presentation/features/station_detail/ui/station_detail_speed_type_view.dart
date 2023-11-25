import 'package:flutter/material.dart';
import 'package:green_flux/core/color/color_palette.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/core/constants/enums.dart';
import 'package:green_flux/core/constants/text_styles.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

class StationDetailSpeedTypeView extends StatelessWidget {
  final List<SpeedTypeListing> speedTypes;

  const StationDetailSpeedTypeView(this.speedTypes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...speedTypes.map((e) {
            return Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      e.speedType,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.body1,
                    ),
                  ),
                  Text(
                    _getAvailabilityCount(e.evsesStatuses),
                    textAlign: TextAlign.center,
                    style: TextStyles.body1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      _getAvailabilityText(e.evsesStatuses),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.body1.copyWith(color: _getAvailabilityColor(e.evsesStatuses)),
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  String _getAvailabilityCount(List<EvsesStatus> evsesList) {
    final int available = evsesList.where((e) => e == EvsesStatus.available).length;
    return "$available / ${evsesList.length}";
  }

  String _getAvailabilityText(List<EvsesStatus> evsesList) =>
      evsesList.any((element) => element == EvsesStatus.available) ? Constants.textAvailableEvses : Constants.textUnavailableEvses;

  Color _getAvailabilityColor(List<EvsesStatus> evsesList) =>
      evsesList.any((element) => element == EvsesStatus.available) ? ColorPalette.primary : ColorPalette.errorRed;
}
