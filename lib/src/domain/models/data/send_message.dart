class SendMessage {
  int? messageId;

  SendMessage({this.messageId});

  SendMessage.fromMap(Map<String, dynamic> json) {
    messageId = json['messageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    return data;
  }
}