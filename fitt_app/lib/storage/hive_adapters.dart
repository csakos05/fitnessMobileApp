import 'package:fitt_app/features/workout_planner/models/workout_model.dart';
import 'package:hive_ce/hive.dart';

import '../features/authentication/domain/model/user_profile_model.dart';
import '../test_page/example_hive_model.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Product>(),
  AdapterSpec<Categories>(),
  AdapterSpec<SubscriptionType>(),
  AdapterSpec<Gender>(),
  AdapterSpec<UserProfileModel>(),
  AdapterSpec<MuscleGroup>(),
  AdapterSpec<Equipment>(),
  AdapterSpec<Muscle>(),
  AdapterSpec<Exercise>(),
  AdapterSpec<MuscleCategory>(),
  AdapterSpec<Workout>(),
  AdapterSpec<WorkoutExercise>(),
  AdapterSpec<WorkoutDifficulty>(),
  AdapterSpec<WorkoutPlan>(),
])

class HiveAdapters {}