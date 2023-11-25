import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:green_flux/core/color/color_palette.dart';
import 'package:green_flux/core/constants/constants.dart';

class StationListLoadingView extends StatelessWidget {
  final bool isLockUser;

  const StationListLoadingView(this.isLockUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitRing(color: ColorPalette.primary),
            Visibility(
              visible: isLockUser,
              child: const Padding(
                padding: EdgeInsets.only(top: 8),
                child:  Text(Constants.textTryingFetchUserLocation),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
