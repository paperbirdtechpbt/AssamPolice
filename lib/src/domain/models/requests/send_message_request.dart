class SendMessageRequest {
String? senderUserName;
  List<String>? toRecipients;
 List<String>? cCRecipients;
 String? messagSubject;
 String? messagBody;
 int? parentMessagesId;

SendMessageRequest(
      {this.senderUserName,
      this.toRecipients,
      this.cCRecipients,
      this.messagSubject,
      this.messagBody,
      this.parentMessagesId});
}