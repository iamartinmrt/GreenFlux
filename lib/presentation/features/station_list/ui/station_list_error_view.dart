import 'package:flutter/material.dart';
import 'package:green_flux/core/constants/assets.dart';
import 'package:green_flux/core/constants/text_styles.dart';

class StationListErrorView extends StatelessWidget {
  final String errorText;
  const StationListErrorView(this.errorText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.errorIcon, width: 70, height: 70),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(errorText, style: TextStyles.header1),
            ),
          ],
        ),
      ),
    );
  }
}
