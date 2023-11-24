import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:green_flux/core/color/color_palette.dart';

class StationListLoadingView extends StatelessWidget {
  const StationListLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: SpinKitRing(color: ColorPalette.primary),
      ),
    );
  }
}
