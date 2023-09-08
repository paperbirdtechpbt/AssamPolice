import 'package:dio/dio.dart';

import '../../../domain/models/responses/add_vdp_committee_response.dart';
import '../../../domain/models/responses/get_all_vdp_committee_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/models/responses/update_vdp_committee_response.dart';

abstract class VdpCommitteeState {
  final GetAllVDPCommitteeResponse? getAllVDPCommitteeResponse;
  final AddVdpCommitteeResponse? addVdpCommitteeResponse;
  final UpdateVdpCommitteeResponse? updateVdpCommitteeResponse;
  final DioError? error;

  const VdpCommitteeState({
    this.getAllVDPCommitteeResponse,
    this.addVdpCommitteeResponse,
    this.updateVdpCommitteeResponse,
    this.error,
  });

  List<Object?> get props => [getAllVDPCommitteeResponse, error,addVdpCommitteeResponse,updateVdpCommitteeResponse];
}

class VdpCommitteeInitialState extends VdpCommitteeState {
  const VdpCommitteeInitialState();
}


class VdpCommitteeLoadingState extends VdpCommitteeState {
  const VdpCommitteeLoadingState();
}

class VdpCommitteeSuccessState extends VdpCommitteeState {
  const VdpCommitteeSuccessState({super.getAllVDPCommitteeResponse});
}

class VdpCommitteeErrorState extends VdpCommitteeState {
  const VdpCommitteeErrorState({super.error});

}

//addVdpCommittee

class AddVdpCommitteeInitialState extends VdpCommitteeState {
  const AddVdpCommitteeInitialState();
}


class AddVdpCommitteeLoadingState extends VdpCommitteeState {
  const AddVdpCommitteeLoadingState();
}

class AddVdpCommitteeSuccessState extends VdpCommitteeState {
  const AddVdpCommitteeSuccessState({super.addVdpCommitteeResponse});
}

class AddVdpCommitteeErrorState extends VdpCommitteeState {
  const AddVdpCommitteeErrorState({super.error});
}

//updatevdpcommitee

class UpdateVdpCommitteeInitialState extends VdpCommitteeState {
  const UpdateVdpCommitteeInitialState();
}


class UpdateVdpCommitteeLoadingState extends VdpCommitteeState {
  const UpdateVdpCommitteeLoadingState();
}

class UpdateVdpCommitteeSuccessState extends VdpCommitteeState {
  const UpdateVdpCommitteeSuccessState({super.updateVdpCommitteeResponse});
}

class UpdateVdpCommitteeErrorState extends VdpCommitteeState {
  const UpdateVdpCommitteeErrorState({super.error});
}