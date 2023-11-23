import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/router/router.dart';

class GreenFluxApp extends ConsumerWidget {
  const GreenFluxApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.read(routerProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
