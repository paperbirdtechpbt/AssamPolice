import 'package:flutter_clean_architecture/src/presentation/cubits/vdp_committee/vdp_committee_state.dart';

import '../../../domain/models/requests/add_vdp_committee_request.dart';
import '../../../domain/models/requests/auth_request.dart';
import '../../../domain/models/requests/update_vdp_committee_request.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';

class VdpCommitteeCubit extends BaseCubit<VdpCommitteeState, LoginResponse> {
  final ApiRepository _apiRepository;

  VdpCommitteeCubit(this._apiRepository)
      : super(const VdpCommitteeLoadingState(), LoginResponse());

  Future<void> getAllVdpCommittee() async {
    if (isBusy) return;

    await run(() async {
      emit(const VdpCommitteeLoadingState());

      final response = await _apiRepository.getAllVdpCommittee();
      if (response is DataSuccess) {
        emit(VdpCommitteeSuccessState(getAllVDPCommitteeResponse: response.data));
      } else if (response is DataFailed) {
        emit(VdpCommitteeErrorState(error: response.error));
      }
    });
  }

  //addVdpCommittee
  Future<void> addVdpCommittee(
  {
  String?   vdpName,
  String? latitude,
  String? longitude,
  String? policeStation,
  String? status,
    String? district
}
      ) async {
    if (isBusy) return;

    await run(() async {
      emit(const AddVdpCommitteeLoadingState());
final request = AddVdpCommitteeRequest(
    vdpName: vdpName,
    latitude: latitude,
    longitude: longitude,
    policeStation: policeStation,
    status: status,
    district: district
);
      final response = await _apiRepository.addVdpCommittee(request: request);
      if (response is DataSuccess) {
        emit(AddVdpCommitteeSuccessState(addVdpCommitteeResponse: response.data));
      } else if (response is DataFailed) {
        emit(AddVdpCommitteeErrorState(error: response.error));
      }
    });
  }


  //updatevdpcommittee
  Future<void> updateVdpCommittee(
      {
        int? vdpId,
        String?   vdpName,
        String? latitude,
        String? longitude,
        String? policeStation,
        String? status,
        String? district
      }
      ) async {
    if (isBusy) return;

    await run(() async {
      emit(const UpdateVdpCommitteeLoadingState());
      final request = UpdateVdpCommitteeRequest(
        vdpId: vdpId,
          vdpName: vdpName,
          latitude: latitude,
          longitude: longitude,
          policeStation: policeStation,
          status: status,
          district: district
      );
      final response = await _apiRepository.updateVdpCommittee(request: request);
      if (response is DataSuccess) {
        emit(UpdateVdpCommitteeSuccessState(updateVdpCommitteeResponse: response.data));
      } else if (response is DataFailed) {
        emit(UpdateVdpCommitteeErrorState(error: response.error));
      }
    });
  }


}
