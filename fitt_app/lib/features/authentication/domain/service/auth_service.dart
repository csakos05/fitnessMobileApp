import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitt_app/features/authentication/domain/interactor/profile_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_notifier.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final LoginNotifier _loginNotifier = GetIt.instance<LoginNotifier>();
  final ProfileInteractor _profileInteractor = GetIt.instance<ProfileInteractor>();



  AuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn, LoginNotifier? loginNotifier})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;


  User ? get currentUser => _firebaseAuth.currentUser;

  Future<void> checkLoginStatus() async {
    final user = await _firebaseAuth.authStateChanges().first;
    if (user != null) {
      _loginNotifier.value = AuthStatus.loggedIn;
    } else {
      _loginNotifier.value = AuthStatus.loggedOut;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _loginNotifier.value = AuthStatus.loggedIn;
      await _profileInteractor.getProfile();
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth =  googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      _loginNotifier.value = AuthStatus.loggedIn;
      await _profileInteractor.getProfile();
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
      _loginNotifier.value = AuthStatus.loggedOut;
    } catch (e) {
      rethrow;
    }
  }
}