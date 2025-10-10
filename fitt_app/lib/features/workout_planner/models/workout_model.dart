import 'package:hive_ce/hive.dart';

class WorkoutPlan extends HiveObject {
  final String id;
  final String name;
  final String description;
  final List<Workout> workouts;

  WorkoutPlan({required this.id, required this.name, required this.description, required this.workouts});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'workouts': workouts.map((w) => w.toJson()).toList()};
  }

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      workouts: (json['workouts'] as List).map((w) => Workout.fromJson(w)).toList(),
    );
  }

  @override
  String toString() {
    return 'WorkoutPlan{id: $id, name: $name, description: $description, workouts: $workouts}';
  }
}

enum WorkoutDifficulty { easy, medium, hard }

class Workout extends HiveObject {
  final String id;
  final String name;
  final List<WorkoutExercise> workoutExercises;
  final int duration;
  final WorkoutDifficulty difficulty;

  Workout({
    required this.id,
    required this.name,
    required this.workoutExercises,
    required this.duration,
    required this.difficulty,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'workoutExercises': workoutExercises.map((e) => e.toJson()).toList(),
      'duration': duration,
      'difficulty': difficulty.name,
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      workoutExercises: (json['workoutExercises'] as List).map((e) => WorkoutExercise.fromJson(e)).toList(),
      duration: json['duration'],
      difficulty: WorkoutDifficulty.values.firstWhere(
        (e) => e.name == json['difficulty'],
        orElse: () => WorkoutDifficulty.medium,
      ),
    );
  }

  @override
  String toString() {
    return 'Workout{id: $id, name: $name, workoutExercises: $workoutExercises, duration: $duration, difficulty: $difficulty}';
  }
}

class WorkoutExercise {
  final Exercise exercise;
  final int sets;
  final int reps;
  final int restTimeInSeconds;

  WorkoutExercise({required this.exercise, required this.sets, required this.reps, required this.restTimeInSeconds});

  Map<String, dynamic> toJson() {
    return {'exercise': exercise.toJson(), 'sets': sets, 'reps': reps, 'restTimeInSeconds': restTimeInSeconds};
  }

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      exercise: Exercise.fromJson(json['exercise']),
      sets: json['sets'],
      reps: json['reps'],
      restTimeInSeconds: json['restTimeInSeconds'],
    );
  }

  @override
  String toString() {
    return 'WorkoutExercise{exercise: $exercise, sets: $sets, reps: $reps, restTimeInSeconds: $restTimeInSeconds}';
  }
}

class Exercise extends HiveObject {
  final String id;
  final String name;
  final String description;
  final MuscleCategory muscleCategory;
  final Muscle primaryMuscle;
  final List<String> secondaryMusclesIds;
  final Equipment equipment;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.muscleCategory,
    required this.primaryMuscle,
    required this.secondaryMusclesIds,
    required this.equipment,
  });

  /// Converts the Exercise instance to a JSON map, embedding full Muscle and Equipment objects.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'muscleCategory': muscleCategory.name,
      'primaryMuscle': primaryMuscle.toJson(),
      'secondaryMusclesIds': secondaryMusclesIds,
      'equipment': equipment.toJson(),
    };
  }

  /// Creates an Exercise instance from a JSON map.
  /// Assumes that 'primaryMuscle' and 'equipment' are nested JSON objects.
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      muscleCategory: MuscleCategory.values.firstWhere(
        (e) => e.name == json['muscleCategory'],
        orElse: () => MuscleCategory.core,
      ),
      primaryMuscle: Muscle.fromJson(json['primaryMuscle']),
      secondaryMusclesIds: List<String>.from(json['secondaryMusclesIds']),
      equipment: Equipment.fromJson(json['equipment']),
    );
  }

  @override
  String toString() {
    return 'Exercise{id: $id, name: $name, description: $description, muscleCategory: $muscleCategory, primaryMuscle: $primaryMuscle, secondaryMusclesIds: $secondaryMusclesIds, equipment: $equipment}';
  }
}

class Equipment extends HiveObject {
  final String id;
  final String name;
  final String description;

  Equipment({required this.id, required this.name, required this.description});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(id: json['id'], name: json['name'], description: json['description']);
  }

  @override
  String toString() {
    return 'Equipment{id: $id, name: $name, description: $description}';
  }
}

class Muscle extends HiveObject {
  final String id;
  final String name;
  final String description;
  final MuscleGroup muscleGroup;

  Muscle({required this.id, required this.name, required this.description, required this.muscleGroup});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'muscleGroup': muscleGroup.toString().split('.').last};
  }

  factory Muscle.fromJson(Map<String, dynamic> json) {
    return Muscle(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      muscleGroup: MuscleGroup.values.firstWhere(
        (e) => e.toString().split('.').last == (json['muscleGroup'] ?? 'core'),
        orElse: () => MuscleGroup.none,
      ),
    );
  }

  @override
  String toString() {
    return 'Muscle{id: $id, name: $name, description: $description, muscleGroup: $muscleGroup}';
  }
}

enum MuscleCategory { push, pull, legs, core, cardio }

enum MuscleGroup {
  chest,
  shoulders,
  triceps,
  back,
  biceps,
  quads,
  hamstrings,
  glutes,
  calves,
  abs,
  cardio,
  none,
  core,
  lats,
}
