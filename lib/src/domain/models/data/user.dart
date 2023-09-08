class User {
  User({
    this.name,
    this.email,
    this.mobile,
    this.active,
    this.profilePic,
  });

  User.fromMap(dynamic json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    active = json['active'];
    profilePic = json['profilePic'];
  }

  String? name;
  String? email;
  String? mobile;
  String? active;
  String? profilePic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['active'] = active;
    map['profilePic'] = profilePic;
    return map;
  }
}
