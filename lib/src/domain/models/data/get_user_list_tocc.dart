class GetUserListTOCC {
  String? userName;
  String? name;

  GetUserListTOCC({this.userName, this.name});

  GetUserListTOCC.fromMap(Map<String, dynamic> json) {
    userName = json['userName'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['name'] = this.name;
    return data;
  }
}