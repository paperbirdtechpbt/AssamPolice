import 'package:dio/dio.dart';

import '../../../domain/models/responses/geo_address_response.dart';
import '../../../domain/models/responses/get_message_body_response.dart';
import '../../../domain/models/responses/get_received_messages_response.dart';
import '../../../domain/models/responses/get_received_messages_with_parent_details.dart';
import '../../../domain/models/responses/get_sent_message_response.dart';
import '../../../domain/models/responses/get_sent_messages_with_parent_details_response.dart';
import '../../../domain/models/responses/get_user_list_tocc_response.dart';
import '../../../domain/models/responses/get_user_menu_option_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/models/responses/send_message_response.dart';

abstract class MessageState {
  final GetGeoAddressResponse? response;
  final GetReceivedMessagesResponse? getReceivedMessagesResponse;
  final GetSentMessagesResponse? getSentMessagesResponse;
  final GetMessageBodyResponse? getMessageBodyResponse;
  final SendMessageResponse? sendMessageResponse;
  final GetReceivedMessagesWithParentDetailsResponse? getReceivedMessagesWithParentDetailsResponse;
  final GetSentMessagesWithParentDetailsResponse? getSentMessagesWithParentDetailsResponse;
  final GetUserListTOCCResponse? getUserListTOCCResponse;
  final DioError? error;

  const MessageState({
    this.response,
    this.getReceivedMessagesResponse,
    this.getSentMessagesResponse,
    this.getMessageBodyResponse,
    this.sendMessageResponse,
    this.getReceivedMessagesWithParentDetailsResponse,
    this.getSentMessagesWithParentDetailsResponse,
    this.getUserListTOCCResponse,
    this.error,
  });

  List<Object?> get props => [response, getUserListTOCCResponse,error,getReceivedMessagesResponse,getSentMessagesResponse,getMessageBodyResponse,sendMessageResponse,getReceivedMessagesWithParentDetailsResponse,getSentMessagesWithParentDetailsResponse];
}

class SendMessageInitialState extends MessageState {
  const SendMessageInitialState();
}

class SendMessageLoadingState extends MessageState {
  const SendMessageLoadingState();
}

class SendMessageSuccessState extends MessageState {
  const SendMessageSuccessState({super.sendMessageResponse});
}

class SendMessageErrorState extends MessageState {
  const SendMessageErrorState({super.error});
}


// GetReceivedMessages

class GetReceivedMessagesInitialState extends MessageState {
  const GetReceivedMessagesInitialState();
}

class GetReceivedMessagesLoadingState extends MessageState {
  const GetReceivedMessagesLoadingState();
}

class GetReceivedMessagesSuccessState extends MessageState {
  const GetReceivedMessagesSuccessState({super.getReceivedMessagesResponse});
}

class GetReceivedMessagesErrorState extends MessageState {
  const GetReceivedMessagesErrorState({super.error});
}


// GetSentMessages

class GetSentMessagesInitialState extends MessageState {
  const GetSentMessagesInitialState();
}

class GetSentMessagesLoadingState extends MessageState {
  const GetSentMessagesLoadingState();
}

class GetSentMessagesSuccessState extends MessageState {
  const GetSentMessagesSuccessState({super.getSentMessagesResponse});
}

class GetSentMessagesErrorState extends MessageState {
  const GetSentMessagesErrorState({super.error});
}

// GetMessageBody

class GetMessageBodyInitialState extends MessageState {
  const GetMessageBodyInitialState();
}

class GetMessageBodyLoadingState extends MessageState {
  const GetMessageBodyLoadingState();
}

class GetMessageBodySuccessState extends MessageState {
  const GetMessageBodySuccessState({super.getMessageBodyResponse});
}

class GetMessageBodyErrorState extends MessageState {
  const GetMessageBodyErrorState({super.error});
}

//getReceivedMessagesWithParentDetailsResponse

class GetReceivedMessagesWithParentDetailsInitialState extends MessageState {
  const GetReceivedMessagesWithParentDetailsInitialState();
}

class GetReceivedMessagesWithParentDetailsLoadingState extends MessageState {
  const GetReceivedMessagesWithParentDetailsLoadingState();
}

class GetReceivedMessagesWithParentDetailsSuccessState extends MessageState {
  const GetReceivedMessagesWithParentDetailsSuccessState({super.getReceivedMessagesWithParentDetailsResponse});
}

class GetReceivedMessagesWithParentDetailsErrorState extends MessageState {
  const GetReceivedMessagesWithParentDetailsErrorState({super.error});
}

//getSentMessagesWithParentDetails


class GetSentMessagesWithParentDetailsInitialState extends MessageState {
  const GetSentMessagesWithParentDetailsInitialState();
}

class GetSentMessagesWithParentDetailsLoadingState extends MessageState {
  const GetSentMessagesWithParentDetailsLoadingState();
}

class GetSentMessagesWithParentDetailsSuccessState extends MessageState {
  const GetSentMessagesWithParentDetailsSuccessState({super.getSentMessagesWithParentDetailsResponse});
}

class GetSentMessagesWithParentDetailsErrorState extends MessageState {
  const GetSentMessagesWithParentDetailsErrorState({super.error});
}


//GetUserListTO


class GetUserListTOCCInitialState extends MessageState {
  const GetUserListTOCCInitialState();
}

class GetUserListTOCCLoadingState extends MessageState {
  const GetUserListTOCCLoadingState();
}

class GetUserListTOCCSuccessState extends MessageState {
  const GetUserListTOCCSuccessState({super.getUserListTOCCResponse});
}

class GetUserListTOCCErrorState extends MessageState {
  const GetUserListTOCCErrorState({super.error});
}

//GetUserListCC

class GetUserListCCInitialState extends MessageState {
  const GetUserListCCInitialState();
}

class GetUserListCCLoadingState extends MessageState {
  const GetUserListCCLoadingState();
}

class GetUserListCCSuccessState extends MessageState {
  const GetUserListCCSuccessState({super.getUserListTOCCResponse});
}

class GetUserListCCErrorState extends MessageState {
  const GetUserListCCErrorState({super.error});
}
