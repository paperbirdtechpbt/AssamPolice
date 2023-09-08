import '../../../domain/models/requests/police_station_request.dart';
import '../../../domain/models/responses/geo_address_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'geo_address_state.dart';

class GetGeoAddressCubit
    extends BaseCubit<GeoAddressState, GetGeoAddressResponse> {
  final ApiRepository _apiRepository;

  GetGeoAddressCubit(this._apiRepository)
      : super(const GeoAddressLoadingState(), GetGeoAddressResponse());

  Future<void> getGeoAddress(
    int? id,
    int? policeStationID,
    int? requestType,
  ) async {
    if (isBusy) return;
    emit(const GeoAddressLoadingState());
    await run(() async {
      var request = PoliceStationRequest(id: id, requestType: requestType, policeStationID: policeStationID);
      final response = await _apiRepository.getGeoAddress(request: request);
      if (response is DataSuccess) {
        emit(GeoAddressSuccessState(response: response.data));
      } else if (response is DataFailed) {
        emit(GeoAddressErrorState(error: response.error));
      }
    });
  }

  Future<void> getCompleteGeoAddress(
    int? id,
    int? requestType,
      int? policeStationID,
  ) async {
    if (isBusy) return;
    emit(const GeoAddressLoadingState());
    await run(() async {
      var request = PoliceStationRequest(id: id, requestType: requestType, policeStationID: policeStationID);
      final response = await _apiRepository.getGeoAddress(request: request);
      if (response is DataSuccess) {
        emit(GeoAddressCompleteSuccessState(response: response.data));
      } else if (response is DataFailed) {
        emit(GeoAddressErrorState(error: response.error));
      }
    });
  }
}
