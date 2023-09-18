class GetUserMenuOption {
  String? userName;
  String? name;
  int? vdpCommittee;
  int? message;
  int? sos;
  int? logout;

  GetUserMenuOption(
      {this.userName,
        this.name,
        this.vdpCommittee,
        this.message,
        this.sos,
        this.logout});

  GetUserMenuOption.fromMap(Map<String, dynamic> json) {
    userName = json['userName'];
    name = json['name'];
    vdpCommittee = json['vdpCommittee'];
    message = json['message'];
    sos = json['sos'];
    logout = json['logout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['vdpCommittee'] = this.vdpCommittee;
    data['message'] = this.message;
    data['sos'] = this.sos;
    data['logout'] = this.logout;
    return data;
  }
}