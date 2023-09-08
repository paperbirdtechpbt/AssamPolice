import '../../../domain/models/requests/get_district_police_station_request.dart';
import '../../../domain/models/requests/police_station_request.dart';
import '../../../domain/models/responses/get_district_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState, GetDistrictResponse> {
  final ApiRepository _apiRepository;

  HomeCubit(this._apiRepository)
      : super(const HomeLoadingState(), GetDistrictResponse());

  Future<void> getDistrict(String? createdBy) async {
    if (isBusy) return;
    await run(() async {
      var request =
          GetDistrictPoliceStationRequest(createdBy: createdBy, id: null);
      final response = await _apiRepository.getDistrict(request: request);
      if (response is DataSuccess) {
        emit(GetDistrictSuccessState(response: response.data));
      } else if (response is DataFailed) {
        emit(HomeErrorState(error: response.error));
      }
    });
  }

  Future<void> getPoliceStation(int id, String createdBy) async {
    if (isBusy) return;
    await run(() async {
      var request =
          GetDistrictPoliceStationRequest(id: id, createdBy: createdBy);
      final response = await _apiRepository.getPoliceStation(request: request);
      if (response is DataSuccess) {
        emit(GetPoliceStationSuccessState(response: response.data));
      } else if (response is DataFailed) {
        emit(HomeErrorState(error: response.error));
      }
    });
  }

  Future<void> getCategory(int id) async {
    if (isBusy) return;
    emit(const HomeLoadingState());
    await run(() async {
      var request = PoliceStationRequest(
          id: id, requestType: null, policeStationID: null);
      final response = await _apiRepository.getCategory(request: request);
      if (response is DataSuccess) {
        emit(GetCategorySuccessState(categoryResponse: response.data));
      } else if (response is DataFailed) {
        emit(HomeErrorState(error: response.error));
      }
    });
  }
}
