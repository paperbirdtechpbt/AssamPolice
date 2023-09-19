import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/incedence/incedence_cubit.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/message/message_cubit.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/user_menu_option/user_menu_option_cubit.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/vdp_committee/vdp_committee_cubit.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/vdp_member/vdp_member_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/config/router/app_router.dart';
import 'src/config/themes/app_theme.dart';
import 'src/domain/repositories/api_repository.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/auth/auth_cubit.dart';
import 'src/presentation/cubits/home/home_cubit.dart';
import 'src/utils/constants/colors.dart';
import 'src/utils/constants/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await ScreenUtil.ensureScreenSize();

  // initGeoLocation();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: white, // navigation bar color
    statusBarColor: Color(0xFF01017d ), // status bar color
  ));

  initializeService();

  runApp(MyApp());
}

// _requestPermission() async {
//   loc.Location location = new loc.Location();
//
//   bool _serviceEnabled;
//   loc.PermissionStatus _permissionGranted;
//   loc.LocationData _locationData;
//
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return;
//     }
//   }
//
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == loc.PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted == loc.PermissionStatus.granted) {
//       initializeService();
//     } else if (_permissionGranted != PermissionStatus.granted) {
//       return;
//     }
//   } else {
//     initializeService();
//   }
// }

late var localArticlesCubit;

Future<void> initializeService() async {

}



bool hasPermission = false;



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context);

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {


        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  AuthCubit(
                    locator<ApiRepository>(),
                  ),
            ),
            BlocProvider(
              create: (context) =>
                  HomeCubit(
                    locator<ApiRepository>(),
                  ),
            ),

            BlocProvider(
              create: (context) =>
                  IncedenceCubit(
                    locator<ApiRepository>(),
                  ),
            ), BlocProvider(
              create: (context) =>
                  MessageCubit(
                    locator<ApiRepository>(),
                  ),
            ), BlocProvider(
              create: (context) =>
                  VdpCommitteeCubit(
                    locator<ApiRepository>(),
                  ),
            ), BlocProvider(
              create: (context) =>
                  VdpMemberCubit(
                    locator<ApiRepository>(),
                  ),
            ), BlocProvider(
              create: (context) =>
                  UserMenuOptionCubit(
                    locator<ApiRepository>(),
                  ),
            ),
          ],
          child: OKToast(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerDelegate: appRouter.delegate(),
              routeInformationParser: appRouter.defaultRouteParser(),
              title: appTitle,
              theme: AppTheme.light,
            ),
          ),
        );
      },
    );
  }
}


