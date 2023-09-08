// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    LoginViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    AddressViewRoute.name: (routeData) {
      final args = routeData.argsAs<AddressViewRouteArgs>();
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: AddressView(
          key: args.key,
          arguments: args.arguments,
        ),
      );
    },
    AddPhotoCaptureViewRoute.name: (routeData) {
      final args = routeData.argsAs<AddPhotoCaptureViewRouteArgs>();
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: AddPhotoCaptureView(
          key: args.key,
          locationId: args.locationId,
          photoId: args.photoId,
          addressLat: args.addressLat,
          addressLng: args.addressLng,
        ),
      );
    },
    GoogleMapPickLocationRoute.name: (routeData) {
      final args = routeData.argsAs<GoogleMapPickLocationRouteArgs>();
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: GoogleMapPickLocation(
          key: args.key,
          addressLat: args.addressLat,
          addressLng: args.addressLng,
        ),
      );
    },
    ViewImageRoute.name: (routeData) {
      final args = routeData.argsAs<ViewImageRouteArgs>();
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: ViewImage(
          key: args.key,
          file: args.file,
        ),
      );
    },
    IncidenceScreenRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const IncidenceScreen(),
      );
    },
    DashBoardScreenRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const DashBoardScreen(),
      );
    },
    AddMemberLocationRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const AddMemberLocation(),
      );
    },
    AddLocationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AddLocationScreenRouteArgs>(
          orElse: () => const AddLocationScreenRouteArgs());
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: AddLocationScreen(key: args.key),
      );
    },
    AddMemberScreenRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const AddMemberScreen(),
      );
    },
    InBoxScreenRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const InBoxScreen(),
      );
    },
    ComposeMessageScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ComposeMessageScreenRouteArgs>(
          orElse: () => const ComposeMessageScreenRouteArgs());
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: ComposeMessageScreen(
          key: args.key,
          getReceivedMessages: args.getReceivedMessages,
          getSentMessages: args.getSentMessages,
          isSentMessage: args.isSentMessage,
          isReply: args.isReply,
          getMessageBody: args.getMessageBody,
        ),
      );
    },
    MessageScreenRoute.name: (routeData) {
      final args = routeData.argsAs<MessageScreenRouteArgs>(
          orElse: () => const MessageScreenRouteArgs());
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: MessageScreen(
          key: args.key,
          getReceivedMessages: args.getReceivedMessages,
          getSentMessages: args.getSentMessages,
          isSentMessage: args.isSentMessage,
          isReplyed: args.isReplyed,
        ),
      );
    },
    MembersListRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const MembersList(),
      );
    },
    EditMembersAddressRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const EditMembersAddress(),
      );
    },
    SentMessageViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const SentMessageView(),
      );
    },
    VdpCommitteeViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const VdpCommitteeView(),
      );
    },
    AddVdpCommitteeViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const AddVdpCommitteeView(),
      );
    },
    UpdateVdpCommitteeViewRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateVdpCommitteeViewRouteArgs>(
          orElse: () => const UpdateVdpCommitteeViewRouteArgs());
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: UpdateVdpCommitteeView(
          key: args.key,
          getAllVDPCommittee: args.getAllVDPCommittee,
        ),
      );
    },
    VdpMembersListViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const VdpMembersListView(),
      );
    },
    VdpMemberDetailViewRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const VdpMemberDetailView(),
      );
    },
    ReplyMessageScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ReplyMessageScreenRouteArgs>(
          orElse: () => const ReplyMessageScreenRouteArgs());
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: ReplyMessageScreen(
          key: args.key,
          messageId: args.messageId,
          messageBody: args.messageBody,
        ),
      );
    },
    ReceivedReplyMessageScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ReceivedReplyMessageScreenRouteArgs>(
          orElse: () => const ReceivedReplyMessageScreenRouteArgs());
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: ReceivedReplyMessageScreen(
          key: args.key,
          messageId: args.messageId,
          messageBody: args.messageBody,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          SplashScreenRoute.name,
          path: '/',
        ),
        RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        RouteConfig(
          AddressViewRoute.name,
          path: '/address-view',
        ),
        RouteConfig(
          AddPhotoCaptureViewRoute.name,
          path: '/add-photo-capture-view',
        ),
        RouteConfig(
          GoogleMapPickLocationRoute.name,
          path: '/google-map-pick-location',
        ),
        RouteConfig(
          ViewImageRoute.name,
          path: '/view-image',
        ),
        RouteConfig(
          IncidenceScreenRoute.name,
          path: '/incidence-screen',
        ),
        RouteConfig(
          DashBoardScreenRoute.name,
          path: '/dash-board-screen',
        ),
        RouteConfig(
          AddMemberLocationRoute.name,
          path: '/add-member-location',
        ),
        RouteConfig(
          AddLocationScreenRoute.name,
          path: '/add-location-screen',
        ),
        RouteConfig(
          AddMemberScreenRoute.name,
          path: '/add-member-screen',
        ),
        RouteConfig(
          InBoxScreenRoute.name,
          path: '/in-box-screen',
        ),
        RouteConfig(
          ComposeMessageScreenRoute.name,
          path: '/compose-message-screen',
        ),
        RouteConfig(
          MessageScreenRoute.name,
          path: '/message-screen',
        ),
        RouteConfig(
          MembersListRoute.name,
          path: '/members-list',
        ),
        RouteConfig(
          EditMembersAddressRoute.name,
          path: '/edit-members-address',
        ),
        RouteConfig(
          SentMessageViewRoute.name,
          path: '/sent-message-view',
        ),
        RouteConfig(
          VdpCommitteeViewRoute.name,
          path: '/vdp-committee-view',
        ),
        RouteConfig(
          AddVdpCommitteeViewRoute.name,
          path: '/add-vdp-committee-view',
        ),
        RouteConfig(
          UpdateVdpCommitteeViewRoute.name,
          path: '/update-vdp-committee-view',
        ),
        RouteConfig(
          VdpMembersListViewRoute.name,
          path: '/vdp-members-list-view',
        ),
        RouteConfig(
          VdpMemberDetailViewRoute.name,
          path: '/vdp-member-detail-view',
        ),
        RouteConfig(
          ReplyMessageScreenRoute.name,
          path: '/reply-message-screen',
        ),
        RouteConfig(
          ReceivedReplyMessageScreenRoute.name,
          path: '/received-reply-message-screen',
        ),
      ];
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/',
        );

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [LoginView]
class LoginViewRoute extends PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginViewRoute';
}

