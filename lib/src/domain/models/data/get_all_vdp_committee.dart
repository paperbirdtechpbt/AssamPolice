import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class GetAllVDPCommittee {
  int? vdpId;
 String? vdpName;
 String? latitude;
 String? longitude;
 int? policeStationId;
 String? policeStationName;
 String? districtName;
   int? districtId;
 String? status;
 String? createdBy;

  GetAllVDPCommittee(
      {this.vdpId,
        this.vdpName,
        this.latitude,
        this.longitude,
        this.policeStationId,
        this.policeStationName,
        this.districtName,
        this.districtId,
        this.status,
        this.createdBy
      });

  GetAllVDPCommittee.fromMap(Map<String, dynamic> json) {
    vdpId = json['vdpId'];
    vdpName = json['vdpName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    districtName = json['districtName'];
    policeStationName = json['policeStationName'];
    policeStationId = json['policeStationID'];
    districtId = json['districtID'];
    status = json['status'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vdpId'] = this.vdpId;
    data['vdpName'] = this.vdpName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['policeStationID'] = this.policeStationId;
    data['districtID'] = this.districtId;
    data['policeStationName'] = this.policeStationName;
    data['districtName'] = this.districtName;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

