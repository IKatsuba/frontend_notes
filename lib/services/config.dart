import 'package:firebase_remote_config/firebase_remote_config.dart';

class _Config {
  RemoteConfig remoteConfig;

  init() async {
    remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{'news_api_key': '', 'news_api_url': ''};
    await remoteConfig.setDefaults(defaults);

    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
  }

  String getNewsApiKey() => remoteConfig.getString('news_api_key');

  String getNewsApiUrl() => remoteConfig.getString('news_api_url');
}

final remoteConfig = _Config();
