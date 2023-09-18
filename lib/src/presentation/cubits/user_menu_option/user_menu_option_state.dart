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

abstract class UserMenuOptionState {
  final GetUserMenuOptionResponse? getUserMenuOptionResponse;

  final DioError? error;

  const UserMenuOptionState({
    this.getUserMenuOptionResponse,

    this.error,
  });

  List<Object?> get props => [getUserMenuOptionResponse];
}

class UserMenuOptionInitialState extends UserMenuOptionState {
  const UserMenuOptionInitialState();
}

class UserMenuOptionLoadingState extends UserMenuOptionState {
  const UserMenuOptionLoadingState();
}

class UserMenuOptionSuccessState extends UserMenuOptionState {
  const UserMenuOptionSuccessState({super.getUserMenuOptionResponse});
}

class UserMenuOptionErrorState extends UserMenuOptionState {
  const UserMenuOptionErrorState({super.error});
}


