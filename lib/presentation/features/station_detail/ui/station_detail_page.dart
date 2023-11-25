import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/color/color_palette.dart';
import 'package:green_flux/core/constants/assets.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:green_flux/core/router/router.dart';
import 'package:green_flux/presentation/features/station_detail/ui/station_detail_connectors_view.dart';
import 'package:green_flux/presentation/features/station_list/logic/state_stations_provider.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';
import 'package:green_flux/presentation/shared_ui/primary_button.dart';
import 'package:green_flux/presentation/shared_ui/secondary_button.dart';

class StationDetailPage extends ConsumerWidget {
  final StationDetail stationDetail;

  StationDetailPage(this.stationDetail, {super.key});

  final MovieTween _buttonAnimation = MovieTween()
    ..scene(begin: const Duration(milliseconds: 0), end: const Duration(milliseconds: 300)).tween("dy", Tween(begin: 250.0, end: -50.0))
    ..scene(begin: const Duration(milliseconds: 300), end: const Duration(milliseconds: 400)).tween("dy", Tween(begin: -50.0, end: 0.0));

  final Tween<double> _connectorsAnimation = Tween<double>(begin: 0.0, end: 1.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.circular(Constants.cardBorderRadius),
                    border: Border.all(color: ColorPalette.gray200, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: "${stationDetail.address}-address",
                          child: Text(stationDetail.address, style: Theme.of(context).textTheme.titleLarge),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Hero(
                                tag: "${stationDetail.address}-location",
                                child: Text(stationDetail.location, style: Theme.of(context).textTheme.bodyMedium),
                              ),
                              Visibility(
                                visible: (stationDetail.distance != null),
                                child: Hero(
                                  tag: "${stationDetail.address}-distance",
                                  child: Text(" - ${stationDetail.distance}", style: Theme.of(context).textTheme.bodyMedium),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TweenAnimationBuilder<double>(
                  tween: _connectorsAnimation,
                  duration: const Duration(milliseconds: 500),
                  builder: (context, double value, child){
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                  child: StationDetailConnectorsView(stationDetail.connectorList),
                ),
              ),
              PlayAnimationBuilder(
                tween: _buttonAnimation,
                duration: _buttonAnimation.duration,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, value.get("dy")),
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    PrimaryButton(
                      icon: Assets.routing,
                      text: Constants.textRoute,
                      onTap: () => ref.read(stateStationsProvider.notifier).openMapForRouting(stationDetail.lat, stationDetail.lon),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SecondaryButton(
                        text: Constants.textBack,
                        onTap: () => ref.read(routerProvider).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
