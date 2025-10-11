
import 'package:fitt_app/features/database_viewer/tabs/equipment_list.dart';
import 'package:fitt_app/features/database_viewer/tabs/exercise_list.dart';
import 'package:fitt_app/features/database_viewer/tabs/muscle_list.dart';
import 'package:fitt_app/features/database_viewer/tabs/workoutplan_screen.dart';
import 'package:fitt_app/features/database_viewer/tabs/workouts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/database_viewer_bloc.dart';

class DatabaseViewerPage extends StatelessWidget {
  const DatabaseViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseViewerBloc(),
      child: DatabaseViewerPageInner(),
    );
  }
}

class DatabaseViewerPageInner extends StatefulWidget {
  const DatabaseViewerPageInner({super.key});

  @override
  State<DatabaseViewerPageInner> createState() => _DatabaseViewerPageInnerState();
}

class _DatabaseViewerPageInnerState extends State<DatabaseViewerPageInner> {

  @override
  void initState() {
    super.initState();
    context.read<DatabaseViewerBloc>().add(InitializeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseViewerBloc, DatabaseViewerState>(
      buildWhen: (previous, current) {
        if(current is EquipmentsLoaded ||
           current is MusclesLoaded ||
           current is ExercisesLoaded ||
           current is WorkoutPlansLoaded ||
            current is Loading ||
           current is WorkoutsLoaded) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if(state is Loading) {
          return Center(child: CircularProgressIndicator());
        }
        else if(state is Loaded) {
          return _buildTabBar();
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No exercises loaded.'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<DatabaseViewerBloc>().add(LoadExercisesEvent());
                  },
                  child: Text('Load Exercises'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<DatabaseViewerBloc>().add(CreateMockExercisesEvent());
                  },
                  child: Text('Create Mock Exercise'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Widget _buildTabBar() {
  return DefaultTabController(
    length: 5,
    child: Scaffold(
      appBar: AppBar(
        bottom: const TabBar(
          isScrollable: true,
          tabs: [
            Tab(text: 'Equipment'),
            Tab(text: 'Muscles'),
            Tab(text: 'Exercises'),
            Tab(text: 'Workouts'),
            Tab(text: 'Workout Plans'),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          EquipmentList(),
          MuscleList(),
          ExerciseList(),
          WorkoutsList(),
          WorkoutplanList(),
        ],
      ),
    ),
  );
}
