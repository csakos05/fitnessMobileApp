import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../appstart/masterdata/equipment/interactor/equipment_interactor.dart';
import 'models/workout_model.dart';

class EquipmentDetails extends StatefulWidget {
  final String equipmentId;

  const EquipmentDetails({super.key, required this.equipmentId});

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  final EquipmentInteractor _equipmentInteractor = GetIt.instance<EquipmentInteractor>();
  Equipment? _equipment;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEquipment();
  }

  Future<void> _loadEquipment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final equipment = await _equipmentInteractor.getEquipmentById(widget.equipmentId);
      setState(() {
        _equipment = equipment;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading equipment: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Details'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _equipment == null
              ? const Center(
                  child: Text('Equipment not found'),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_equipment.toString()),
                ),
    );
  }
}