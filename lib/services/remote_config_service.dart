import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final _remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero, // dev only
      ),
    );

    // Default values (fallback)
    await _remoteConfig.setDefaults({
      "base_fee": 5000.0,
      "price_per_km": 2000.0,
      "price_per_item": 200.0,
      "express_fee": 2.0,
      "free_delivery_threshold": 50000.0,
    });

    await _remoteConfig.fetchAndActivate();
  }
}