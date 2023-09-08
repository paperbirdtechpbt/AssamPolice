class GetMessageBody {
  int? messageId;
  String? messageBody;

  GetMessageBody({this.messageId, this.messageBody});

  GetMessageBody.fromMap(Map<String, dynamic> json) {
    messageId = json['messageId'];
    messageBody = json['messageBody'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['messageBody'] = this.messageBody;
    return data;
  }
}