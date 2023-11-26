import 'package:flutter/material.dart';
import 'package:green_flux/core/color/color_palette.dart';
import 'package:green_flux/core/handlers/env_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoBanner extends StatefulWidget {
  final Widget child;

  const InfoBanner({required this.child, super.key});

  @override
  State<InfoBanner> createState() => _InfoBannerState();
}

class _InfoBannerState extends State<InfoBanner> {
  late Future<PackageInfo> _future;

  @override
  void initState() {
    _future = PackageInfo.fromPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (EnvHandler.instance.isProdEnv) {
      return widget.child;
    }
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Banner(
              color: Colors.yellow,
              message: "build ${snapshot.data!.buildNumber}",
              location: BannerLocation.bottomEnd,
              textStyle: const TextStyle(
                color: ColorPalette.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w900,
                height: 1.0,
              ),
              child: widget.child,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
