import 'package:fitt_app/features/authentication/domain/model/user_profile_model.dart';
import 'package:fitt_app/storage/hive_boxes.dart';

import '../../../../storage/abstract_hive_repository.dart';

class UserHiveRepository extends HiveRepository<UserProfileModel> {
  UserHiveRepository() : super(hiveBoxName: HiveBoxNames.userProfile);

  Future<UserProfileModel?> getUserProfile(String userId) async {
    return await getValue(userId);
  }

  Future<void> saveUserProfile(UserProfileModel userProfile) async {
    await putValue(userProfile.userId, userProfile);
  }

  Future<void> deleteUserProfile(String userId) async {
    await deleteValue(userId);
  }
}