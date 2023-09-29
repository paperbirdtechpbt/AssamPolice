import '../../domain/models/data/send_message.dart';
import '../../domain/models/requests/add_geo_location_request.dart';
import '../../domain/models/requests/add_vdp_committee_request.dart';
import '../../domain/models/requests/add_vdp_member_request.dart';
import '../../domain/models/requests/auth_request.dart';
import '../../domain/models/requests/delete_vdp_member_request.dart';
import '../../domain/models/requests/delete_vdp_request.dart';
import '../../domain/models/requests/get_all_vdp_committee_request.dart';
import '../../domain/models/requests/get_all_vdp_member_request.dart';
import '../../domain/models/requests/get_body_message.dart';
import '../../domain/models/requests/get_district_police_station_request.dart';
import '../../domain/models/requests/get_message_by_parent_id_request.dart';
import '../../domain/models/requests/get_receive_message_request.dart';
import '../../domain/models/requests/get_received_messages_with_parent_details_request.dart';
import '../../domain/models/requests/get_sent_message.dart';
import '../../domain/models/requests/get_sent_messages_with_parent_details_request.dart';
import '../../domain/models/requests/get_user_list_tocc_request.dart';
import '../../domain/models/requests/get_user_menu_option_request.dart';
import '../../domain/models/requests/incidence_report_request.dart';
import '../../domain/models/requests/police_station_request.dart';
import '../../domain/models/requests/send_message_request.dart';
import '../../domain/models/requests/update_vdp_committee_request.dart';
import '../../domain/models/requests/update_vdp_member_request.dart';
import '../../domain/models/responses/add_vdp_committee_response.dart';
import '../../domain/models/responses/add_vdp_member.dart';
import '../../domain/models/responses/delete_vdp_committee_response.dart';
import '../../domain/models/responses/delete_vdp_member_response.dart';
import '../../domain/models/responses/geo_address_response.dart';
import '../../domain/models/responses/get_all_vdp_committee_response.dart';
import '../../domain/models/responses/get_all_vdp_member_response.dart';
import '../../domain/models/responses/get_all_vdp_roles_response.dart';
import '../../domain/models/responses/get_category_response.dart';
import '../../domain/models/responses/get_district_response.dart';
import '../../domain/models/responses/get_message_body_response.dart';
import '../../domain/models/responses/get_message_by_parent_id_response.dart';
import '../../domain/models/responses/get_received_messages_response.dart';
import '../../domain/models/responses/get_received_messages_with_parent_details.dart';
import '../../domain/models/responses/get_sent_message_response.dart';
import '../../domain/models/responses/get_sent_messages_with_parent_details_response.dart';
import '../../domain/models/responses/get_user_list_tocc_response.dart';
import '../../domain/models/responses/get_user_menu_option_response.dart';
import '../../domain/models/responses/login_response.dart';
import '../../domain/models/responses/send_message_response.dart';
import '../../domain/models/responses/update_vdp_committee_response.dart';
import '../../domain/models/responses/update_vdp_member.dart';
import '../../domain/repositories/api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/api_service.dart';
import 'base/base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ApiService _ApiService;

  ApiRepositoryImpl(this._ApiService);

  @override
  Future<DataState<LoginResponse>> doLogin({
    required AuthRequest request,
  }) {
    return getStateOf<LoginResponse>(
      request: () => _ApiService.doLogin(
          userName: request.userName, password: request.password),
    );
  }

  // @override
  // Future<DataState<GetDistrictResponse>> getDistrict() {
  //   return getStateOf<GetDistrictResponse>(
  //     request: () => _ApiService.getDistrict(),
  //   );
  // }

  @override
  Future<DataState<GetDistrictResponse>> getDistrict({
    required GetDistrictPoliceStationRequest request,
  }) {
    return getStateOf<GetDistrictResponse>(
      request: () => _ApiService.getDistrict(createdBy: request.createdBy),
    );
  }

  @override
  Future<DataState<GetDistrictResponse>> getPoliceStation({
    required GetDistrictPoliceStationRequest request,
  }) {
    return getStateOf<GetDistrictResponse>(
      request: () => _ApiService.getPoliceStation(
          id: request.id, createdBy: request.createdBy),
    );
  }

  @override
  Future<DataState<GetCategoryResponse>> getCategory(
      {required PoliceStationRequest request}) {
    return getStateOf<GetCategoryResponse>(
      request: () => _ApiService.getCategory(id: request.id),
    );
  }

  @override
  Future<DataState<GetGeoAddressResponse>> getGeoAddress(
      {required PoliceStationRequest request}) {
    return getStateOf<GetGeoAddressResponse>(
      request: () => _ApiService.getGeoAddress(
          id: request.id,
          requestType: request.requestType,
          PoliceStationId: request.policeStationID),
    );
  }

  @override
  Future<DataState<GetGeoAddressResponse>> addGeoLocation(
      {required AddGeoLocationRequest request}) {
    return getStateOf<GetGeoAddressResponse>(
      request: () => _ApiService.addGeoLocation(
          id: request.id,
          locationId: request.locationId,
          latitude: request.latitude,
          longitude: request.longitude,
          status: request.status,
          createdBy: request.createdBy,
          locationImage: request.locationImage),
    );
  }

  @override
  Future<DataState<GetGeoAddressResponse>> incidenceReport(
      {required IncidenceReportRequest request}) {
    return getStateOf<GetGeoAddressResponse>(
      request: () => _ApiService.incidenceReport(
          latitude: request.latitude,
          longitude: request.longitude,
          createdBy: request.createdBy,
          incidentImage: request.locationImage,
          description: request.description),
    );
  }

  @override
  Future<DataState<GetMessageBodyResponse>> getMessageBody(
      {required GetMessageBodyRequest request}) {
    return getStateOf<GetMessageBodyResponse>(
      request: () => _ApiService.getMessageBody(
          userName: request.userName, messageId: request.messageId),
    );
  }

  @override
  Future<DataState<GetReceivedMessagesResponse>> getReceivedMessages(
      {required GetReceivedMessagesRequest request}) {
    return getStateOf<GetReceivedMessagesResponse>(
      request: () => _ApiService.getReceivedMessages(
          userName: request.userName,
          startIndex: request.startIndex,
          numberofMessage: request.numberofMessage),
    );
  }

  @override
  Future<DataState<GetSentMessagesResponse>> getSentMessages(
      {required GetSentMessagesRequest request}) {
    return getStateOf<GetSentMessagesResponse>(
      request: () => _ApiService.getSentMessages(
          userName: request.userName,
          startIndex: request.startIndex,
          numberofMessage: request.numberofMessage),
    );
  }

  @override
  Future<DataState<GetReceivedMessagesWithParentDetailsResponse>>
      getReceivedMessagesWithParentDetails(
          {required GetReceivedMessagesWithParentDetailsRequest request}) {
    return getStateOf<GetReceivedMessagesWithParentDetailsResponse>(
      request: () => _ApiService.getReceivedMessagesWithParentDetails(
          userName: request.userName,
          startIndex: request.startIndex,
          numberofMessage: request.numberofMessage),
    );
  }

  @override
  Future<DataState<GetSentMessagesWithParentDetailsResponse>>
      getSentMessagesWithParentDetails(
          {required GetSentMessagesWithParentDetailsRequest request}) {
    return getStateOf<GetSentMessagesWithParentDetailsResponse>(
      request: () => _ApiService.getSentMessagesWithParentDetails(
          userName: request.userName,
          startIndex: request.startIndex,
          numberofMessage: request.numberofMessage),
    );
  }

  @override
  Future<DataState<SendMessageResponse>> sendMessage(
      {required SendMessageRequest request}) {
    return getStateOf<SendMessageResponse>(
      request: () => _ApiService.sendMessage(
          senderUserName: request.senderUserName,
          toRecipients: request.toRecipients,
          cCRecipients: request.cCRecipients,
          messagSubject: request.messagSubject,
          messagBody: request.messagBody,
          parentMessagesId: request.parentMessagesId),
    );
  }

  //  VdpCommittee


  @override
  Future<DataState<AddVdpCommitteeResponse>> addVdpCommittee(
      {required AddVdpCommitteeRequest request}) {
    return getStateOf<AddVdpCommitteeResponse>(
      request: () => _ApiService.addVdpCommittee(
          vdpName: request.vdpName,
          latitude: request.latitude,
          longitude: request.longitude,
          policeStationId: request.policeStationId,
          status: request.status,
          districtId: request.districtId,createdBy: request.createdBy),
    );
  }

  @override
  Future<DataState<UpdateVdpCommitteeResponse>> updateVdpCommittee({required UpdateVdpCommitteeRequest request}) {
    return getStateOf<UpdateVdpCommitteeResponse>(
      request: () => _ApiService.updateVdpCommittee(
vdpId: request.vdpId,
          vdpName: request.vdpName,
          latitude: request.latitude,
          longitude: request.longitude,
          policeStationId: request.policeStationId,
          status: request.status,
          districtId: request.districtId,createdBy: request.createdBy),
    );
  }


