import 'package:fitt_app/features/appstart/masterdata/equipment/interactor/equipment_interactor.dart';
import 'package:fitt_app/features/appstart/masterdata/exercise/interactor/exercise_interactor.dart';
import 'package:fitt_app/features/appstart/masterdata/muscle/interactor/muscle_interactor.dart';
import 'package:fitt_app/features/appstart/masterdata/workout/interactor/workout_interactor.dart';
import 'package:fitt_app/features/workout_planner/models/workout_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../appstart/masterdata/workoutplan/interactor/workoutplan_interactor.dart';

part 'workout_planner_event.dart';

part 'workout_planner_state.dart';

class WorkoutPlannerBloc extends Bloc<WorkoutPlannerEvent, WorkoutPlannerState> {
  final ExerciseInteractor _exerciseInteractor = GetIt.instance<ExerciseInteractor>();
  final MuscleInteractor _muscleInteractor = GetIt.instance<MuscleInteractor>();
  final EquipmentInteractor _equipmentInteractor = GetIt.instance<EquipmentInteractor>();
  final WorkoutPlanInteractor _workoutPlanInteractor = GetIt.instance<WorkoutPlanInteractor>();
  final WorkoutInteractor _workoutInteractor = GetIt.instance<WorkoutInteractor>();

  WorkoutPlannerBloc() : super(WorkoutPlannerInitial()) {
    on<WorkoutPlannerEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreateMockExercisesEvent>((event, emit) async {
      await _createMockWorkoutPlan();
    });

    on<InitializeEvent>((event, emit) async {
      emit(WorkoutPlannerLoading());
      // try {
      //   final exercises = await _exerciseInteractor.getAllExercises();
      //   emit(WorkoutPlannerLoaded(exercises: exercises));
      // } catch (e, s) {
      //   print('Error loading exercises: $e $s');
      //   emit(WorkoutPlannerInitial()); // You might want to create an error state
      // }
      emit(WorkoutPlannerLoaded()); // You might want to create an error state
    });

    on<LoadExercisesEvent>((event, emit) async {
      emit(WorkoutPlannerLoading());
      try {
        final exercises = await _exerciseInteractor.getAllExercises();
        if (exercises.isEmpty) {
          emit(WorkoutPlannerNoData());
        } else {
          emit(ExercisesLoaded(exercises: exercises));
        }
      } catch (e) {
        emit(WorkoutPlannerError(message: 'Failed to load exercises.'));
      }
    });
    on<LoadMusclesEvent>((event, emit) async {
      emit(WorkoutPlannerLoading());
      try {
        final muscles = await _muscleInteractor.getAllMuscles();
        if (muscles.isEmpty) {
          emit(WorkoutPlannerNoData());
        } else {
          emit(MusclesLoaded(muscles: muscles));
        }
      } catch (e) {
        emit(WorkoutPlannerError(message: 'Failed to load muscles.'));
      }
    });

    on<LoadEquipmentsEvent>((event, emit) async {
      emit(WorkoutPlannerLoading());
      try {
        final equipments = await _equipmentInteractor.getAllEquipments();
        if (equipments.isEmpty) {
          emit(WorkoutPlannerNoData());
        } else {
          emit(EquipmentsLoaded(equipments: equipments));
        }
      } catch (e) {
        emit(WorkoutPlannerError(message: 'Failed to load equipments.'));
      }
    });

    on<LoadWorkoutPlansEvent>((event, emit) async {
      emit(WorkoutPlannerLoading());
      try {
        final workoutPlans = await _workoutPlanInteractor.getAllWorkoutPlans();
        if (workoutPlans.isEmpty) {
          emit(WorkoutPlannerNoData());
        } else {
          emit(WorkoutPlansLoaded(workoutPlans: workoutPlans));
        }
      } catch (e) {
        emit(WorkoutPlannerError(message: 'Failed to load workout plans.'));
      }
    });

    on<LoadWorkoutsEvent>((event, emit) async {
      emit(WorkoutPlannerLoading());
      try {
        final workouts = await _workoutInteractor.getAllWorkouts();
        if (workouts.isEmpty) {
          emit(WorkoutPlannerNoData());
        } else {
          emit(WorkoutsLoaded(workouts: workouts));
        }
      } catch (e) {
        emit(WorkoutPlannerError(message: 'Failed to load workouts.'));
      }
    });
  }

