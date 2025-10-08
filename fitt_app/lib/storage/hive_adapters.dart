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
])

class HiveAdapters {}