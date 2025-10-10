import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/workout_planner_bloc.dart';

class MuscleList extends StatefulWidget {
  const MuscleList({super.key});

  @override
  State<MuscleList> createState() => _MuscleListState();
}

class _MuscleListState extends State<MuscleList> {
  @override
  void initState() {
    super.initState();
    context.read<WorkoutPlannerBloc>().add(LoadMusclesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutPlannerBloc, WorkoutPlannerState>(
      builder: (context, state) {
        if(state is MusclesLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.muscles.length,
            itemBuilder: (context, index) {
              final muscle = state.muscles[index];
              return Text(muscle.toString());
            },
          );
        } else if(state is WorkoutPlannerLoading) {
          return Center(child: CircularProgressIndicator());
        } else if(state is WorkoutPlannerError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No muscles loaded.'));
        }
      },
    );
  }
}
