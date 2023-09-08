import '../../../domain/models/requests/add_geo_location_request.dart';
import '../../../domain/models/responses/geo_address_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'add_geo_location_state.dart';

class AddGeoLocationCubit
    extends BaseCubit<AddGeoLocationState, GetGeoAddressResponse> {
  final ApiRepository _apiRepository;

  AddGeoLocationCubit(this._apiRepository)
      : super(const AddGeoLocationLoadingState(), GetGeoAddressResponse());

  Future<void> addGeoLocation(AddGeoLocationRequest request) async {
    if (isBusy) return;
    emit(const AddGeoLocationLoadingState());
    await run(() async {
      final response = await _apiRepository.addGeoLocation(request: request);
      if (response is DataSuccess) {
        emit(AddGeoLocationSuccessState(response: response.data));
      } else if (response is DataFailed) {
        emit(AddGeoLocationErrorState(error: response.error));
      }
    });
  }
}
