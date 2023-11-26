import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/constants/theme.dart';
import 'package:green_flux/core/router/router.dart';
import 'package:green_flux/presentation/shared_ui/info_banner.dart';

class GreenFluxApp extends ConsumerWidget {
  const GreenFluxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InfoBanner(
      child: MaterialApp.router(
        routerConfig: ref.read(routerProvider),
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.themeData,
      ),
    );
  }
}
