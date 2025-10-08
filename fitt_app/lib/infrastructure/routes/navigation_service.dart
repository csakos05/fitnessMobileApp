import 'package:fitt_app/infrastructure/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationService {
  final BuildContext context;

  AppNavigationService._(this.context);

  /// Access the navigation service from any widget with a BuildContext
  static AppNavigationService of(BuildContext context) {
    return AppNavigationService._(context);
  }

  String _createRoutePath(NavigationRoutes route) {
    return '/${route.name}';
  }

  void goToRoute({required NavigationRoutes route, Object? extra}) {
    GoRouter.of(context).go(_createRoutePath(route), extra: extra);
  }

  void goToTest() {
    goToRoute(route: NavigationRoutes.test);
  }

  void goToLogin() {
    goToRoute(route: NavigationRoutes.loginPage);
  }
}