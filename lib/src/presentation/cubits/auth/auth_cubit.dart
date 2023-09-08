import '../../../domain/models/requests/auth_request.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState, LoginResponse> {
  final ApiRepository _apiRepository;

  AuthCubit(this._apiRepository)
      : super(const AuthLoadingState(), LoginResponse());

  Future<void> doLogin(
      {required String? userName, required String password}) async {
    if (isBusy) return;

    await run(() async {
      emit(const AuthLoadingState());
      var request = AuthRequest(userName: userName, password: password);
      final response = await _apiRepository.doLogin(request: request);
      if (response is DataSuccess) {
        emit(AuthSuccessState(response: response.data));
      } else if (response is DataFailed) {
        emit(AuthErrorState(error: response.error));
      }
    });
  }
}
