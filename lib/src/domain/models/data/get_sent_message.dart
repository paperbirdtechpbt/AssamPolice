class GetSentMessages {
  int? messageId;
  int? parentMessagesId;
  String? senderUserName;
  List<String>? toRecipientUserNameList;
  dynamic ccRecipientUserNameList;
  String? subject;
  String? messageBody;
  String ? longMessageBody = "";
  String? creationDate;

  GetSentMessages(
      {this.messageId,
        this.parentMessagesId,
        this.senderUserName,
        this.toRecipientUserNameList,
        this.ccRecipientUserNameList,
        this.subject,
        this.messageBody,
        this.longMessageBody,
        this.creationDate});

  GetSentMessages.fromMap(Map<String, dynamic> json) {
    messageId = json['messageId'];
    parentMessagesId = json['parentMessagesId'];
    senderUserName = json['sender_UserName'];
    toRecipientUserNameList = json['toRecipient_UserNameList'].cast<String>();
    ccRecipientUserNameList = json['ccRecipient_UserNameList'];
    subject = json['subject'];
    messageBody = json['messageBody'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['parentMessagesId'] = this.parentMessagesId;
    data['sender_UserName'] = this.senderUserName;
    data['toRecipient_UserNameList'] = this.toRecipientUserNameList;
    data['ccRecipient_UserNameList'] = this.ccRecipientUserNameList;
    data['subject'] = this.subject;
    data['messageBody'] = this.messageBody;
    data['creationDate'] = this.creationDate;
    return data;
  }
}