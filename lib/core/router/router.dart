import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_flux/core/constants/constants.dart';
import 'package:green_flux/presentation/features/station_detail/ui/station_detail_page.dart';
import 'package:green_flux/presentation/features/station_list/ui/station_list_page.dart';
import 'package:green_flux/presentation/presentation_models/stations_presentation_models.dart';
import 'package:riverpod/riverpod.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

final routerProvider = Provider(
  (ref) => GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _key,
        builder: (context, state, child) {
          return HeroControllerScope(
            controller: MaterialApp.createMaterialHeroController(),
            child: Scaffold(body: child),
          );
        },
        routes: [
          GoRoute(
              path: Constants.routeStationList,
              pageBuilder: (context, state) => const MaterialPage(
                    child: StationListPage(),
                  ),
              routes: [
                GoRoute(
                  path: Constants.routeStationDetail,
                  parentNavigatorKey: _rootNavigatorKey,
                  pageBuilder: (context, state) => CustomTransitionPage<void>(
                    transitionDuration: const Duration(milliseconds: 300),
                    key: state.pageKey,
                    child: StationDetailPage(state.extra as StationDetail),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
                  ),
                ),
              ]),
        ],
      )
    ],
    initialLocation: Constants.routeStationList,
  ),
);
