import 'dart:async';

import 'package:fitt_app/infrastructure/configuration_api/config_notifier.dart';
import 'package:fitt_app/infrastructure/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

FutureOr<String?> topLevelRedirectHandler(BuildContext context, GoRouterState state) async {
  final ConfigNotifier loginNotifier = GetIt.instance<ConfigNotifier>();
  final bool isLoggedIn = loginNotifier.authStatus.name == AuthStatus.loggedIn.name;
  final bool isUpdateMandatory = loginNotifier.versionStatus.name == VersionStatus.mandatoryUpdate.name;

  if (isUpdateMandatory) {
    return '/${NavigationRoutes.updateMandatoryPage.name}';
  }
  // If the user is not logged in and is not headed to the login page, redirect to login
  if (!isLoggedIn && state.matchedLocation != NavigationRoutes.loginPage.name) {
    return '/${NavigationRoutes.loginPage.name}';
  }

  // By default no redirect is needed
  String? redirectUrl;

  return redirectUrl;
}
