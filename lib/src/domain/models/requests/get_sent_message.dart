class GetSentMessagesRequest {
  String? userName;
  int? startIndex;
  int? numberofMessage;

  GetSentMessagesRequest(
      {this.userName, this.startIndex, this.numberofMessage});
}