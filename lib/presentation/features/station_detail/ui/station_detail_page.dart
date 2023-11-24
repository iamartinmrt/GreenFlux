import 'package:flutter/material.dart';
import 'package:green_flux/core/constants/assets.dart';
import 'package:green_flux/core/constants/text_styles.dart';

class StationDetailPage extends StatelessWidget {
  final String address;
  const StationDetailPage(this.address, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: "$address-i",
              child: Image.asset(Assets.chargingStatus, width: 50, height: 50),
            ),
            Hero(
              tag: "$address-t",
              child: Text(address,style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
      ),
    );
  }
}
