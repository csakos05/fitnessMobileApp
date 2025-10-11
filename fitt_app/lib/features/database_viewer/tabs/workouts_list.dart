import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/database_viewer_bloc.dart';

class WorkoutsList extends StatefulWidget {
  const WorkoutsList({super.key});

  @override
  State<WorkoutsList> createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {

  @override
  void initState() {
    super.initState();
    context.read<DatabaseViewerBloc>().add(LoadWorkoutsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseViewerBloc, DatabaseViewerState>(
      builder: (context, state) {
        if(state is WorkoutsLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.workouts.length,
            itemBuilder: (context, index) {
              final workout = state.workouts[index];
              return Text(workout.toString());
            },
          );
        } else if(state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if(state is Error) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No workouts loaded.'));
        }
      },
    );
  }
}