  Future<void> _createMockWorkoutPlan() async {
    final List<Muscle> muscles = await create5MockMuscles();
    final List<Equipment> equipments = await create5MockEquipments();
    final List<Exercise> exercises = await create5MockExercises(muscles, equipments);
    final List<Workout> workout = await createMockWorkoutList(exercises);
    final WorkoutPlan workoutPlan = await createMockWorkoutPlan(workout);
    workoutPlan.id;
  }
}

Future<WorkoutPlan> createMockWorkoutPlan(List<Workout> workout) async {
  final workoutPlanInteractor = GetIt.instance<WorkoutPlanInteractor>();

  final workoutPlan = WorkoutPlan(
    id: 'mock-workout-plan-full-body-split',
    name: 'Full Body Split',
    description:
        'A 3-day full-body workout plan designed for beginners to build strength and muscle mass across all major muscle groups.',
    workouts: workout,
  );

  await workoutPlanInteractor.createWorkoutPlan(workoutPlan);

  return workoutPlan;
}

Future<List<Workout>> createMockWorkoutList(List<Exercise> exercises) async {
  final workoutInteractor = GetIt.instance<WorkoutInteractor>();
  final workouts = [
    Workout(
      id: 'mock-workout-upper-body-push',
      name: 'Upper Body Push',
      workoutExercises: [
        WorkoutExercise(
          exercise: exercises[0], // Bench Press
          sets: 4,
          reps: 8,
          restTimeInSeconds: 90,
        ),
      ],
      duration: 20,
      difficulty: WorkoutDifficulty.medium,
    ),
    Workout(
      id: 'mock-workout-upper-body-pull',
      name: 'Upper Body Pull',
      workoutExercises: [
        WorkoutExercise(
          exercise: exercises[1], // Pull-up
          sets: 4,
          reps: 10,
          restTimeInSeconds: 90,
        ),
        WorkoutExercise(
          exercise: exercises[2], // Dumbbell Bicep Curl
          sets: 3,
          reps: 12,
          restTimeInSeconds: 60,
        ),
      ],
      duration: 30,
      difficulty: WorkoutDifficulty.medium,
    ),
    Workout(
      id: 'mock-workout-legs-and-core',
      name: 'Legs & Core Day',
      workoutExercises: [
        WorkoutExercise(
          exercise: exercises[3], // Squat
          sets: 5,
          reps: 5,
          restTimeInSeconds: 120,
        ),
        WorkoutExercise(
          exercise: exercises[4], // Plank
          sets: 3,
          reps: 1, // Represents holding for a duration
          restTimeInSeconds: 60,
        ),
      ],
      duration: 35,
      difficulty: WorkoutDifficulty.hard,
    ),
  ];
  for (final workout in workouts) {
    await workoutInteractor.createWorkout(workout);
  }

  return workouts;
}

