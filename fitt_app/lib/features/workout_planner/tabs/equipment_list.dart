import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../equipment_details.dart';
import '../logic/workout_planner_bloc.dart';

class EquipmentList extends StatefulWidget {
  const EquipmentList({super.key});

  @override
  State<EquipmentList> createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {

  @override
  void initState() {
    super.initState();
    context.read<WorkoutPlannerBloc>().add(LoadEquipmentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutPlannerBloc, WorkoutPlannerState>(
      builder: (context, state) {
        if(state is EquipmentsLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.equipments.length,
            itemBuilder: (context, index) {
              final equipment = state.equipments[index];
              return GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return EquipmentDetails(equipmentId: equipment.id,);
                  },);
                },
                  child: Text(equipment.toString()));
            },
          );
        } else if(state is WorkoutPlannerLoading) {
          return Center(child: CircularProgressIndicator());
        } else if(state is WorkoutPlannerError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('No equipments loaded.'));
        }
      },
    );
  }
}
