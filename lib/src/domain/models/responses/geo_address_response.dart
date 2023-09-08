import 'package:equatable/equatable.dart';

import '../data/address.dart';

class GetGeoAddressResponse {
  GetGeoAddressResponse({
    this.status,
    this.message,
    this.data,
  });

  GetGeoAddressResponse.fromMap(Map<String, dynamic> json) {
    status = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? GeAddressData.fromMap(json['data']) : null;
  }

  String? status;
  String? message;
  GeAddressData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = status;
    map['message'] = message;
    return map;
  }
}

class GeAddressData extends Equatable {
  GeAddressData({
    required this.addressList,
  });

  final List<Address> addressList;

  factory GeAddressData.fromMap(Map<String, dynamic> map) {
    return GeAddressData(
      addressList: List<Address>.from(
        map['locationList'].map<Address>(
          (x) => Address.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [addressList];
}
