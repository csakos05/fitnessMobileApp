import 'package:fitt_app/features/authentication/domain/model/user_profile_model.dart';
import 'package:fitt_app/features/authentication/domain/repository/user_firebase_repository.dart';

class AuthInteractor {
  final UserFirebaseRepository _firebaseRepository = UserFirebaseRepository();
  Future<void>  createProfile({required UserProfileModel userProfile}) async {
    // Here you would typically interact with a repository or service to handle
    // the profile creation logic, such as saving to a database or making an API call.
    // For this example, we'll just print the user profile details.
    print('Creating profile for: ${userProfile.username}, Age: ${userProfile.age}');
    await _firebaseRepository.create(userProfile.userId, userProfile);

  }
}