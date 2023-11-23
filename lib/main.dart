import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_flux/core/logger/gf_logger.dart';
import 'package:green_flux/green_flux_app.dart';
import 'package:green_flux/core/handlers/env_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  EnvHandler.setUpAdditionalArgs();

  runApp(const ProviderScope(child: GreenFluxApp()));
}
