class City {
  City({
    this.id,
    this.stateId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  City.fromMap(dynamic json) {
    id = json['id'];
    stateId = json['state_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  int? id;
  int? stateId;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['state_id'] = stateId;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }
}
