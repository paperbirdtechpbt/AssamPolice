import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/retrofit.dart' as rf;

import '../../../domain/models/data/send_message.dart';
import '../../../domain/models/responses/add_vdp_committee_response.dart';
import '../../../domain/models/responses/add_vdp_member.dart';
import '../../../domain/models/responses/delete_vdp_committee_response.dart';
import '../../../domain/models/responses/delete_vdp_member_response.dart';
import '../../../domain/models/responses/geo_address_response.dart';
import '../../../domain/models/responses/get_all_vdp_committee_response.dart';
import '../../../domain/models/responses/get_all_vdp_member_response.dart';
import '../../../domain/models/responses/get_all_vdp_roles_response.dart';
import '../../../domain/models/responses/get_category_response.dart';
import '../../../domain/models/responses/get_city_response.dart';
import '../../../domain/models/responses/get_district_response.dart';
import '../../../domain/models/responses/get_message_body_response.dart';
import '../../../domain/models/responses/get_received_messages_response.dart';
import '../../../domain/models/responses/get_received_messages_with_parent_details.dart';
import '../../../domain/models/responses/get_sent_message_response.dart';
import '../../../domain/models/responses/get_sent_messages_with_parent_details_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/models/responses/send_message_response.dart';
import '../../../domain/models/responses/update_vdp_committee_response.dart';
import '../../../domain/models/responses/update_vdp_member.dart';
import '../../../utils/constants/strings.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('customer/auth/send-otp')
  Future<HttpResponse<GetCityResponse>> sendOtp({
    @Field("mobile_number") String? mobile,
  });

  @POST('DistrictPoliceStationDetailsGet')
  Future<HttpResponse<GetDistrictResponse>> getDistrict({
    @Query("PageName") String? createdBy,
  });

  @POST('DistrictPoliceStationDetailsGet')
  Future<HttpResponse<GetDistrictResponse>> getPoliceStation({
    @Query("Id") int? id,
    @Query("PageName") String? createdBy,
  });

  @POST('CategoryGet?')
  Future<HttpResponse<GetCategoryResponse>> getCategory({
    @Query("PoliceStationId") int? id,
  });

  @POST('GeoLocationGet?')
  Future<HttpResponse<GetGeoAddressResponse>> getGeoAddress(
      {@Query("CategoryId") int? id,
      @Query("RequestType") int? requestType,
      @Query("PoliceStationId") int? PoliceStationId});

  @POST('UsersDetailsGet?')
  Future<HttpResponse<LoginResponse>> doLogin({
    @Query("UserName") String? userName,
    @Query("Password") String? password,
  });

  @POST('GeoTaggingSave')
  @rf.Headers(<String, dynamic>{
    "Content-Type": "application/json",
    'Accept': 'application/json',
  })
  Future<HttpResponse<GetGeoAddressResponse>> addGeoLocation({
    @Field("Id") int? id,
    @Field("LocationId") int? locationId,
    @Field("LocationImage") String? locationImage,
    @Field("Latitude") String? latitude,
    @Field("Longitude") String? longitude,
    @Field("Status") String? status,
    @Field("createdBy") String? createdBy,
  });
  @POST('IncidentReportSave')
  @rf.Headers(<String, dynamic>{
    "Content-Type": "application/json",
    'Accept': 'application/json',
  })
  Future<HttpResponse<GetGeoAddressResponse>> incidenceReport({
    @Field("incidentImage") String? incidentImage,
    @Field("latitude") String? latitude,
    @Field("longitude") String? longitude,
    @Field("description") String? description,
    @Field("createdBy") String? createdBy,
  });

  @POST('SendMessage')
  Future<HttpResponse<SendMessageResponse>> sendMessage({
    @Field("SenderUserName") String? senderUserName,
    @Field("ToRecipients") List<String>? toRecipients,
    @Field("CCRecipients") List<String>? cCRecipients,
    @Field("MessagSubject") String? messagSubject,
    @Field("MessagBody") String? messagBody,
    @Field("ParentMessagesId") int? parentMessagesId,
  });
  @POST('GetReceivedMessages')
  Future<HttpResponse<GetReceivedMessagesResponse>> getReceivedMessages({
    @Field("UserName") String? userName,
    @Field("StartIndex") int? startIndex,
    @Field("NumberofMessage") int? numberofMessage,
  });

  @POST('GetSentMessages')
  Future<HttpResponse<GetSentMessagesResponse>> getSentMessages({
    @Field("UserName") String? userName,
    @Field("StartIndex") int? startIndex,
    @Field("NumberofMessage") int? numberofMessage,
  });

  @POST('GetReceivedMessagesWithParentDetails')
  Future<HttpResponse<GetReceivedMessagesWithParentDetailsResponse>>
      getReceivedMessagesWithParentDetails({
    @Field("UserName") String? userName,
    @Field("StartIndex") int? startIndex,
    @Field("NumberofMessage") int? numberofMessage,
  });

  @POST('GetSentMessagesWithParentDetails')
  Future<HttpResponse<GetSentMessagesWithParentDetailsResponse>>
      getSentMessagesWithParentDetails({
    @Field("UserName") String? userName,
    @Field("StartIndex") int? startIndex,
    @Field("NumberofMessage") int? numberofMessage,
  });

  @POST('GetMessageBody')
  Future<HttpResponse<GetMessageBodyResponse>> getMessageBody({
    @Field("MessageId") int? messageId,
    @Field("UserName") String? userName,
  });

  //VdpCommittee

  @GET('VDPCommittee/GetAllVDPCommittee')
  Future<HttpResponse<GetAllVDPCommitteeResponse>> getAllVdpCommittee();

  @POST('VDPCommittee/AddVDPCommittee')
  Future<HttpResponse<AddVdpCommitteeResponse>> addVdpCommittee({
    @Query("VDPName") String? vdpName,
    @Query("Latitude") String? latitude,
    @Query("Longitude") String? longitude,
    @Query("PoliceStation") String? policeStation,
    @Query("District") String? district,
    @Query("Status") String? status,
  });

  @DELETE('VDPCommittee/DeleteVDPCommittee')
  Future<HttpResponse<DeleteVdpCommitteeResponse>> deleteVdpCommittee({
    @Query("id") int? VdpId,
  });
  @POST('VDPCommittee/UpdateVDPCommittee')
  Future<HttpResponse<UpdateVdpCommitteeResponse>> updateVdpCommittee({
    @Query("VDPId") int? vdpId,
    @Query("VDPName") String? vdpName,
    @Query("Latitude") String? latitude,
    @Query("Longitude") String? longitude,
    @Query("PoliceStation") String? policeStation,
    @Query("District") String? district,
    @Query("Status") String? status,
  });

  //VDPMember/

  @GET('VDPMember/GetAllVDPRoles')
  Future<HttpResponse<GetAllVdpRolesResponse>> getAllVdpRoles();


  @GET('VDPMember/GetAllVDPMember')
  Future<HttpResponse<GetAllVdpMemberResponse>> getAllVdpMember();

  @POST('VDPMember/AddVDPMember')
  Future<HttpResponse<AddVdpMemberResponse>> addVdpMember({
    @Query("VDPCommitteeId") int? vdpCommitteeId,
    @Query("VDPRoleId") int? vdpRoleId,
    @Query("Name") String? name,
    @Query("MobileNumber") String? mobileNumber,
    @Query("EmailId") String? emailId,
    @Query("Status") bool? status,
  });

  @POST('VDPMember/UpdateVDPMember')
  Future<HttpResponse<UpdateVdpMemberResponse>> updateVdpMember({
    @Query("VDPMemberId") int? vdpMemberId,
    @Query("VDPCommitteeId") int? vdpCommitteeId,
    @Query("VDPRoleId") int? vdpRoleId,
    @Query("Name") String? name,
    @Query("MobileNumber") String? mobileNumber,
    @Query("EmailId") String? emailId,
    @Query("Status") bool? status,
  });

  @POST('VDPMember/DeleteVDPMember')
  Future<HttpResponse<DeleteVdpMemberResponse>> deleteVdpMember({
    @Query("id") int? VdpMemberId,
  });

}
