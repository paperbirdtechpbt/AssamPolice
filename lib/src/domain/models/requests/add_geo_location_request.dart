class AddGeoLocationRequest {
  final int? id;
  final int? locationId;
  final String? locationImage;
  final String? latitude;
  final String? longitude;
  final String? status;
  final String? createdBy;

  AddGeoLocationRequest({
    required this.id,
    required this.locationId,
    required this.locationImage,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdBy,
  });
}
