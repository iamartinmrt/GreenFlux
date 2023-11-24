enum StationStatus { charging, available }

enum EvsesStatus {
  available("AVAILABLE"),
  charging("CHARGING"),
  unknown("UNKNOWN"),
  ;

  final String status;

  const EvsesStatus(this.status);

  /// Check the status string and return the matched status enum based on it
  static EvsesStatus findStatus(String statusName) {
    for (EvsesStatus item in EvsesStatus.values) {
      if (item.status == statusName) return item;
    }
    return unknown;
  }
}

enum EvsesPowerType {
  AC_1_PHASE("AC_1_PHASE", "Slow"),
  AC_3_PHASE("AC_3_PHASE", "Fast"),
  DC("DC", "Ultra fast"),
  unknown("UNKNOWN", "Unknown"),
  ;

  final String powerType;
  final String displayName;

  const EvsesPowerType(this.powerType, this.displayName);

  /// Check the power type string and return the matched enum based on it
  static EvsesPowerType findPowerType(String powerType) {
    for (EvsesPowerType item in EvsesPowerType.values) {
      if (item.powerType == powerType) return item;
    }
    return unknown;
  }
}

enum EvsesConnectorType {
  CHADEMO("CHADEMO", "CHAdeMO"),
  DOMESTIC_A("DOMESTIC_A", "Domestic A"),
  DOMESTIC_B("DOMESTIC_B", "Domestic B"),
  DOMESTIC_C("DOMESTIC_C", "Domestic C"),
  DOMESTIC_D("DOMESTIC_D", "Domestic D"),
  DOMESTIC_E("DOMESTIC_E", "Domestic E"),
  DOMESTIC_F("DOMESTIC_F", "Shuko"),
  DOMESTIC_G("DOMESTIC_G", "Domestic G"),
  DOMESTIC_H("DOMESTIC_H", "Domestic H"),
  DOMESTIC_I("DOMESTIC_I", "Domestic I"),
  DOMESTIC_J("DOMESTIC_J", "Domestic J"),
  DOMESTIC_K("DOMESTIC_K", "Domestic K"),
  DOMESTIC_L("DOMESTIC_L", "Domestic L"),
  IEC_60309_2_single_16("IEC_60309_2_single_16", "Single phase 16"),
  IEC_60309_2_three_16("IEC_60309_2_three_16", "Three phase 16"),
  IEC_60309_2_three_32("IEC_60309_2_three_32", "Three phase 32"),
  IEC_60309_2_three_64("IEC_60309_2_three_64", "Three phase 64"),
  IEC_62196_T1("IEC_62196_T1", "Type 1"),
  IEC_62196_T1_COMBO("IEC_62196_T1_COMBO", "CCS"),
  IEC_62196_T2("IEC_62196_T2", "Type 2"),
  IEC_62196_T2_COMBO("IEC_62196_T2_COMBO", "CCS2 COMBO"),
  IEC_62196_T3A("IEC_62196_T3A", "Type 3A"),
  IEC_62196_T3C("IEC_62196_T3C", "Type 3A"),
  TESLA_R("TESLA_R", "Tesla R"),
  TESLA_S("TESLA_S", "Tesla S"),
  unknown("UNKNOWN", "Unknown"),
  ;

  final String type;
  final String displayName;

  const EvsesConnectorType(this.type, this.displayName);

  /// Check the connector type string and return the matched enum based on it
  static EvsesConnectorType findConnectorType(String connectorName) {
    for (EvsesConnectorType item in EvsesConnectorType.values) {
      if (item.type == connectorName) return item;
    }
    return unknown;
  }
}
