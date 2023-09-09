class GetSentMessages {
  final int? parentMessagesIds;
  final String? parentMessages;
  final int? messageId;
  final int? parentMessagesId;
  final String? senderName;
  final String? senderUserName;
  final List<String>? toRecipientUserNameList;
  final List<String>? ccRecipientUserNameList;
  final String? subject;
  final String? messageBody;
  final String? creationDate;


  GetSentMessages({
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

  });

  factory GetSentMessages.fromMap(Map<String, dynamic> json) {
    return GetSentMessages(
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

    };
  }
}
