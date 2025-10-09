import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';
import 'config_notifier.dart';
import 'model/config_response_model.dart';

class ConfigurationService {
  final FirebaseRemoteConfig remoteConfig;
  final ConfigNotifier configNotifier;

  ConfigurationService({required this.remoteConfig, required this.configNotifier});

  Future<ConfigurationResponseModel> fetchConfiguration() async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await remoteConfig.ensureInitialized();
      await remoteConfig.fetchAndActivate();

      final mandatoryVersion = remoteConfig.getString('MandatoryVersion');

      return ConfigurationResponseModel(mandatoryVersion: mandatoryVersion);
    } catch (e) {
      return ConfigurationResponseModel(mandatoryVersion: '0.0.0');
    }
  }

  Future<void> checkVersion() async {
    final config = await fetchConfiguration();
    final packageInfo = await PackageInfo.fromPlatform();

    final currentVersion = Version.parse(packageInfo.version);
    final mandatoryVersion = Version.parse(config.mandatoryVersion);

    if (currentVersion < mandatoryVersion) {
      configNotifier.versionStatus = VersionStatus.mandatoryUpdate;
    }
  }
}
