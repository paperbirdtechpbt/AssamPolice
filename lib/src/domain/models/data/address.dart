import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int? locationId;
  final int?  id;
  final String? locationName;

  const Address({
    required this.id,
    required this.locationId,
    required this.locationName,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] != null ? map['id'] as int : null,
      locationId: map['locationId'] != null ? map['locationId'] as int : null,
      locationName:
          map['locationName'] != null ? map['locationName'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      locationId,
      locationName,
    ];
  }
}