/// generated route for
/// [HomeView]
class HomeViewRoute extends PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [AddressView]
class AddressViewRoute extends PageRouteInfo<AddressViewRouteArgs> {
  AddressViewRoute({
    Key? key,
    required Arguments arguments,
  }) : super(
          AddressViewRoute.name,
          path: '/address-view',
          args: AddressViewRouteArgs(
            key: key,
            arguments: arguments,
          ),
        );

  static const String name = 'AddressViewRoute';
}

class AddressViewRouteArgs {
  const AddressViewRouteArgs({
    this.key,
    required this.arguments,
  });

  final Key? key;

  final Arguments arguments;

  @override
  String toString() {
    return 'AddressViewRouteArgs{key: $key, arguments: $arguments}';
  }
}

/// generated route for
/// [AddPhotoCaptureView]
class AddPhotoCaptureViewRoute
    extends PageRouteInfo<AddPhotoCaptureViewRouteArgs> {
  AddPhotoCaptureViewRoute({
    Key? key,
    required int? locationId,
    required int? photoId,
    required String? addressLat,
    required String? addressLng,
  }) : super(
          AddPhotoCaptureViewRoute.name,
          path: '/add-photo-capture-view',
          args: AddPhotoCaptureViewRouteArgs(
            key: key,
            locationId: locationId,
            photoId: photoId,
            addressLat: addressLat,
            addressLng: addressLng,
          ),
        );

  static const String name = 'AddPhotoCaptureViewRoute';
}

class AddPhotoCaptureViewRouteArgs {
  const AddPhotoCaptureViewRouteArgs({
    this.key,
    required this.locationId,
    required this.photoId,
    required this.addressLat,
    required this.addressLng,
  });

  final Key? key;

  final int? locationId;

  final int? photoId;

