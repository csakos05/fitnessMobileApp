import 'package:fitt_app/infrastructure/routes/navigation_routes.dart';
import 'package:fitt_app/infrastructure/routes/top_level_redirect_handler.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fitt_app/index.dart';
import '../../features/authentication/domain/service/login_notifier.dart';
import '../../features/authentication/view/login/login_scaffold.dart';
import '../../features/authentication/view/profile/profile_scaffold.dart';

final LoginNotifier loginNotifier = GetIt.instance<LoginNotifier>();

GoRouter createRouterConfiguration() => GoRouter(
  redirect: topLevelRedirectHandler,
  initialLocation: '/${NavigationRoutes.home.name}',
  refreshListenable: loginNotifier,
  routes: <RouteBase>[
    GoRoute(
      path: '/${NavigationRoutes.home.name}',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: 'sfd');
      },
    ),
    GoRoute(
      path: '/${NavigationRoutes.loginPage.name}',
      builder: (context, state) {
        return LoginScaffold();
      },
    ),

    GoRoute(
      path: '/${NavigationRoutes.profilePage.name}',
      builder: (context, state) {
        return const ProfileScaffold();
      },
    ),
    GoRoute(
      path: '/test',
      builder: (BuildContext context, GoRouterState state) {
        return const TestPage();
      },
    ),
  ],
);
