import '../../../domain/models/requests/incidence_report_request.dart';
import '../../../domain/models/requests/police_station_request.dart';
import '../../../domain/models/responses/geo_address_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';
import 'incedence_state.dart';

class IncedenceCubit extends BaseCubit<IncedenceState, GetGeoAddressResponse> {
  final ApiRepository _apiRepository;

  IncedenceCubit(this._apiRepository)
      : super(const IncedenceLoadingState(), GetGeoAddressResponse());

  Future<void> incedence(
  {
    required String? locationImage,
    required String? latitude,
    required String? longitude,
    required String? createdBy,
    required String? description,}) async {
    if (isBusy) return;
    emit(const IncedenceLoadingState());
    await run(() async {
      var request = IncidenceReportRequest(
          locationImage: locationImage,
          latitude: latitude,
          longitude: longitude,
          createdBy: createdBy,
          description: description);
      final response = await _apiRepository.incidenceReport(request: request);
      if (response is DataSuccess) {
        emit(IncedenceSuccessState(response: response.data));
      } else if (response is DataFailed) {
        emit(IncedenceErrorState(error: response.error));
      }
    });
  }
}
