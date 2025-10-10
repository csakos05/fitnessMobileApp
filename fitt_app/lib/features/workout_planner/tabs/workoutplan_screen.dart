import 'package:fitt_app/features/workout_planner/logic/workout_planner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutplanScreen extends StatefulWidget {
  const WorkoutplanScreen({super.key});

  @override
  State<WorkoutplanScreen> createState() => _WorkoutplanScreenState();
}

class _WorkoutplanScreenState extends State<WorkoutplanScreen> {

  @override
  void initState() {
    super.initState();
    context.read<WorkoutPlannerBloc>().add(LoadWorkoutPlansEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutPlannerBloc, WorkoutPlannerState>(
      builder: (context, state) {
        if(state is WorkoutPlansLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.workoutPlans.length,
            itemBuilder: (context, index) {
              final workoutPlan = state.workoutPlans[index];
              return Text(workoutPlan.toString());
            },
          );
        } else if(state is WorkoutPlannerLoading) {
          return Center(child: CircularProgressIndicator());
        } else if(state is WorkoutPlannerError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No workout plans loaded.'));
        }
      },
    );
  }
}
