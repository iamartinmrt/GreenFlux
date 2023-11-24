
enum StationStatus{charging, available}

enum EvsesStatus{
  available("AVAILABLE"),
  charging("CHARGING"),
  unknown("UNKNOWN"),
  ;

  final String status;

  const EvsesStatus(this.status);

  /// Check the status string and return the matched status enum based on it
  static EvsesStatus findStatus(String statusName){
    for(EvsesStatus item in EvsesStatus.values){
      if(item.status == statusName) return item;
    }
    return unknown;
  }
}

enum EvsesPowerType{
  AC_1_PHASE("AC_1_PHASE"),
  AC_3_PHASE("AC_3_PHASE"),
  DC("DC"),
  unknown("UNKNOWN"),
  ;

  final String powerType;

  const EvsesPowerType(this.powerType);

  /// Check the power type string and return the matched enum based on it
  static EvsesPowerType findPowerType(String statusName){
    for(EvsesPowerType item in EvsesPowerType.values){
      if(item.powerType == statusName) return item;
    }
    return unknown;
  }
}
