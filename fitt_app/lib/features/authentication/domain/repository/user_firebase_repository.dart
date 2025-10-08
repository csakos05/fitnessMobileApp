import 'package:fitt_app/features/authentication/domain/model/user_profile_model.dart';
import 'package:fitt_app/infrastructure/firestore/firestore_collections.dart';

import '../../../../infrastructure/firestore/base_firestore_repository.dart';

class UserFirebaseRepository extends BaseFirestoreRepository<UserProfileModel> {
  UserFirebaseRepository()
      : super(
          FirestoreCollections.users, // The name of the Firestore collection
          UserProfileModel.fromJson,
          (userProfile) => userProfile.toJson(),
        );

  Future<void> createProfile(UserProfileModel userProfile) async {
    await create(userProfile.userId, userProfile);
  }

  Future<UserProfileModel?> getProfile(String userId) async {
    return await read(userId);
  }

}