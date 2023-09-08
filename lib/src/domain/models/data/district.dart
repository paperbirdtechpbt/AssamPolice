class District {
  District({
    this.id,
    this.name,
  });

  District.fromMap(dynamic json) {
    id = json['dropDownId'];
    name = json['dropDownName'];
  }

  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dropDownId'] = id;
    map['dropDownName'] = name;

    return map;
  }
}
