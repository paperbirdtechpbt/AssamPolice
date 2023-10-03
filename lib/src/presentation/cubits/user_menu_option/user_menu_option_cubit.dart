import 'package:assam_police_vdp/src/presentation/cubits/user_menu_option/user_menu_option_state.dart';

import '../../../domain/models/requests/get_body_message.dart';
import '../../../domain/models/requests/get_receive_message_request.dart';
import '../../../domain/models/requests/get_received_messages_with_parent_details_request.dart';
import '../../../domain/models/requests/get_sent_message.dart';
import '../../../domain/models/requests/get_sent_messages_with_parent_details_request.dart';
import '../../../domain/models/requests/get_user_list_tocc_request.dart';
import '../../../domain/models/requests/get_user_menu_option_request.dart';
import '../../../domain/models/requests/send_message_request.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';

class UserMenuOptionCubit extends BaseCubit<UserMenuOptionState, LoginResponse> {
  final ApiRepository _apiRepository;

  UserMenuOptionCubit(this._apiRepository)
      : super(const UserMenuOptionInitialState(), LoginResponse());




  Future<void> getUserMenuOptions(

      String? userName,

      int? transactionMode,

      ) async {
    if (isBusy) return;

    await run(() async {
      emit(const UserMenuOptionLoadingState());
      var request = GetUserMenuOptionRequest(
          userName: userName,
         transactionMode : transactionMode,

      );
      final response = await _apiRepository.getUserMenuOption(
          request: request);
      if (response is DataSuccess) {
        emit(UserMenuOptionSuccessState(
            getUserMenuOptionResponse: response.data));
      } else if (response is DataFailed) {
        emit(UserMenuOptionErrorState(error: response.error));
      }
    });
  }

}
