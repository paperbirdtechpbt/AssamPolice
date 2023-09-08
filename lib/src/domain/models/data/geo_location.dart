import 'dart:io';

class GeoLocation {
  GeoLocation({
    required this.photo,
    required this.lat,
    required this.long,
    required this.isFileUpload,
    required this.fileStatus,
  });

  GeoLocation.fromMap(dynamic json) {
    photo = json['photo'];
    lat = json['lat'];
    long = json['long'];
    isFileUpload = json['isFileUpload'];
    fileStatus = json['fileStatus'];
  }

  String? lat;
  String? long;
  File? photo;
  bool? isFileUpload;
  int? fileStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['long'] = long;
    map['photo'] = photo;
    map['isFileUpload'] = isFileUpload;
    map['fileStatus'] = fileStatus;

    return map;
  }
}
