import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/presentation/views/address/address_complete_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/arguments.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../widgets/common_widgets.dart';
import 'address_pending_view.dart';

class AddressView extends StatefulWidget {
  final Arguments arguments;

  const AddressView({Key? key, required this.arguments}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressView(arguments);
}

class _AddressView extends State<AddressView>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin,
        WidgetsBindingObserver {
  final Arguments arguments;

  _AddressView(this.arguments);

  TextEditingController mobileController = TextEditingController();

  late List<String> list = [];

  late TabController _tabController;

  final _selectedColor = defaultColor;

  final _tabs = [
    const Tab(text: 'Pending'),
    const Tab(text: 'Complete'),
  ];

  late User? user = User();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print(" AddressView =========================>>>>>${state}");
    }
  }

  @override
  void didPopNext() {
    //similar to onResume
    print(" AddressView =========================>>>>>didPopNext");
  }

  @override
  void didPushNext() {
    //s
    print(" AddressView =========================>>>>>didPushNext");
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    getUser();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
          setState(() {
            user = data?.user;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
      padding: const EdgeInsets.only(top: 60.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    appRouter.pop();
                  },
                  child: SvgPicture.asset(ic_arrow_left, color: defaultColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Address",
                  style: styleIbmPlexSansLite(size: 20, color: defaultColor),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(30.0),
            //       child: (user?.profilePic != null && user?.profilePic != "")
            //           ? networkImage("${user?.profilePic}", 50, 50)
            //           : SvgPicture.asset(ic_profile,
            //               width: 50,
            //               height: 50,
            //               fit: BoxFit.cover,
            //               color: defaultColor,),
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           user?.name != null ? "${user?.name}" : "",
            //           style:
            //               styleIbmPlexSansLite(size: 20, color: defaultColor),
            //         )
            //       ],
            //     )
            //   ],
            // ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 65,
            decoration: BoxDecoration(
              color: _selectedColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 10.0, left: 10.0),
              child: TabBar(
                controller: _tabController,
                indicator: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    color: Colors.white),
                labelColor: Colors.black,
                labelStyle: styleIbmPlexSansBold(size: 15, color: defaultColor),
                unselectedLabelColor: Colors.white,
                tabs: _tabs,
              ),
            ),
          ),
          Flexible(
            child: TabBarView(
              children: [
                AddressPendingView(
                  categoryID: arguments.categoryID,
                  policeStationID: arguments.policeStationId,
                ),
                AddressCompleteView(
                  categoryID: arguments.categoryID,
                  policeStationID: arguments.policeStationId,
                )
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    )));
  }

  @override
  bool get wantKeepAlive => true;
}
