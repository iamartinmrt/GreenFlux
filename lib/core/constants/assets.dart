class Assets{

  static String get availableStatus => getCommonResources("available_status");

  static String get chargingStatus => getCommonResources("charging_status");

  static String getCommonResources(String img)=> "assets/images/$img.png";
}