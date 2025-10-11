import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({required this.navigationShell, Key? key}) : super(key: key ?? const ValueKey<String>('AppNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Planner'),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Train'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.data_array), label: 'Database'),
      ],
      currentIndex: navigationShell.currentIndex,
      onTap: (int index) => _onTap(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }
}
