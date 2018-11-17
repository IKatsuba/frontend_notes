import 'package:firebase_remote_config/firebase_remote_config.dart';

class _Config {
  RemoteConfig remoteConfig;

  init() async {
    remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{'news_api_key': ''};
    await remoteConfig.setDefaults(defaults);

    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
  }

  String getNewsApiKey() => remoteConfig.getString('news_api_key');
}

final config = _Config();
