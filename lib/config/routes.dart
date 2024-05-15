import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_mobile/screens/home_page.dart';
import 'package:soigne_moi_mobile/screens/login/login.dart';
import 'package:soigne_moi_mobile/utils/screen_size.dart';

abstract class AppRoutes {
  static FutureOr<String?> loggedInRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Check connection
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'access_token');

    if (token != null) {
      return null; // Renvoie null si l'utilisateur est connecté mais aucune redirection n'est nécessaire
    } else {
      return '/login'; // Redirige vers la page de connexion si l'utilisateur n'est pas connecté
    }
  }

  static FutureOr<String?> loggedOutRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Check connection
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'access_token');
    if (token == null) return '/login';

    return null;
  }

  AppRoutes();

  static final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      redirect: loggedInRedirect,
    ),
    GoRoute(
        path: '/login',
        pageBuilder: (context, state) => defaultPageBuilder(
              context,
              state,
              const Login(),
            ),
        redirect: loggedInRedirect),
    GoRoute(
        path: '/home',
        pageBuilder: (context, state) => defaultPageBuilder(
              context,
              state,
              const HomePage(),
            ),
        redirect: loggedOutRedirect),
  ];

  static Page defaultPageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) =>
      ScreenSizeUtil.isSmallScreen(context)
          ? CustomTransitionPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              child: child,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            )
          : MaterialPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              child: child,
            );
}
