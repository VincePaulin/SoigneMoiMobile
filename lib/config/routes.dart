import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soigne_moi_mobile/screens/home_page.dart';
import 'package:soigne_moi_mobile/utils/screen_size.dart';

abstract class AppRoutes {
  AppRoutes();

  static final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => defaultPageBuilder(
        context,
        state,
        HomePage(),
      ),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => defaultPageBuilder(
        context,
        state,
        HomePage(),
      ),
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
