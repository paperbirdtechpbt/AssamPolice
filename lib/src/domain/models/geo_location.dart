import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../utils/constants/strings.dart';
import 'source.dart';

@Entity(tableName: geoLocationTableName)
class GeoLocation extends Equatable {

  @PrimaryKey(autoGenerate: false)
  final int? id;
  final double ? latitude;
  final double? longitude;


  const GeoLocation({
    this.id,
    required this.latitude,
    required this.longitude,
  });

  factory GeoLocation.fromMap(Map<String, dynamic> map) {
    return GeoLocation(
      id: map['id'] != null ? map['id'] as int : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      latitude,
      longitude,
    ];
  }
}
