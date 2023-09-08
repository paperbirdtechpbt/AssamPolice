class  GetAllVdpRoles {
  int? vdpRoleId;
  String? role;

  GetAllVdpRoles({this.vdpRoleId, this.role});

  GetAllVdpRoles.fromMap(Map<String, dynamic> json) {
    vdpRoleId = json['vdpRoleId'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vdpRoleId'] = this.vdpRoleId;
    data['role'] = this.role;
    return data;
  }
}