import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/src/data/datasources/local/assam_app_database.dart';
import 'package:flutter_clean_architecture/src/domain/models/geo_location.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/add_geo_location/add_geo_location_cubit.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/incedence/incedence_cubit.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/message/message_cubit.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/vdp_committee/vdp_committee_cubit.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/vdp_member/vdp_member_cubit.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/config/router/app_router.dart';
import 'src/config/themes/app_theme.dart';
import 'src/domain/repositories/api_repository.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/auth/auth_cubit.dart';
import 'src/presentation/cubits/geo_address/geo_address_cubit.dart';
import 'src/presentation/cubits/home/home_cubit.dart';
import 'src/utils/constants/colors.dart';
import 'src/utils/constants/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
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
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'Assam Police', // title
    description: 'Location Fetching', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AssamPolice Location Update',
      initialNotificationContent: 'Location Fetching',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

bool hasPermission = false;

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  final deviceInfo = DeviceInfoPlugin();
  String? device;
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    device = androidInfo.model;
  }

  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    device = iosInfo.model;
  }

  try {
    // bring to foreground
    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   var preferences = MySharedPreference();
    //   var location = loc.Location();
    //   location.enableBackgroundMode(enable: true);
    //   Position? position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.best);
    //   if (position != null) {
    //     assamDb.geoLocationDao.saveGeoLocation(GeoLocation(
    //         latitude: position.latitude, longitude: position.longitude));
    //   }
    //
    //   service.invoke(
    //     'update',
    //     {
    //       "current_date": DateTime.now().toIso8601String(),
    //       "device": device,
    //     },
    //   );
    // });

    LocationSettings? locationSettings = null;
    StreamSubscription<Position> positionStream;

    Timer.periodic(const Duration(seconds: 5), (timer) async {
      print("Location Timer is Running timer ===>>> ");

      if (locationSettings != null) {
        print("Location Timer is Running timer Cancel ===>>> ");
        timer.cancel();
      }
      // var status = await Permission.location.status;
      // if (status.isGranted) {
      //   locationSettings = const LocationSettings(
      //     accuracy: LocationAccuracy.bestForNavigation,
      //     distanceFilter: 0,
      //   );
      //   startUpdateLateLong(locationSettings);
      // }

      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 0,
      );
      startUpdateLateLong(locationSettings);
    });

    //Testing code
  } catch (err) {
    print("Location data ===>>> Exception ${err}");
  }
}

Future<void> startUpdateLateLong(
  LocationSettings? locationSettings,
) async {
  final assamDb =
      await $FloorAssamAppDatabase.databaseBuilder(databaseName).build();

  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position? position) {
    if (position != null) {
      print(
          "Location data ===>>> Location Change ==>>  ${position.latitude},${position.longitude}");
      assamDb.geoLocationDao.deleteData();
      assamDb.geoLocationDao.saveGeoLocation(GeoLocation(
          latitude: position.latitude, longitude: position.longitude));
    }
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    initializeSize(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            locator<ApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            locator<ApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => GetGeoAddressCubit(
            locator<ApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AddGeoLocationCubit(
            locator<ApiRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => IncedenceCubit(
            locator<ApiRepository>(),
          ),
        ),   BlocProvider(
          create: (context) => MessageCubit(
            locator<ApiRepository>(),
          ),
        ),   BlocProvider(
          create: (context) => VdpCommitteeCubit(
            locator<ApiRepository>(),
          ),
        ),  BlocProvider(
          create: (context) => VdpMemberCubit(
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
  }
}
