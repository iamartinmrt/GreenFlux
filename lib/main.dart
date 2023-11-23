import 'package:flutter/material.dart';
import 'package:green_flux/green_flux_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Flux Demo',
      home: GreenFluxApp(),
    );
  }
}
