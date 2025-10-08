import 'dart:async';

import 'package:fitt_app/features/authentication/domain/service/login_notifier.dart';
import 'package:fitt_app/infrastructure/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

FutureOr<String?> topLevelRedirectHandler(BuildContext context, GoRouterState state) async {
  final LoginNotifier loginNotifier = GetIt.instance<LoginNotifier>();
  final bool isLoggedIn = loginNotifier.value.name == 'loggedIn';
    // If the user is not logged in and is not headed to the login page, redirect to login
    if (!isLoggedIn && state.matchedLocation != NavigationRoutes.loginPage.name) {
      return '/${NavigationRoutes.loginPage.name}';
    }




  // By default no redirect is needed
  String? redirectUrl;

  return redirectUrl;
}