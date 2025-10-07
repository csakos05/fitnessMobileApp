import 'package:hive_ce/hive.dart';

import '../test_page/example_hive_model.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Product>(),
  AdapterSpec<Categories>(),
])

class HiveAdapters {}