  final String? addressLat;

  final String? addressLng;

  @override
  String toString() {
    return 'AddPhotoCaptureViewRouteArgs{key: $key, locationId: $locationId, photoId: $photoId, addressLat: $addressLat, addressLng: $addressLng}';
  }
}

/// generated route for
/// [GoogleMapPickLocation]
class GoogleMapPickLocationRoute
    extends PageRouteInfo<GoogleMapPickLocationRouteArgs> {
  GoogleMapPickLocationRoute({
    Key? key,
    required String? addressLat,
    required String? addressLng,
  }) : super(
          GoogleMapPickLocationRoute.name,
          path: '/google-map-pick-location',
          args: GoogleMapPickLocationRouteArgs(
            key: key,
            addressLat: addressLat,
            addressLng: addressLng,
          ),
        );

  static const String name = 'GoogleMapPickLocationRoute';
}

class GoogleMapPickLocationRouteArgs {
  const GoogleMapPickLocationRouteArgs({
    this.key,
    required this.addressLat,
    required this.addressLng,
  });

  final Key? key;

  final String? addressLat;

  final String? addressLng;

  @override
  String toString() {
    return 'GoogleMapPickLocationRouteArgs{key: $key, addressLat: $addressLat, addressLng: $addressLng}';
  }
}

/// generated route for
/// [ViewImage]
class ViewImageRoute extends PageRouteInfo<ViewImageRouteArgs> {
  ViewImageRoute({
    Key? key,
    required File file,
  }) : super(
          ViewImageRoute.name,
          path: '/view-image',
          args: ViewImageRouteArgs(
            key: key,
            file: file,
          ),
        );

  static const String name = 'ViewImageRoute';
}

class ViewImageRouteArgs {
  const ViewImageRouteArgs({
    this.key,
    required this.file,
  });

  final Key? key;

  final File file;

  @override
  String toString() {
    return 'ViewImageRouteArgs{key: $key, file: $file}';
  }
}

/// generated route for
/// [IncidenceScreen]
class IncidenceScreenRoute extends PageRouteInfo<void> {
  const IncidenceScreenRoute()
      : super(
          IncidenceScreenRoute.name,
          path: '/incidence-screen',
        );

  static const String name = 'IncidenceScreenRoute';
}

/// generated route for
/// [DashBoardScreen]
class DashBoardScreenRoute extends PageRouteInfo<void> {
  const DashBoardScreenRoute()
      : super(
          DashBoardScreenRoute.name,
          path: '/dash-board-screen',
        );

  static const String name = 'DashBoardScreenRoute';
}

/// generated route for
/// [AddMemberLocation]
class AddMemberLocationRoute extends PageRouteInfo<void> {
  const AddMemberLocationRoute()
      : super(
          AddMemberLocationRoute.name,
          path: '/add-member-location',
        );

  static const String name = 'AddMemberLocationRoute';
}

/// generated route for
/// [AddLocationScreen]
class AddLocationScreenRoute extends PageRouteInfo<AddLocationScreenRouteArgs> {
  AddLocationScreenRoute({Key? key})
      : super(
          AddLocationScreenRoute.name,
          path: '/add-location-screen',
          args: AddLocationScreenRouteArgs(key: key),
        );

  static const String name = 'AddLocationScreenRoute';
}

class AddLocationScreenRouteArgs {
  const AddLocationScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AddLocationScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [AddMemberScreen]
class AddMemberScreenRoute extends PageRouteInfo<void> {
  const AddMemberScreenRoute()
      : super(
          AddMemberScreenRoute.name,
          path: '/add-member-screen',
        );

  static const String name = 'AddMemberScreenRoute';
}

/// generated route for
/// [InBoxScreen]
class InBoxScreenRoute extends PageRouteInfo<void> {
  const InBoxScreenRoute()
      : super(
          InBoxScreenRoute.name,
          path: '/in-box-screen',
        );

