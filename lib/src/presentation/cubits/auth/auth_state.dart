import 'package:dio/dio.dart';

import '../../../domain/models/responses/login_response.dart';

abstract class AuthState {
  final LoginResponse? response;
  final DioError? error;

  const AuthState({
    this.response,
    this.error,
  });

  List<Object?> get props => [response, error];
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthSuccessState extends AuthState {
  const AuthSuccessState({super.response});
}

class AuthErrorState extends AuthState {
  const AuthErrorState({super.error});
}
