class Assets{

  static String get availableStatus => getCommonResources("available_status");

  static String get chargingStatus => getCommonResources("charging_status");

  static String get errorIcon => getCommonResources("error");

  static String get typingIcon => getCommonResources("typing");

  static String get noResultIcon => getCommonResources("no_results");

  static String getCommonResources(String img)=> "assets/images/$img.png";
}