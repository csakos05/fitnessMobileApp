import 'package:flutter/foundation.dart';

enum AuthStatus { unknown, loggedIn, loggedOut }
enum VersionStatus { mandatoryUpdate, optionalUpdate, noUpdate, upToDate }

class ConfigNotifier extends ChangeNotifier {
  AuthStatus _authStatus = AuthStatus.unknown;
  VersionStatus _versionStatus = VersionStatus.noUpdate;

  AuthStatus get authStatus => _authStatus;
  set authStatus(AuthStatus value) {
    if (_authStatus != value) {
      _authStatus = value;
      notifyListeners();
    }
  }

  VersionStatus get versionStatus => _versionStatus;
  set versionStatus(VersionStatus value) {
    if (_versionStatus != value) {
      _versionStatus = value;
      notifyListeners();
    }
  }
}