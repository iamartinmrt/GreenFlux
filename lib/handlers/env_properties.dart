/// Responsible for holding the Flutter additional run args
class EnvProperties {
  final String baseUrl;
  final String name;
  final String environment;
  final String apiKey;

  EnvProperties({
    required this.baseUrl,
    required this.name,
    required this.environment,
    required this.apiKey,
  });
}
