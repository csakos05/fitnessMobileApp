import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/database_viewer_bloc.dart';

class WorkoutplanList extends StatefulWidget {
  const WorkoutplanList({super.key});

  @override
  State<WorkoutplanList> createState() => _WorkoutplanListState();
}

class _WorkoutplanListState extends State<WorkoutplanList> {

  @override
  void initState() {
    super.initState();
    context.read<DatabaseViewerBloc>().add(LoadWorkoutPlansEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseViewerBloc, DatabaseViewerState>(
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
        } else if(state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if(state is Error) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No workout plans loaded.'));
        }
      },
    );
  }
}
