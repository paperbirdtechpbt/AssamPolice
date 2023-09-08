import '../../domain/models/data/send_message.dart';
import '../../domain/models/requests/add_geo_location_request.dart';
import '../../domain/models/requests/add_vdp_committee_request.dart';
import '../../domain/models/requests/add_vdp_member_request.dart';
import '../../domain/models/requests/auth_request.dart';
import '../../domain/models/requests/get_body_message.dart';
import '../../domain/models/requests/get_district_police_station_request.dart';
import '../../domain/models/requests/get_receive_message_request.dart';
import '../../domain/models/requests/get_received_messages_with_parent_details_request.dart';
import '../../domain/models/requests/get_sent_message.dart';
import '../../domain/models/requests/get_sent_messages_with_parent_details_request.dart';
import '../../domain/models/requests/incidence_report_request.dart';
import '../../domain/models/requests/police_station_request.dart';
import '../../domain/models/requests/send_message_request.dart';
import '../../domain/models/requests/update_vdp_committee_request.dart';
import '../../domain/models/requests/update_vdp_member_request.dart';
import '../../domain/models/responses/add_vdp_committee_response.dart';
import '../../domain/models/responses/add_vdp_member.dart';
import '../../domain/models/responses/geo_address_response.dart';
import '../../domain/models/responses/get_all_vdp_committee_response.dart';
import '../../domain/models/responses/get_all_vdp_member_response.dart';
import '../../domain/models/responses/get_all_vdp_roles_response.dart';
import '../../domain/models/responses/get_category_response.dart';
import '../../domain/models/responses/get_district_response.dart';
import '../../domain/models/responses/get_message_body_response.dart';
import '../../domain/models/responses/get_received_messages_response.dart';
import '../../domain/models/responses/get_received_messages_with_parent_details.dart';
import '../../domain/models/responses/get_sent_message_response.dart';
import '../../domain/models/responses/get_sent_messages_with_parent_details_response.dart';
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
  Future<DataState<GetAllVDPCommitteeResponse>> getAllVdpCommittee() {
    return getStateOf<GetAllVDPCommitteeResponse>(
      request: () => _ApiService.getAllVdpCommittee(),
    );
  }

  @override
  Future<DataState<AddVdpCommitteeResponse>> addVdpCommittee(
      {required AddVdpCommitteeRequest request}) {
    return getStateOf<AddVdpCommitteeResponse>(
      request: () => _ApiService.addVdpCommittee(
          vdpName: request.vdpName,
          latitude: request.latitude,
          longitude: request.longitude,
          policeStation: request.policeStation,
          status: request.status,
          district: request.district),
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
          policeStation: request.policeStation,
          status: request.status,
          district: request.district),
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
          status :     request.status),
    );

  }

  @override
  Future<DataState<GetAllVdpMemberResponse>> getAllVdpMember() {
    return getStateOf<GetAllVdpMemberResponse>(
      request: () => _ApiService.getAllVdpMember(),
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
          status :     request.status),
    );

  }






}
