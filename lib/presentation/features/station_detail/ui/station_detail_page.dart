import 'package:flutter/material.dart';
import 'package:green_flux/core/constants/assets.dart';

class StationDetailPage extends StatelessWidget {
  final String address;
  const StationDetailPage(this.address, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: address,
          child: Image.asset(Assets.chargingStatus, width: 50, height: 50),
        ),
      ),
    );
  }
}
