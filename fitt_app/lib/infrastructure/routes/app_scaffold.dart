import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, navigationShell.currentIndex),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Train',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  /// Dinamikusan létrehozza az AppBar-t az index alapján.
  /// Visszaadhat null-t is, ha egy adott oldalon nem szeretnél AppBar-t.
  PreferredSizeWidget? _buildAppBar(BuildContext context, int index) {
    switch (index) {
      case 0: // HomePage
        return AppBar(
          title: const Text('Home'),
        );
      case 1: // WorkoutPlannerPage
        return AppBar(
          title: const Text('Workout Planner'),
        );
      case 2: // TrainPage
        return AppBar(
          title: const Text('Train'),
        );
      case 3: // ProfilePage
        return AppBar(
          title: const Text('Profile'),
        );
      default:
        return AppBar();
    }
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}