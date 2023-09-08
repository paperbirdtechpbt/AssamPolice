import 'package:dio/dio.dart';

import '../../../domain/models/responses/add_vdp_committee_response.dart';
import '../../../domain/models/responses/add_vdp_member.dart';
import '../../../domain/models/responses/delete_vdp_member_response.dart';
import '../../../domain/models/responses/get_all_vdp_committee_response.dart';
import '../../../domain/models/responses/get_all_vdp_member_response.dart';
import '../../../domain/models/responses/get_all_vdp_roles_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/models/responses/update_vdp_committee_response.dart';
import '../../../domain/models/responses/update_vdp_member.dart';

abstract class VdpMemberState {
  final GetAllVdpMemberResponse? getAllVdpMemberResponse;
  final AddVdpMemberResponse? addVdpMemberResponse;
  final UpdateVdpMemberResponse? updateVdpMemberResponse;
  final GetAllVdpRolesResponse? getAllVdpRolesResponse;
  final DeleteVdpMemberResponse? deleteVdpMemberResponse;

  final DioError? error;

  const VdpMemberState({
    this.getAllVdpMemberResponse,
    this.updateVdpMemberResponse,
    this.addVdpMemberResponse,
    this.getAllVdpRolesResponse,
    this.deleteVdpMemberResponse,
    this.error,
  });

  List<Object?> get props => [
    error,
  getAllVdpMemberResponse,
   updateVdpMemberResponse,
addVdpMemberResponse,
   getAllVdpRolesResponse,
    deleteVdpMemberResponse,

  ];
}

class VdpMemberInitialState extends VdpMemberState {
  const VdpMemberInitialState();
}


class VdpMemberLoadingState extends VdpMemberState {
  const VdpMemberLoadingState();
}

class VdpMemberSuccessState extends VdpMemberState {
  const VdpMemberSuccessState({super.getAllVdpMemberResponse});
}

class VdpMemberErrorState extends VdpMemberState {
  const VdpMemberErrorState({super.error});

}

//addVdpMember

class AddVdpMemberInitialState extends VdpMemberState {
  const AddVdpMemberInitialState();
}


class AddVdpMemberLoadingState extends VdpMemberState {
  const AddVdpMemberLoadingState();
}

class AddVdpMemberSuccessState extends VdpMemberState {
  const AddVdpMemberSuccessState({super.addVdpMemberResponse});
}

class AddVdpMemberErrorState extends VdpMemberState {
  const AddVdpMemberErrorState({super.error});
}

//updateVdpMember

class UpdateVdpMemberInitialState extends VdpMemberState {
  const UpdateVdpMemberInitialState();
}


class UpdateVdpMemberLoadingState extends VdpMemberState {
  const UpdateVdpMemberLoadingState();
}

class UpdateVdpMemberSuccessState extends VdpMemberState {
  const UpdateVdpMemberSuccessState({super.updateVdpMemberResponse});
}

class UpdateVdpMemberErrorState extends VdpMemberState {
  const UpdateVdpMemberErrorState({super.error});
}
// deleteVdpMember


class DeleteVdpMemberInitialState extends VdpMemberState {
  const DeleteVdpMemberInitialState();
}


class DeleteVdpMemberLoadingState extends VdpMemberState {
  const DeleteVdpMemberLoadingState();
}

class DeleteVdpMemberSuccessState extends VdpMemberState {
  const DeleteVdpMemberSuccessState({super.deleteVdpMemberResponse});
}

class DeleteVdpMemberErrorState extends VdpMemberState {
  const DeleteVdpMemberErrorState({super.error});
}
//getAllVdpMemberRoles


class GetVdpMemberRolesInitialState extends VdpMemberState {
  const GetVdpMemberRolesInitialState();
}


class GetVdpMemberRolesLoadingState extends VdpMemberState {
  const GetVdpMemberRolesLoadingState();
}

class GetVdpMemberRolesSuccessState extends VdpMemberState {
  const GetVdpMemberRolesSuccessState({super.getAllVdpRolesResponse});
}

class GetVdpMemberRolesErrorState extends VdpMemberState {
  const GetVdpMemberRolesErrorState({super.error});
}



