class GetMessageByParentId {
  int? messageId;
  String? messageBody;
  String? subject;
  String? senderUserName;
  String? creationDate;
  int? parentMessageId;
  bool isVisible = false;
  String? longMessage;

  GetMessageByParentId(
      {this.messageId,
        this.messageBody,
        this.subject,
        this.senderUserName,
        this.creationDate,
        this.parentMessageId,required this.isVisible,this.longMessage});

  GetMessageByParentId.fromMap(Map<String, dynamic> json) {
    messageId = json['messageId'];
    messageBody = json['messageBody'];
    subject = json['subject'];
    senderUserName = json['senderUserName'];
    creationDate = json['creationDate'];
    parentMessageId = json['parentMessageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['messageBody'] = this.messageBody;
    data['subject'] = this.subject;
    data['senderUserName'] = this.senderUserName;
    data['creationDate'] = this.creationDate;
    data['parentMessageId'] = this.parentMessageId;
    return data;
  }
}