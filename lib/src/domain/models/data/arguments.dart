class Arguments {
  String? mobile;
  int? categoryID;
  String? policeStationId;

  Arguments(
      {required this.mobile,
      required this.categoryID,
      required this.policeStationId});

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'categoryID': categoryID,
      'policeStationId': policeStationId,
    };
  }

  Arguments.fromJson(Map json) {
    this.mobile = json["mobile"];
    this.categoryID = json["categoryID"];
    this.policeStationId = json["PoliceStationId"];
  }
}
