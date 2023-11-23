import 'package:green_flux/core/handlers/env_properties.dart';

class EnvHandler{
  late EnvProperties envProperties;

  EnvHandler._();

  static final EnvHandler instance = EnvHandler._();

  /// This function need to be called when app initialized
  /// By using [String.fromEnvironment] it will read run args
  EnvHandler.setUpAdditionalArgs() {
    instance.envProperties = EnvProperties(
      baseUrl: const String.fromEnvironment("baseUrl"),
      environment: const String.fromEnvironment("environment"),
      apiKey: const String.fromEnvironment("apiKey"),
    );
  }

  bool get isDevEnv => envProperties.environment.toLowerCase() == "dev";

  bool get isProdEnv => envProperties.environment.toLowerCase() == "prod";
}