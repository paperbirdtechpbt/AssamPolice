import 'package:equatable/equatable.dart';

import '../data/district.dart';

class GetDistrictResponse {
  GetDistrictResponse({
    this.status,
    this.message,
    this.data,
  });

  GetDistrictResponse.fromMap(Map<String, dynamic> json) {
    status = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? DistrictData.fromMap(json['data']) : null;
  }

  String? status;
  String? message;
  DistrictData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = status;
    map['message'] = message;
    return map;
  }
}

class DistrictData extends Equatable {
  DistrictData({
    required this.listDistrict,
  });

  late final List<District> listDistrict;

  factory DistrictData.fromMap(Map<String, dynamic> map) {
    return DistrictData(
      listDistrict: List<District>.from(
        map['recordList'].map<District>(
          (x) => District.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [listDistrict];
}
