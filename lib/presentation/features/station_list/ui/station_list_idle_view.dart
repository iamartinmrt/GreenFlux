import 'package:flutter/material.dart';
import 'package:green_flux/core/constants/assets.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/core/constants/text_styles.dart';

class StationListIdleView extends StatelessWidget {
  const StationListIdleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.typingIcon, width: 70, height: 70),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(Constants.textTypingSomething, style: TextStyles.header1),
            ),
          ],
        ),
      ),
    );
  }
}
