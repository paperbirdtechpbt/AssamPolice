import '../../../domain/models/requests/get_body_message.dart';
import '../../../domain/models/requests/get_message_by_parent_id_request.dart';
import '../../../domain/models/requests/get_receive_message_request.dart';
import '../../../domain/models/requests/get_received_messages_with_parent_details_request.dart';
import '../../../domain/models/requests/get_sent_message.dart';
import '../../../domain/models/requests/get_sent_messages_with_parent_details_request.dart';
import '../../../domain/models/requests/get_user_list_tocc_request.dart';
import '../../../domain/models/requests/send_message_request.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'message_state.dart';

class MessageCubit extends BaseCubit<MessageState, LoginResponse> {
  final ApiRepository _apiRepository;

  MessageCubit(this._apiRepository)
      : super(const SendMessageInitialState(), LoginResponse());

  Future<void> sendMessage(String? senderUserName,
      List<String>? toRecipients,
      List<String>? cCRecipients,
      String? messageSubject,
      String? messageBody,
      int? parentMessagesId,) async {
    if (isBusy) return;

    await run(() async {
      emit(const SendMessageLoadingState());
      var request = SendMessageRequest(
          senderUserName: senderUserName,
          toRecipients: toRecipients,
          cCRecipients: cCRecipients,
          messagSubject: messageSubject,
          messagBody: messageBody,
          parentMessagesId: parentMessagesId

      );
      final response = await _apiRepository.sendMessage(request: request);
      if (response is DataSuccess) {
        emit(SendMessageSuccessState(sendMessageResponse: response.data));
      } else if (response is DataFailed) {
        emit(SendMessageErrorState(error: response.error));
      }
    });
  }


  Future<void> getReceivedMessages(String? userName,
      int? startIndex,
      int? noOfMessage) async {
    if (isBusy) return;

    await run(() async {
      emit(const GetReceivedMessagesLoadingState());
      var request = GetReceivedMessagesRequest(
          userName: userName,
          startIndex: startIndex,
          numberofMessage: noOfMessage
      );
      final response = await _apiRepository.getReceivedMessages(
          request: request);
      if (response is DataSuccess) {
        emit(GetReceivedMessagesSuccessState(
            getReceivedMessagesResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetReceivedMessagesErrorState(error: response.error));
      }
    });
  }


  Future<void> getSentMessages(String? userName,
      int? startIndex,
      int? noOfMessage) async {
    if (isBusy) return;

    await run(() async {
      emit(const GetSentMessagesLoadingState());
      var request = GetSentMessagesRequest(
          userName: userName,
          startIndex: startIndex,
          numberofMessage: noOfMessage
      );
      final response = await _apiRepository.getSentMessages(request: request);
      if (response is DataSuccess) {
        emit(GetSentMessagesSuccessState(
            getSentMessagesResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetSentMessagesErrorState(error: response.error));
      }
    });
  }


  Future<void> getMessageBody(String? userName,
      int? messageId,) async {
    if (isBusy) return;

    await run(() async {
      emit(const GetMessageBodyLoadingState());
      var request = GetMessageBodyRequest(
        userName: userName,
        messageId: messageId,
      );
      final response = await _apiRepository.getMessageBody(request: request);
      if (response is DataSuccess) {
        emit(GetMessageBodySuccessState(getMessageBodyResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetMessageBodyErrorState(error: response.error));
      }
    });
  }


  Future<void> getParentMessageBody(String? userName,
      int? messageId,) async {
    if (isBusy) return;

    await run(() async {
      emit(const GetMessageBodyLoadingState());
      var request = GetMessageBodyRequest(
        userName: userName,
        messageId: messageId,
      );
      final response = await _apiRepository.getMessageBody(request: request);
      if (response is DataSuccess) {
        emit(GetParentMessageBodySuccessState(getMessageBodyResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetMessageBodyErrorState(error: response.error));
      }
    });
  }

  //GetReceivedMessagesWithParentDetails

  Future<void> getReceivedMessagesWithParentDetails(String? userName,
      int? startIndex,
      int? noOfMessage) async {
    if (isBusy) return;

    await run(() async {
      emit(const GetReceivedMessagesWithParentDetailsLoadingState());
      var request = GetReceivedMessagesWithParentDetailsRequest(
          userName: userName,
          startIndex: startIndex,
          numberofMessage: noOfMessage
      );
      final response = await _apiRepository
          .getReceivedMessagesWithParentDetails(request: request);
      if (response is DataSuccess) {
        emit(GetReceivedMessagesWithParentDetailsSuccessState(
            getReceivedMessagesWithParentDetailsResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetReceivedMessagesWithParentDetailsErrorState(
            error: response.error));
      }
    });
  }

// getSentMessagesWithParentDetails

  Future<void> getSentMessagesWithParentDetails(String? userName,
      int? startIndex,
      int? noOfMessage) async {
    if (isBusy) return;

    await run(() async {
      emit(const GetSentMessagesWithParentDetailsLoadingState());
      var request = GetSentMessagesWithParentDetailsRequest(
          userName: userName,
          startIndex: startIndex,
          numberofMessage: noOfMessage
      );
      final response = await _apiRepository.getSentMessagesWithParentDetails(
          request: request);
      if (response is DataSuccess) {
        emit(GetSentMessagesWithParentDetailsSuccessState(
            getSentMessagesWithParentDetailsResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetSentMessagesWithParentDetailsErrorState(error: response.error));
      }
    });
  }


//GetUserListTOCC

  Future<void>getUserListTO(
          String? userName,
          int? transactionMode,
          String? senderType) async {
        await run(() async {
          emit(const GetUserListTOCCLoadingState());
          var request = GetUserListTOCCRequest(
              userName: userName,
              transactionMode: transactionMode,
              senderType: senderType
          );
      final response = await _apiRepository.getUserListTOCC(
          request: request);
      if (response is DataSuccess) {
        emit(GetUserListTOCCSuccessState(
            getUserListTOCCResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetUserListTOCCErrorState(error: response.error));
      }
    });
  }


  Future<void>getUserListCC(String? userName,
      int? transactionMode,
      String? senderType) async {
    if (isBusy) return;
    await run(() async {
      emit(const GetUserListCCLoadingState());
      var request = GetUserListTOCCRequest(
          userName: userName,
          transactionMode: transactionMode,
          senderType: senderType
      );
      final response = await _apiRepository.getUserListTOCC(
          request: request);
      if (response is DataSuccess) {
        emit(GetUserListCCSuccessState(
            getUserListTOCCResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetUserListCCErrorState(error: response.error));
      }
    });
  }


Future<void>getMessageByParentId(
    String? userName,
    int? parentMessageId) async {
    if (isBusy) return;
    await run(() async {
      emit(const GetMessageByParentIdLoadingState());
      var request = GetMessageByParentIdRequest(
          userName: userName,
          parentMessageId: parentMessageId,

      );
      final response = await _apiRepository.getMessageByParentId(
          request: request);
      if (response is DataSuccess) {
        emit(GetMessageByParentIdSuccessState(
            getMessageByParentIdResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetMessageByParentIdErrorState(error: response.error));
      }
    });
  }
}
