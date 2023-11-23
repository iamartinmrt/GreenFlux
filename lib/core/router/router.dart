import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_flux/presentation/features/station_list/ui/station_list_page.dart';
import 'package:riverpod/riverpod.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: "/station_list",
        pageBuilder: (context, state) => const MaterialPage(
          child: StationListPage(),
        ),
      ),
    ],
    initialLocation: "/station_list",
  ),
);
