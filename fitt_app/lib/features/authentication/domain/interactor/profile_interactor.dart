import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitt_app/features/authentication/domain/model/user_profile_model.dart';
import 'package:fitt_app/features/authentication/domain/repository/user_firebase_repository.dart';
import 'package:fitt_app/features/authentication/domain/repository/user_repository.dart';

class ProfileInteractor {
  final UserFirebaseRepository _firebaseRepository = UserFirebaseRepository();
  final UserHiveRepository _hiveRepository = UserHiveRepository();
  Future<UserProfileModel>  createEmptyProfile({required User user}) async {
    final userProfile = UserProfileModel(
      userId: user.uid,
      userEmail: user.email ?? '',
      subscriptionType: SubscriptionType.free,
      profileCompleted: false,
      createdAt: DateTime.now(),
      age: 0,
      height: 0.0,
      weight: 0.0,
      gender: null,
    );
    await _firebaseRepository.create(userProfile.userId, userProfile);
    await _hiveRepository.saveUserProfile(userProfile);
    return userProfile;
  }

  Future<UserProfileModel> getProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is null');
    }
    final localProfile = await _hiveRepository.getUserProfile(user.uid);
    if (localProfile != null) {
      return localProfile;
    }
    final remoteProfile = await _firebaseRepository.getProfile(user.uid);
    if (remoteProfile != null) {
      await _hiveRepository.saveUserProfile(remoteProfile);
      return remoteProfile;
    }
    final UserProfileModel emptyUser = await createEmptyProfile(user: user);
    return emptyUser;
  }

  Future<void> clearLocalProfile({required String userId}) async {
    await _hiveRepository.deleteUserProfile(userId);
  }

  Future<void> updateProfile(UserProfileModel profile) async {
    await _firebaseRepository.update(profile.userId, profile.toJson());
    await _hiveRepository.saveUserProfile(profile);
  }
}