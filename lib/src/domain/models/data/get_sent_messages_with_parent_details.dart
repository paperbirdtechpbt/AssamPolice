class GetSentMessagesWithParentDetails {
  List<int>? parentMessagesIds;
  List<ParentMessages>? parentMessages;
  int? messageId;
  int? parentMessagesId;
  String? senderName;
  String? senderUserName;
  List<String>? toRecipientUserNameList;
  dynamic ccRecipientUserNameList;
  String? subject;
  String? messageBody;
  String? creationDate;
  bool? isSeen;
  bool isVisible = false;

  GetSentMessagesWithParentDetails(
      {this.parentMessagesIds,
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
        this.isSeen,
      required this.isVisible});

  GetSentMessagesWithParentDetails.fromMap(Map<String, dynamic> json) {
    if (json.containsKey('parentMessagesIds') && json['parentMessagesIds'] != null) {
      parentMessagesIds = json['parentMessagesIds'].cast<int>();
    }
    if (json['parentMessages'] != null) {
      parentMessages = <ParentMessages>[];
      json['parentMessages'].forEach((v) {
        parentMessages!.add(new ParentMessages.fromMap(v));
      });
    }
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
    data['parentMessagesIds'] = this.parentMessagesIds;
    if (this.parentMessages != null) {
      data['parentMessages'] =
          this.parentMessages!.map((v) => v.toJson()).toList();
    }
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

class ParentMessages {
  int? messageId;
  int? parentMessagesId;
  String? senderName;
  String? senderUserName;
  List<String>? toRecipientUserNameList;
  dynamic ccRecipientUserNameList;
  String? subject;
  String? messageBody;
  String? creationDate;
  bool? isSeen;

  ParentMessages(
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

  ParentMessages.fromMap(Map<String, dynamic> json) {
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