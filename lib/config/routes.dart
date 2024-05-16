import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';
import 'package:soigne_moi_mobile/screens/login/login.dart';
import 'package:soigne_moi_mobile/screens/review/review_view.dart';
import 'package:soigne_moi_mobile/utils/screen_size.dart';

abstract class AppRoutes {
  static FutureOr<String?> wrapper(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Check connection
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'access_token');

    if (token != null) {
      return '/home'; // Returns home if the user is logged in but no redirection is required
    } else {
      return '/login'; //  Redirects to login page if user is not logged in
    }
  }

  AppRoutes();

  static final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      redirect: wrapper,
    ),
    GoRoute(
        path: '/login',
        pageBuilder: (context, state) => defaultPageBuilder(
              context,
              state,
              const Login(),
            ),
        redirect: wrapper),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => defaultPageBuilder(
        context,
        state,
        const Home(),
      ),
      redirect: wrapper,
    ),
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
