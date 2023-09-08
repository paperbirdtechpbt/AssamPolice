import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/router/app_router.dart';
import '../../../data/datasources/local/assam_app_database.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../widgets/common_widgets.dart';

bool isClick = false;

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late User? user = User();

  @override
  void initState() {
    super.initState();
    // cubit = context.read<HomeCubit>();
    // cubit.getDistrict();

    getUser();
    startService();
  }

  startService() async {
    final service = FlutterBackgroundService();
    var isRunning = await service.isRunning();
    if (!isRunning) {
      service.startService();
    }
  }

  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
          setState(() {
            user = data?.user;
          })
        });
  }

  getLateLong() async {
    final assamDb =
        await $FloorAssamAppDatabase.databaseBuilder(databaseName).build();
    var latitude =
        await assamDb.geoLocationDao.getLastGeoLocation().then((value) => {
              if (value != null)
                {
                  print(
                      "Dashboard Location ====>>>>>>>>>>>>>>>>> ${value.latitude} ${value.longitude}")
                }
              else
                {print("Dashboard Location ====>>>>>>>>>>>>>>>>> null ")}
            });
    // var longitude =  await preferences.getString("longitude");
    //
    //  print("Dashboard Location ====>>>>>>>>>>>>>>>>> ${ latitude} ${ longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackMove(context),
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: networkImage("${user?.profilePic}", 50, 50),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome here.",
                            style:
                                styleIbmPlexSansRegular(size: 10, color: grey),
                          ),
                          Text(
                            "${user?.name}",
                            style: styleIbmPlexSansLite(
                                size: 20, color: defaultColor),
                          )
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      var preference = MySharedPreference();
                      preference.clear();
                      appRouter.popAndPush(LoginViewRoute());
                    },
                    child: SvgPicture.asset(ic_logout,
                        height: 30, width: 30, color: defaultColor),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    appRouter.push(IncidenceScreenRoute());
                  },
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined,
                            size: 33, color: defaultColor),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Incidence Report",
                          style: styleIbmPlexSansRegular(size: 13, color: grey),
                        ),
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on,
                              size: 33, color: defaultColor),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Add Geo Tagging",
                            style:
                                styleIbmPlexSansRegular(size: 13, color: grey),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      appRouter.push(HomeViewRoute());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  onBackPressed(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.exit_to_app_sharp, color: defaultColor),
                  SizedBox(width: 10),
                  Text('Close Application?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ]),
            content: Text('Are you sure you want to exit the Application?'),
            actions: <Widget>[
              TextButton(
                child: const Text('No',
                    style: TextStyle(fontSize: 15, color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop(false); //Will not exit the App
                },
              ),
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 15, color: Colors.red),
                ),
                onPressed: () {
                  FlutterBackgroundService().invoke("stopService");
                  exit(0);
                },
              )
            ],
          );
        });
  }

  Future<bool> onBackMove(BuildContext context) {
    if (isClick == true) {
      setState(() {
        isClick = false;
      });

      return Future.value(false);
    } else {
      return onBackPressed(context);
    }
  }
}
