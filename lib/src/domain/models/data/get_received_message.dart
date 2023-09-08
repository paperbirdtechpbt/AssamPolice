class GetReceivedMessages {
  int? messageId;
  int? parentMessagesId;
  String? senderName;
  String? senderUserName;
  List<String>? toRecipientUserNameList;
  Null? ccRecipientUserNameList;
  String? subject;
  String? messageBody;
  String? creationDate;
  bool? isSeen;

  GetReceivedMessages(
      {this.messageId,
        this.parentMessagesId,
        this.senderName,
        this.senderUserName,
        this.toRecipientUserNameList,
        this.ccRecipientUserNameList,
        this.subject,
        this.messageBody,
        this.creationDate,
        this.isSeen});

  GetReceivedMessages.fromMap(Map<String, dynamic> json) {
    messageId = json['messageId'];
    parentMessagesId = json['parentMessagesId'];
    senderName = json['senderName'];
    senderUserName = json['sender_UserName'];
    toRecipientUserNameList = json['toRecipient_UserNameList'].cast<String>();
    ccRecipientUserNameList = json['ccRecipient_UserNameList'];
    subject = json['subject'];
    messageBody = json['messageBody'];
    creationDate = json['creationDate'];
    isSeen = json['isSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['parentMessagesId'] = this.parentMessagesId;
    data['senderName'] = this.senderName;
    data['sender_UserName'] = this.senderUserName;
    data['toRecipient_UserNameList'] = this.toRecipientUserNameList;
    data['ccRecipient_UserNameList'] = this.ccRecipientUserNameList;
    data['subject'] = this.subject;
    data['messageBody'] = this.messageBody;
    data['creationDate'] = this.creationDate;
    data['isSeen'] = this.isSeen;
    return data;
  }
}