  static const String name = 'InBoxScreenRoute';
}

/// generated route for
/// [ComposeMessageScreen]
class ComposeMessageScreenRoute
    extends PageRouteInfo<ComposeMessageScreenRouteArgs> {
  ComposeMessageScreenRoute({
    Key? key,
    GetReceivedMessages? getReceivedMessages,
    GetSentMessages? getSentMessages,
    bool? isSentMessage,
    bool? isReply,
    GetMessageBody? getMessageBody,
  }) : super(
          ComposeMessageScreenRoute.name,
          path: '/compose-message-screen',
          args: ComposeMessageScreenRouteArgs(
            key: key,
            getReceivedMessages: getReceivedMessages,
            getSentMessages: getSentMessages,
            isSentMessage: isSentMessage,
            isReply: isReply,
            getMessageBody: getMessageBody,
          ),
        );

  static const String name = 'ComposeMessageScreenRoute';
}

class ComposeMessageScreenRouteArgs {
  const ComposeMessageScreenRouteArgs({
    this.key,
    this.getReceivedMessages,
    this.getSentMessages,
    this.isSentMessage,
    this.isReply,
    this.getMessageBody,
  });

  final Key? key;

  final GetReceivedMessages? getReceivedMessages;

  final GetSentMessages? getSentMessages;

  final bool? isSentMessage;

  final bool? isReply;

  final GetMessageBody? getMessageBody;

  @override
  String toString() {
    return 'ComposeMessageScreenRouteArgs{key: $key, getReceivedMessages: $getReceivedMessages, getSentMessages: $getSentMessages, isSentMessage: $isSentMessage, isReply: $isReply, getMessageBody: $getMessageBody}';
  }
}

/// generated route for
/// [MessageScreen]
class MessageScreenRoute extends PageRouteInfo<MessageScreenRouteArgs> {
  MessageScreenRoute({
    Key? key,
    GetReceivedMessages? getReceivedMessages,
    GetSentMessages? getSentMessages,
    bool? isSentMessage,
    bool? isReplyed,
  }) : super(
          MessageScreenRoute.name,
          path: '/message-screen',
          args: MessageScreenRouteArgs(
            key: key,
            getReceivedMessages: getReceivedMessages,
            getSentMessages: getSentMessages,
            isSentMessage: isSentMessage,
            isReplyed: isReplyed,
          ),
        );

  static const String name = 'MessageScreenRoute';
}

class MessageScreenRouteArgs {
  const MessageScreenRouteArgs({
    this.key,
    this.getReceivedMessages,
    this.getSentMessages,
    this.isSentMessage,
    this.isReplyed,
  });

  final Key? key;

  final GetReceivedMessages? getReceivedMessages;

  final GetSentMessages? getSentMessages;

  final bool? isSentMessage;

  final bool? isReplyed;

  @override
  String toString() {
    return 'MessageScreenRouteArgs{key: $key, getReceivedMessages: $getReceivedMessages, getSentMessages: $getSentMessages, isSentMessage: $isSentMessage, isReplyed: $isReplyed}';
  }
}

/// generated route for
/// [MembersList]
class MembersListRoute extends PageRouteInfo<void> {
  const MembersListRoute()
      : super(
          MembersListRoute.name,
          path: '/members-list',
        );

  static const String name = 'MembersListRoute';
}

/// generated route for
/// [EditMembersAddress]
class EditMembersAddressRoute extends PageRouteInfo<void> {
  const EditMembersAddressRoute()
      : super(
          EditMembersAddressRoute.name,
          path: '/edit-members-address',
        );

  static const String name = 'EditMembersAddressRoute';
}

/// generated route for
/// [SentMessageView]
class SentMessageViewRoute extends PageRouteInfo<void> {
  const SentMessageViewRoute()
      : super(
          SentMessageViewRoute.name,
          path: '/sent-message-view',
        );

  static const String name = 'SentMessageViewRoute';
}

/// generated route for
/// [VdpCommitteeView]
class VdpCommitteeViewRoute extends PageRouteInfo<void> {
  const VdpCommitteeViewRoute()
      : super(
          VdpCommitteeViewRoute.name,
          path: '/vdp-committee-view',
        );

  static const String name = 'VdpCommitteeViewRoute';
}

/// generated route for
/// [AddVdpCommitteeView]
class AddVdpCommitteeViewRoute extends PageRouteInfo<void> {
  const AddVdpCommitteeViewRoute()
      : super(
          AddVdpCommitteeViewRoute.name,
          path: '/add-vdp-committee-view',
        );