//  VdpMember

  @override
  Future<DataState<AddVdpMemberResponse>> addVdpMember({required AddVdpMemberRequest request}) {
    return getStateOf<AddVdpMemberResponse>(
      request: () => _ApiService.addVdpMember(
          vdpCommitteeId:       request.vdpCommitteeId,
          vdpRoleId:       request.vdpRoleId,
          name:          request.name,
          mobileNumber:       request.mobileNumber,
          emailId :     request.emailId,
          status :     request.status,
        createdBy: request.createdBy,),
    );

  }



  @override
  Future<DataState<GetAllVdpRolesResponse>> getAllVdpRoles() {
    return getStateOf<GetAllVdpRolesResponse>(
      request: () => _ApiService.getAllVdpRoles(),
    );
  }

  @override
  Future<DataState<UpdateVdpMemberResponse>> updateVdpMember({required UpdateVdpMemberRequest request}) {
    return getStateOf<UpdateVdpMemberResponse>(
      request: () => _ApiService.updateVdpMember(
        vdpMemberId: request.vdpMemberId,
          vdpCommitteeId:       request.vdpCommitteeId,
          vdpRoleId:       request.vdpRoleId,
          name:          request.name,
          mobileNumber:       request.mobileNumber,
          emailId :     request.emailId,
          status :     request.status,
        createdBy: request.createdBy,

      ),
    );

  }



  @override
  Future<DataState<DeleteVdpCommitteeResponse>> deleteVdpCommittee({required DeleteVdpCommitteeRequest request}) {
    return getStateOf<DeleteVdpCommitteeResponse>(
      request: () => _ApiService.deleteVdpCommittee(
          VdpId: request.id
      ),
    );
  }

  @override
  Future<DataState<DeleteVdpMemberResponse>> deleteVdpMember({required DeleteVdpMemberRequest request}) {
    return getStateOf<DeleteVdpMemberResponse>(
      request: () => _ApiService.deleteVdpMember(
          VdpMemberId: request.memberId
      ),
    );
  }

  @override
  Future<DataState<GetAllVDPCommitteeResponse>> getAllVdpCommittee({required GetAllVdpCommitteeRequest request}) {
    return getStateOf<GetAllVDPCommitteeResponse>(
      request: () => _ApiService.getAllVdpCommittee(
          districtId:  request.districtId,
        policeStationId: request.policeStation
      ),
    );
  }

  @override
  Future<DataState<GetAllVdpMemberResponse>> getAllVdpMember({required GetAllVdpMemberRequest request}) {
    return getStateOf<GetAllVdpMemberResponse>(
      request: () => _ApiService.getAllVdpMember(
        vdpCommitteeId:  request.vdpCommitteeId,
      ),
    );
  }

  @override
  Future<DataState<GetUserListTOCCResponse>> getUserListTOCC({required GetUserListTOCCRequest request}) {
    return getStateOf<GetUserListTOCCResponse>(
      request: () => _ApiService.getUserListTOCC(
        userName: request.userName,
        transactionMode: request.transactionMode,
        senderType: request.senderType,
      ),
    );
  }


  @override
  Future<DataState<GetUserMenuOptionResponse>> getUserMenuOption({required GetUserMenuOptionRequest request}) {
    return getStateOf<GetUserMenuOptionResponse>(
      request: () => _ApiService.getUserMenuOption(
        userName: request.userName,
        transactionMode: request.transactionMode,
      ),
    );
  }

  @override
  Future<DataState<GetMessageByParentIdResponse>> getMessageByParentId({required GetMessageByParentIdRequest request}) {
    return getStateOf<GetMessageByParentIdResponse>(
      request: () => _ApiService.getMessageByParentId(
        userName: request.userName,
        parentMessageId: request.parentMessageId,
      ),
    );
  }

  // @override
  // Future<DataState<AddVdpCommitteeResponse>> deleteVdp({required DeleteVdpRequest request}) {
  //   return getStateOf<AddVdpCommitteeResponse>(
  //     request: () => _ApiService.deleteVdpCommittee(),
  //   );
  // }






}
