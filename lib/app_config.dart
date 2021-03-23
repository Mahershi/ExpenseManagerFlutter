import 'package:flutter/widgets.dart';

enum Environment { DEVELOPMENT, STAGING, PRODUCTION }
enum Device { IOS, ANDROID }

class Config {
  String environment;
  String baseUrl;
  String clientId;
  String clientSecret;
  String clientDevice;
  String token;
  String imagePath;

  Config({
    @required this.environment,
    @required this.baseUrl,
    @required this.clientId,
    @required this.clientSecret,
    @required this.clientDevice,
    @required this.token,
    @required this.imagePath,
  });
}

class AppConfig {
  static Config config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEVELOPMENT:
        config = _Config.development;
        break;
      case Environment.STAGING:
        config = _Config.staging;
        break;
      case Environment.PRODUCTION:
        config = _Config.production;
        break;
    }
  }
}

class _Config {

  static const version = "1.0.0";
  static const api = 'app/';
  static const baseUrl = "http://192.168.1.200:8000/";

  static Config development = Config(
    environment: 'development',
    baseUrl: '$baseUrl$api',
    // imagePath: '$baseUrl$imagePATH',
    clientId: '',
    clientSecret: '',
    clientDevice: '',
    token: '',
  );

  static Config staging = Config(
    environment: 'staging',
    // baseUrl: '$stagingBaseURL$version',
    // imagePath: '$stagingBaseURL$imagePATH',
    clientId: '',
    clientSecret: '',
    clientDevice: '',
    token: '',
  );

  static Config production = Config(
    environment: 'production',
    // imagePath: '$stagingBaseURL$imagePATH',
    // baseUrl: '$stagingBaseURL$version',
    clientId: '',
    clientSecret: '',
    clientDevice: '',
    token: '',
  );
}
