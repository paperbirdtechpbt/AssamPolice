import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../domain/models/data/arguments.dart';
import '../../domain/models/data/get_all_vdp_committee.dart';
import '../../domain/models/data/get_message_body.dart';
import '../../domain/models/data/get_all_vdp_member.dart';
import '../../domain/models/data/get_message_body.dart';
import '../../domain/models/data/get_message_by_parent_id.dart';
import '../../domain/models/data/get_received_message.dart';
import '../../domain/models/data/get_received_messages_with_parent_details.dart';
import '../../domain/models/data/get_sent_message.dart';
import '../../domain/models/data/get_sent_messages_with_parent_details.dart';
import '../../domain/models/responses/get_all_vdp_committee_response.dart';
import '../../presentation/views/Vdp/recived_reply_message/recived_reply_message.dart';
import '../../presentation/views/Vdp/reply_message/reply_message_parent_screen.dart';
import '../../presentation/views/Vdp/reply_message/reply_message_screen.dart';
import '../../presentation/views/add_member_location/add_member.dart';
import '../../presentation/views/add_member_location/add_member_location.dart';
import '../../presentation/views/add_member_location/member_list.dart';
import '../../presentation/views/edit_members/edit_members_address.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/login/login_view.dart';
import '../../presentation/views/message/inbox.dart';
import '../../presentation/views/message/compose_message.dart';
import '../../presentation/views/message/message.dart';
import '../../presentation/views/message/sent_message.dart';
import '../../presentation/views/splash/splash_screen.dart';
import '../../presentation/views/vdp_committee/add_vdp_committee.dart';
import '../../presentation/views/vdp_committee/update_vdp_committee.dart';
import '../../presentation/views/vdp_committee/vpd_committe_view.dart';
import '../../presentation/views/vdp_members/add_vdp_member.dart';
import '../../presentation/views/vdp_members/edit_vdp_member.dart';
import '../../presentation/views/vdp_members/vdp_member_detail.dart';
import '../../presentation/views/vdp_members/vdp_members.dart';


part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: LoginView),
    AutoRoute(page: HomeView),
    AutoRoute(page: AddMemberLocation),
    AutoRoute(page: AddMemberScreen),
    AutoRoute(page: InBoxScreen),
    AutoRoute(page: ComposeMessageScreen),
    AutoRoute(page: MessageScreen),
    AutoRoute(page: MembersList),
    AutoRoute(page: EditMembersAddress),
    AutoRoute(page: SentMessageView),
    AutoRoute(page: VdpCommitteeView),
    AutoRoute(page: AddVdpCommitteeView),
    AutoRoute(page: UpdateVdpCommitteeView),
    AutoRoute(page: VdpMembersListView),
    AutoRoute(page: VdpMemberDetailView),
    AutoRoute(page: AddVdpMember),
    AutoRoute(page: EditVdpMember),
    AutoRoute(page: ReplyMessageScreen),
    AutoRoute(page: ReceivedReplyMessageScreen),
    AutoRoute(page: ReplyParentMessageScreen),
  ],
)
class AppRouter extends _$AppRouter {}

final appRouter = AppRouter();
