import 'package:fitt_app/infrastructure/routes/top_level_redirect_handler.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fitt_app/index.dart';

GoRouter createRouterConfiguration () => GoRouter(
  redirect: topLevelRedirectHandler,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: 'sfd',);
      },
      routes: [
        GoRoute(
          path: '/test',
          builder: (BuildContext context, GoRouterState state) {
            return const TestPage();
          },
        ),
      ]
    ),
  ],
);