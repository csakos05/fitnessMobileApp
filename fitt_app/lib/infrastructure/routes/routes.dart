import 'package:fitt_app/features/profile/profile_update_page.dart';
import 'package:fitt_app/features/database_viewer/database_viewer_page.dart';
import 'package:fitt_app/features/workout_planner/workout_planner_page.dart';
import 'package:fitt_app/infrastructure/configuration_api/pages/update_mandatory_page.dart';
import 'package:fitt_app/infrastructure/routes/navigation_routes.dart';
import 'package:fitt_app/infrastructure/routes/top_level_redirect_handler.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fitt_app/index.dart';
import '../../features/home/home.dart';
import '../../features/train/train_page.dart';
import '../configuration_api/config_notifier.dart';
import '../../features/authentication/view/login/login_scaffold.dart';
import '../../features/profile/profile_provider.dart';
import 'app_scaffold.dart';

final ConfigNotifier configNotifier = GetIt.instance<ConfigNotifier>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouterConfiguration() => GoRouter(
      navigatorKey: _rootNavigatorKey,
      redirect: topLevelRedirectHandler,
      initialLocation: '/${NavigationRoutes.homePage.name}',
      refreshListenable: configNotifier,
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AppScaffold(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${NavigationRoutes.homePage.name}',
                  builder: (BuildContext context, GoRouterState state) {
                    return const MyHomePage(title: 'Home');
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${NavigationRoutes.workoutPlannerPage.name}',
                  builder: (BuildContext context, GoRouterState state) {
                    return const WorkoutPlannerPage();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${NavigationRoutes.trainPage.name}',
                  builder: (BuildContext context, GoRouterState state) {
                    return TrainPage();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${NavigationRoutes.profilePage.name}',
                  builder: (context, state) {
                    return const ProfileProvider();
                  },
                  routes: [
                    GoRoute(
                      path: NavigationRoutes.profileUpdatePage.name,
                      builder: (context, state) {
                        return ProfileUpdatePageProvider();
                      },
                    ),
                  ]
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${NavigationRoutes.databaseViewerPage.name}',
                  builder: (BuildContext context, GoRouterState state) {
                    return const DatabaseViewerPage();
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/${NavigationRoutes.loginPage.name}',
          builder: (context, state) {
            return LoginScaffold();
          },
        ),
        GoRoute(
          path: '/${NavigationRoutes.updateMandatoryPage.name}',
          builder: (BuildContext context, GoRouterState state) {
            return const UpdateMandatoryPage();
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