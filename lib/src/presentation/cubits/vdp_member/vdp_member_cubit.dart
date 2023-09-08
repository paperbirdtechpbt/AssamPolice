import 'package:flutter_clean_architecture/src/presentation/cubits/vdp_committee/vdp_committee_state.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/vdp_member/vdp_member_state.dart';

import '../../../domain/models/requests/add_vdp_committee_request.dart';
import '../../../domain/models/requests/add_vdp_member_request.dart';
import '../../../domain/models/requests/auth_request.dart';
import '../../../domain/models/requests/delete_vdp_member_request.dart';
import '../../../domain/models/requests/update_vdp_committee_request.dart';
import '../../../domain/models/requests/update_vdp_member_request.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';

class VdpMemberCubit extends BaseCubit<VdpMemberState, LoginResponse> {
  final ApiRepository _apiRepository;

  VdpMemberCubit(this._apiRepository)
      : super(const VdpMemberLoadingState(), LoginResponse());

  Future<void> getAllVdpMember() async {
    if (isBusy) return;

    await run(() async {
      emit(const VdpMemberLoadingState());

      final response = await _apiRepository.getAllVdpMember();
      if (response is DataSuccess) {
        emit(VdpMemberSuccessState(getAllVdpMemberResponse: response.data));
      } else if (response is DataFailed) {
        emit(VdpMemberErrorState(error: response.error));
      }
    });
  }

  //addVdpMember
  Future<void> addVdpMember(
      {
        int? vdpCommitteeId,
        int? vdpRoleId,
        String? name,
        String? mobileNumber,
        String? emailId,
        bool? status,
      }
      ) async {
    if (isBusy) return;

    await run(() async {
      emit(const AddVdpMemberLoadingState());
      final request = AddVdpMemberRequest(
          vdpCommitteeId:       vdpCommitteeId,
          vdpRoleId:       vdpRoleId,
          name:          name,
          mobileNumber:       mobileNumber,
          emailId :     emailId,
          status :     status
      );
      final response = await _apiRepository.addVdpMember(request: request);
      if (response is DataSuccess) {
        emit(AddVdpMemberSuccessState(addVdpMemberResponse: response.data));
      } else if (response is DataFailed) {
        emit(AddVdpMemberErrorState(error: response.error));
      }
    });
  }


  //updateVdpMember
  Future<void> updateVdpMember(
      {
        int? vdpMemberId,
        int? vdpCommitteeId,
        int? vdpRoleId,
        String? name,
        String? mobileNumber,
        String? emailId,
        bool? status,
      }
      ) async {
    if (isBusy) return;

    await run(() async {
      emit(const UpdateVdpMemberLoadingState());
      final request = UpdateVdpMemberRequest(
        vdpMemberId: vdpMemberId,
          vdpCommitteeId:       vdpCommitteeId,
          vdpRoleId:       vdpRoleId,
          name:          name,
          mobileNumber:       mobileNumber,
          emailId :     emailId,
          status :     status
      );
      final response = await _apiRepository.updateVdpMember(request: request);
      if (response is DataSuccess) {
        emit(UpdateVdpMemberSuccessState(updateVdpMemberResponse: response.data));
      } else if (response is DataFailed) {
        emit(UpdateVdpMemberErrorState(error: response.error));
      }
    });
  }
//deleteVdpMember

  Future<void> deleteVdpMember(
      {
        int? memberId,
      }
      ) async {
    if (isBusy) return;

    await run(() async {
      emit(const DeleteVdpMemberLoadingState());
      final request = DeleteVdpMemberRequest(
        memberId: memberId,

      );
      final response = await _apiRepository.deleteVdpMember(request: request);
      if (response is DataSuccess) {
        emit(DeleteVdpMemberSuccessState(deleteVdpMemberResponse: response.data));
      } else if (response is DataFailed) {
        emit(DeleteVdpMemberErrorState(error: response.error));
      }
    });
  }




  Future<void> getVdpMemberRoles() async {
    if (isBusy) return;

    await run(() async {
      emit(const GetVdpMemberRolesLoadingState());

      final response = await _apiRepository.getAllVdpRoles();
      if (response is DataSuccess) {
        emit(GetVdpMemberRolesSuccessState(getAllVdpRolesResponse: response.data));
      } else if (response is DataFailed) {
        emit(GetVdpMemberRolesErrorState(error: response.error));
      }
    });
  }




}
