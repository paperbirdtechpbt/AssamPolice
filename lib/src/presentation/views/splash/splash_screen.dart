import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/router/app_router.dart';
import '../../../locator.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../../utils/static_data.dart';
import '../../widgets/common_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var preferences = MySharedPreference();
    Timer(
        const Duration(seconds: 3),
        () => {
              preferences.getBoolValue(keyIsLogin).then((isLogin) => {
                    if (isLogin)
                      {
                        // appRouter.popAndPush(const DashBoardScreenRoute()),
                        appRouter.popAndPush(const AddMemberLocationRoute()),

                        preferences
                            .getSignInModel(keySaveSignInModel)
                            .then((data) => {StaticData.loginData = data})
                      }
                    else
                      {appRouter.popAndPush(const LoginViewRoute())}
                  }),
            });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeSize(context);

    return Scaffold(
        backgroundColor: white,
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      ic_logo_png,
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350,
                      child: Text(
                        "ASSAM POLICE VILLAGE DEFENCE ORGANISATION",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.red.shade700,
                            fontFamily: ibmPlexSansRegular),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
                bottom: 35, child: Center(child: Text("Develop by Teraclab"))),
            const Positioned(
                bottom: 10, child: Center(child: Text("version 1.0.0")))
          ],
        ));
  }
}
