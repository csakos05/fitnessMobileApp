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
  // You can add user-specific methods here if needed,
  // for example, findByUsername:
  //
  // Future<UserProfileModel?> findByUsername(String username) async {
  //   final snapshot = await collection.where('username', isEqualTo: username).limit(1).get();
  //   if (snapshot.docs.isEmpty) {
  //     return null;
  //   }
  //   return snapshot.docs.first.data();
  // }
}