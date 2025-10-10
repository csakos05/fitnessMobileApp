import 'package:fitt_app/features/workout_planner/tabs/equipment_list.dart';
import 'package:fitt_app/features/workout_planner/tabs/exercise_list.dart';
import 'package:fitt_app/features/workout_planner/tabs/muscle_list.dart';
import 'package:fitt_app/features/workout_planner/tabs/workoutplan_screen.dart';
import 'package:fitt_app/features/workout_planner/tabs/workouts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/workout_planner_bloc.dart';

class WorkoutPlannerPage extends StatelessWidget {
  const WorkoutPlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutPlannerBloc(),
      child: WorkoutPlannerPageInner(),
    );
  }
}

class WorkoutPlannerPageInner extends StatefulWidget {
  const WorkoutPlannerPageInner({super.key});

  @override
  State<WorkoutPlannerPageInner> createState() => _WorkoutPlannerPageInnerState();
}

class _WorkoutPlannerPageInnerState extends State<WorkoutPlannerPageInner> {

  @override
  void initState() {
    super.initState();
    context.read<WorkoutPlannerBloc>().add(InitializeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutPlannerBloc, WorkoutPlannerState>(
      buildWhen: (previous, current) {
        if(current is EquipmentsLoaded ||
           current is MusclesLoaded ||
           current is ExercisesLoaded ||
           current is WorkoutPlansLoaded ||
            current is WorkoutPlannerLoading ||
           current is WorkoutsLoaded) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if(state is WorkoutPlannerLoading) {
          return Center(child: CircularProgressIndicator());
        }
        else if(state is WorkoutPlannerLoaded) {
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
                    context.read<WorkoutPlannerBloc>().add(LoadExercisesEvent());
                  },
                  child: Text('Load Exercises'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<WorkoutPlannerBloc>().add(CreateMockExercisesEvent());
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
          WorkoutplanScreen(),
        ],
      ),
    ),
  );
}
