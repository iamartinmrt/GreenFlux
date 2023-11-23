import 'package:flutter/material.dart';
import 'package:green_flux/green_flux_app.dart';
import 'package:green_flux/handlers/env_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  EnvHandler.setUpAdditionalArgs();

  runApp(const GreenFluxApp());
}
