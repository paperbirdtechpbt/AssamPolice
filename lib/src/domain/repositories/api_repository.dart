import '../../utils/resources/data_state.dart';
import '../models/data/send_message.dart';
import '../models/requests/add_geo_location_request.dart';
import '../models/requests/add_vdp_committee_request.dart';
import '../models/requests/add_vdp_member_request.dart';
import '../models/requests/auth_request.dart';
import '../models/requests/delete_vdp_member_request.dart';
import '../models/requests/delete_vdp_request.dart';
import '../models/requests/get_all_vdp_committee_request.dart';
import '../models/requests/get_all_vdp_member_request.dart';
import '../models/requests/get_body_message.dart';
import '../models/requests/get_district_police_station_request.dart';
import '../models/requests/get_receive_message_request.dart';
import '../models/requests/get_received_messages_with_parent_details_request.dart';
import '../models/requests/get_sent_message.dart';
import '../models/requests/get_sent_messages_with_parent_details_request.dart';
import '../models/requests/get_user_list_tocc_request.dart';
import '../models/requests/get_user_menu_option_request.dart';
import '../models/requests/incidence_report_request.dart';
import '../models/requests/police_station_request.dart';
import '../models/requests/send_message_request.dart';
import '../models/requests/update_vdp_committee_request.dart';
import '../models/requests/update_vdp_member_request.dart';
import '../models/responses/add_vdp_committee_response.dart';
import '../models/responses/add_vdp_member.dart';
import '../models/responses/delete_vdp_committee_response.dart';
import '../models/responses/delete_vdp_member_response.dart';
import '../models/responses/geo_address_response.dart';
import '../models/responses/get_all_vdp_committee_response.dart';
import '../models/responses/get_all_vdp_member_response.dart';
import '../models/responses/get_all_vdp_roles_response.dart';
import '../models/responses/get_category_response.dart';
import '../models/responses/get_district_response.dart';
import '../models/responses/get_message_body_response.dart';
import '../models/responses/get_received_messages_response.dart';
import '../models/responses/get_received_messages_with_parent_details.dart';
import '../models/responses/get_sent_message_response.dart';
import '../models/responses/get_sent_messages_with_parent_details_response.dart';
import '../models/responses/get_user_list_tocc_response.dart';
import '../models/responses/get_user_menu_option_response.dart';
import '../models/responses/login_response.dart';
import '../models/responses/send_message_response.dart';
import '../models/responses/update_vdp_committee_response.dart';
import '../models/responses/update_vdp_member.dart';

abstract class ApiRepository {
  Future<DataState<LoginResponse>> doLogin({
    required AuthRequest request,
  });

  Future<DataState<GetDistrictResponse>> getDistrict({
    required GetDistrictPoliceStationRequest request,
  });

  Future<DataState<GetDistrictResponse>> getPoliceStation({
    required GetDistrictPoliceStationRequest request,
  });

  Future<DataState<GetCategoryResponse>> getCategory({
    required PoliceStationRequest request,
  });

  Future<DataState<GetGeoAddressResponse>> getGeoAddress({
    required PoliceStationRequest request,
  });

  Future<DataState<GetGeoAddressResponse>> addGeoLocation({
    required AddGeoLocationRequest request,
  });

  Future<DataState<GetGeoAddressResponse>> incidenceReport({
    required IncidenceReportRequest request,
  });

  Future<DataState<SendMessageResponse>> sendMessage({
    required SendMessageRequest request,
  });

  Future<DataState<GetReceivedMessagesResponse>> getReceivedMessages({
    required GetReceivedMessagesRequest request,
  });

  Future<DataState<GetSentMessagesResponse>> getSentMessages({
    required GetSentMessagesRequest request,
  });
  Future<DataState<GetReceivedMessagesWithParentDetailsResponse>>
      getReceivedMessagesWithParentDetails({
    required GetReceivedMessagesWithParentDetailsRequest request,
  });
  Future<DataState<GetSentMessagesWithParentDetailsResponse>>
      getSentMessagesWithParentDetails({
    required GetSentMessagesWithParentDetailsRequest request,
  });

  Future<DataState<GetMessageBodyResponse>> getMessageBody({
    required GetMessageBodyRequest request,
  });

// vdpCommittee


  Future<DataState<GetAllVDPCommitteeResponse>> getAllVdpCommittee({
    required GetAllVdpCommitteeRequest request,
});

  Future<DataState<AddVdpCommitteeResponse>> addVdpCommittee({
    required AddVdpCommitteeRequest request,
  });
  Future<DataState<UpdateVdpCommitteeResponse>> updateVdpCommittee({
    required UpdateVdpCommitteeRequest request,
  });

  Future<DataState<DeleteVdpCommitteeResponse>> deleteVdpCommittee({
    required DeleteVdpCommitteeRequest request,
  });


  //vdpMember
  //response set pending

  Future<DataState<GetAllVdpMemberResponse>> getAllVdpMember({
    required GetAllVdpMemberRequest request,
});


  Future<DataState<GetAllVdpRolesResponse>> getAllVdpRoles();


  Future<DataState<AddVdpMemberResponse>> addVdpMember({
    required AddVdpMemberRequest request,
  });

  Future<DataState<UpdateVdpMemberResponse>> updateVdpMember({
    required UpdateVdpMemberRequest request,
  });

    Future<DataState<DeleteVdpMemberResponse>> deleteVdpMember({
    required DeleteVdpMemberRequest request,
  });

    Future<DataState<GetUserMenuOptionResponse>> getUserMenuOption({
    required GetUserMenuOptionRequest request,
  });


    Future<DataState<GetUserListTOCCResponse>> getUserListTOCC({
    required GetUserListTOCCRequest request,
  });


}
