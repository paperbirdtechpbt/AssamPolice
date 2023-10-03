class GetReceivedMessages {
    int? parentMessagesIds;
    String? parentMessages;
    int? messageId;
    int? parentMessagesId;
    String? senderName;
    String? senderUserName;
    List<String>? toRecipientUserNameList;
    List<String>? ccRecipientUserNameList;
    String? subject;
    String? messageBody;
    String? creationDate;
    int? messageCount;
    bool? isSeen;

  GetReceivedMessages({
    this.parentMessagesIds,
    this.parentMessages,
    this.messageId,
    this.parentMessagesId,
    this.senderName,
    this.senderUserName,
    this.toRecipientUserNameList,
    this.ccRecipientUserNameList,
    this.subject,
    this.messageBody,
    this.creationDate,
    this.messageCount,
    this.isSeen,
  });

  factory GetReceivedMessages.fromMap(Map<String, dynamic> json) {
    return GetReceivedMessages(
      parentMessagesIds: json['parentMessagesIds'],
      parentMessages: json['parentMessages'],
      messageId: json['messageId'],
      parentMessagesId: json['parentMessagesId'],
      senderName: json['senderName'],
      senderUserName: json['sender_UserName'],
      toRecipientUserNameList: json['toRecipient_UserNameList']?.cast<String>(),
      ccRecipientUserNameList: json['ccRecipient_UserNameList']?.cast<String>(),
      subject: json['subject'],
      messageBody: json['messageBody'],
      creationDate: json['creationDate'],
      isSeen: json['isSeen'],
      messageCount: json['messageCount'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'parentMessagesIds': parentMessagesIds,
      'parentMessages': parentMessages,
      'messageId': messageId,
      'parentMessagesId': parentMessagesId,
      'senderName': senderName,
      'sender_UserName': senderUserName,
      'toRecipient_UserNameList': toRecipientUserNameList,
      'ccRecipient_UserNameList': ccRecipientUserNameList,
      'subject': subject,
      'messageBody': messageBody,
      'creationDate': creationDate,
      'messageCount': messageCount,
      'isSeen': isSeen,
    };
  }
}
