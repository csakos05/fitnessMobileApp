import 'package:flutter/foundation.dart';

enum AuthStatus { unknown, loggedIn, loggedOut }

class LoginNotifier extends ValueNotifier<AuthStatus> {
  LoginNotifier() : super(AuthStatus.unknown);
}