Future<List<Exercise>> create5MockExercises(List<Muscle> muscles, List<Equipment> equipments) async {
  final exerciseInteractor = GetIt.instance<ExerciseInteractor>();

  final exercises = [
    Exercise(
      id: 'mock-exercise-bench-press',
      name: 'Bench Press',
      description: 'A classic upper body exercise that primarily targets the chest muscles.',
      muscleCategory: MuscleCategory.push,
      primaryMuscle: muscles[0],
      // Pectoralis Major
      secondaryMusclesIds: [muscles[1].id, muscles[2].id],
      // Shoulders, Triceps
      equipment: equipments[1], // Barbell
    ),
    Exercise(
      id: 'mock-exercise-pull-up',
      name: 'Pull-up',
      description: 'An upper-body strength exercise where the body is pulled up.',
      muscleCategory: MuscleCategory.pull,
      primaryMuscle: muscles[1],
      // Latissimus Dorsi
      secondaryMusclesIds: [muscles[2].id],
      // Biceps Brachii
      equipment: equipments[3], // Pull-up Bar
    ),
    Exercise(
      id: 'mock-exercise-dumbbell-bicep-curl',
      name: 'Dumbbell Bicep Curl',
      description: 'An isolation exercise that targets the biceps.',
      muscleCategory: MuscleCategory.pull,
      primaryMuscle: muscles[2],
      // Biceps Brachii
      secondaryMusclesIds: [],
      equipment: equipments[0], // Dumbbell
    ),
    Exercise(
      id: 'mock-exercise-squat',
      name: 'Squat',
      description: 'A compound, full-body exercise that trains primarily the muscles of the thighs, hips and buttocks.',
      muscleCategory: MuscleCategory.legs,
      primaryMuscle: muscles[3],
      // Quadriceps Femoris
      secondaryMusclesIds: [],
      equipment: equipments[1], // Barbell
    ),
    Exercise(
      id: 'mock-exercise-plank',
      name: 'Plank',
      description:
          'An isometric core strength exercise that involves maintaining a position similar to a push-up for the maximum possible time.',
      muscleCategory: MuscleCategory.core,
      primaryMuscle: muscles[4],
      // Rectus Abdominis
      secondaryMusclesIds: [],
      equipment: equipments[4], // Using resistance band as a placeholder, can be bodyweight
    ),
  ];

  for (final exercise in exercises) {
    await exerciseInteractor.createExercise(exercise);
  }

  return exercises;
}

Future<List<Equipment>> create5MockEquipments() async {
  final equipmentInteractor = GetIt.instance<EquipmentInteractor>();

  final equipments = [
    Equipment(
      id: 'mock-equipment-dumbbell',
      name: 'Dumbbell',
      description: 'A short bar with a weight at each end, used typically in pairs for exercise or muscle-building.',
    ),
    Equipment(
      id: 'mock-equipment-barbell',
      name: 'Barbell',
      description: 'A long bar with weights attached at each end, used for weightlifting.',
    ),
    Equipment(
      id: 'mock-equipment-kettlebell',
      name: 'Kettlebell',
      description: 'A large cast-iron ball-shaped weight with a single handle.',
    ),
    Equipment(
      id: 'mock-equipment-pull-up-bar',
      name: 'Pull-up Bar',
      description:
          'A horizontal bar fixed in position at a convenient height for performing chin-ups and other gymnastic exercises.',
    ),
    Equipment(
      id: 'mock-equipment-resistance-band',
      name: 'Resistance Band',
      description: 'An elastic band used for strength training. They are also commonly used in physical therapy.',
    ),
  ];

  for (final equipment in equipments) {
    await equipmentInteractor.createEquipment(equipment);
  }

  return equipments;
}

Future<List<Muscle>> create5MockMuscles() async {
  final muscleInteractor = GetIt.instance<MuscleInteractor>();

  final muscles = [
    Muscle(
      id: 'mock-muscle-pectoralis-major',
      name: 'Pectoralis Major',
      description: 'The large muscle in the upper chest, fanning across the chest from the shoulder to the breastbone.',
      muscleGroup: MuscleGroup.chest,
    ),
    Muscle(
      id: 'mock-muscle-latissimus-dorsi',
      name: 'Latissimus Dorsi',
      description: 'The large, flat muscle on the back that stretches to the sides, behind the arm.',
      muscleGroup: MuscleGroup.lats,
    ),
    Muscle(
      id: 'mock-muscle-biceps-brachii',
      name: 'Biceps Brachii',
      description: 'A large muscle in the front of the upper arm which flexes the forearm.',
      muscleGroup: MuscleGroup.biceps,
    ),
    Muscle(
      id: 'mock-muscle-quadriceps-femoris',
      name: 'Quadriceps Femoris',
      description: 'A large muscle group that includes the four prevailing muscles on the front of the thigh.',
      muscleGroup: MuscleGroup.quads,
    ),
    Muscle(
      id: 'mock-muscle-rectus-abdominis',
      name: 'Rectus Abdominis',
      description: 'A paired muscle running vertically on each side of the anterior wall of the human abdomen.',
      muscleGroup: MuscleGroup.core,
    ),
  ];

  for (final muscle in muscles) {
    await muscleInteractor.createMuscle(muscle);
  }

  return muscles;
}
