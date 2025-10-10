import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/workout_planner_bloc.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {

  @override
  void initState() {
    super.initState();
    context.read<WorkoutPlannerBloc>().add(LoadExercisesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutPlannerBloc, WorkoutPlannerState>(
      builder: (context, state) {
        if(state is ExercisesLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.exercises.length,
            itemBuilder: (context, index) {
              final exercise = state.exercises[index];
              return Column(
                children: [
                  Text(exercise.toString()),
                ],
              );
            },
          );
        } else if(state is WorkoutPlannerLoading) {
          return Center(child: CircularProgressIndicator());
        } else if(state is WorkoutPlannerError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No exercises loaded.'));
        }
      },
    );
  }
}
