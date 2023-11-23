/// Responsible for holding the Flutter additional run args
class EnvProperties {
  final String baseUrl;
  final String environment;
  final String apiKey;

  EnvProperties({
    required this.baseUrl,
    required this.environment,
    required this.apiKey,
  });
}