  static const String name = 'AddVdpCommitteeViewRoute';
}

/// generated route for
/// [UpdateVdpCommitteeView]
class UpdateVdpCommitteeViewRoute
    extends PageRouteInfo<UpdateVdpCommitteeViewRouteArgs> {
  UpdateVdpCommitteeViewRoute({
    Key? key,
    GetAllVDPCommittee? getAllVDPCommittee,
  }) : super(
          UpdateVdpCommitteeViewRoute.name,
          path: '/update-vdp-committee-view',
          args: UpdateVdpCommitteeViewRouteArgs(
            key: key,
            getAllVDPCommittee: getAllVDPCommittee,
          ),
        );

  static const String name = 'UpdateVdpCommitteeViewRoute';
}

class UpdateVdpCommitteeViewRouteArgs {
  const UpdateVdpCommitteeViewRouteArgs({
    this.key,
    this.getAllVDPCommittee,
  });

  final Key? key;

  final GetAllVDPCommittee? getAllVDPCommittee;

  @override
  String toString() {
    return 'UpdateVdpCommitteeViewRouteArgs{key: $key, getAllVDPCommittee: $getAllVDPCommittee}';
  }
}

/// generated route for
/// [VdpMembersListView]
class VdpMembersListViewRoute extends PageRouteInfo<void> {
  const VdpMembersListViewRoute()
      : super(
          VdpMembersListViewRoute.name,
          path: '/vdp-members-list-view',
        );

  static const String name = 'VdpMembersListViewRoute';
}

/// generated route for
/// [VdpMemberDetailView]
class VdpMemberDetailViewRoute extends PageRouteInfo<void> {
  const VdpMemberDetailViewRoute()
      : super(
          VdpMemberDetailViewRoute.name,
          path: '/vdp-member-detail-view',
        );

  static const String name = 'VdpMemberDetailViewRoute';
}

/// generated route for
/// [ReplyMessageScreen]
class ReplyMessageScreenRoute
    extends PageRouteInfo<ReplyMessageScreenRouteArgs> {
  ReplyMessageScreenRoute({
    Key? key,
    int? messageId,
    GetReceivedMessagesWithParentDetails? messageBody,
  }) : super(
          ReplyMessageScreenRoute.name,
          path: '/reply-message-screen',
          args: ReplyMessageScreenRouteArgs(
            key: key,
            messageId: messageId,
            messageBody: messageBody,
          ),
        );

  static const String name = 'ReplyMessageScreenRoute';
}

class ReplyMessageScreenRouteArgs {
  const ReplyMessageScreenRouteArgs({
    this.key,
    this.messageId,
    this.messageBody,
  });

  final Key? key;

  final int? messageId;

  final GetReceivedMessagesWithParentDetails? messageBody;

  @override
  String toString() {
    return 'ReplyMessageScreenRouteArgs{key: $key, messageId: $messageId, messageBody: $messageBody}';
  }
}

/// generated route for
/// [ReceivedReplyMessageScreen]
class ReceivedReplyMessageScreenRoute
    extends PageRouteInfo<ReceivedReplyMessageScreenRouteArgs> {
  ReceivedReplyMessageScreenRoute({
    Key? key,
    int? messageId,
    GetSentMessagesWithParentDetails? messageBody,
  }) : super(
          ReceivedReplyMessageScreenRoute.name,
          path: '/received-reply-message-screen',
          args: ReceivedReplyMessageScreenRouteArgs(
            key: key,
            messageId: messageId,
            messageBody: messageBody,
          ),
        );

  static const String name = 'ReceivedReplyMessageScreenRoute';
}

class ReceivedReplyMessageScreenRouteArgs {
  const ReceivedReplyMessageScreenRouteArgs({
    this.key,
    this.messageId,
    this.messageBody,
  });

  final Key? key;

  final int? messageId;

  final GetSentMessagesWithParentDetails? messageBody;

  @override
  String toString() {
    return 'ReceivedReplyMessageScreenRouteArgs{key: $key, messageId: $messageId, messageBody: $messageBody}';
  }
}
