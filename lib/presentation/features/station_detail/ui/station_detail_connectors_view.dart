import 'package:flutter/material.dart';
import 'package:green_flux/core/constants/text_styles.dart';
import 'package:green_flux/presentation/features/station_detail/ui/station_detail_speed_type_view.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';

class StationDetailConnectorsView extends StatelessWidget {
  final List<ConnectorTypeListing> connectors;

  const StationDetailConnectorsView(this.connectors, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: ListView(
          children: [
            ...connectors.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(e.connectorType, style: TextStyles.title1),
                  ),
                  StationDetailSpeedTypeView(e.speedTypes),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
