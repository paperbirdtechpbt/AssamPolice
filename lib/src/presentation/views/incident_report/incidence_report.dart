import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as GpsLocationEnable;
import 'package:permission_handler/permission_handler.dart';

import '../../../config/router/app_router.dart';
import '../../../data/datasources/local/assam_app_database.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/GpsLocation.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../../utils/utils.dart';
import '../../cubits/incedence/incedence_cubit.dart';
import '../../cubits/incedence/incedence_state.dart';
import '../../widgets/common_widgets.dart';

class IncidenceScreen extends StatefulWidget {
  const IncidenceScreen({Key? key}) : super(key: key);

  @override
  State<IncidenceScreen> createState() => _IncidenceScreenState();
}

class _IncidenceScreenState extends State<IncidenceScreen>
    with TickerProviderStateMixin {
  File? file;

  bool isFileSelected = false;
  TextEditingController description = TextEditingController();
  File? selectedFile;
  AnimationController? animationController;

  Future pickImage() async {
    try {
      // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file == null) return;
      final imageTemp = File(file!.path);
      setState(() => this.file = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  late User? user = User();
  var location;
  bool hasPermission = false;
  bool serviceStatus = false;
  late LocationPermission permission;
  Position? position = null;
  String long = "", lat = "";
  var cubit;

  removeLoading() {
    Timer(const Duration(seconds: 0), () => {appRouter.pop()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 10, right: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            appRouter.pop();
                          },
                          child: SvgPicture.asset(ic_arrow_left,
                              color: defaultColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Incidence Report",
                          style: styleIbmPlexSansLite(
                              size: 20, color: defaultColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          if (!isFileSelected) {
                            late var permission;
                            if (Platform.isIOS) {
                              permission = Permission.storage;
                            } else {
                              final androidInfo =
                                  await DeviceInfoPlugin().androidInfo;
                              permission = androidInfo.version.sdkInt! <= 32
                                  ? Permission.storage
                                  : Permission.camera;
                            }

                            if (await requestPermission(permission)) {
                              selectFile(
                                  context: context,
                                  isCamera: true,
                                  error: (String error) {
                                    snackBar(context, "${error}");
                                  },
                                  response: (List<File> file) {
                                    setState(() {
                                      selectedFile = file[0];
                                      isFileSelected = true;
                                      // selectedBase64 =
                                      //     base64EncodeFile(selectedFile!);
                                    });
                                  });
                            }
                          }
                          ;
                        },
                        child: Container(
                          height: 180,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: DottedBorder(
                              color: defaultColor,
                              radius: const Radius.circular(15),
                              child: Stack(
                                children: [
                                  Center(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: isFileSelected
                                        ? Image(
                                            image: FileImage(selectedFile!),
                                            width: double.maxFinite,
                                            height: double.maxFinite,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                debugPrint(
                                                    'image loading null');
                                                return child;
                                              }
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: SizedBox(
                                                  child: SvgPicture.asset(
                                                    ic_image_placeholder,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : SvgPicture.asset(ic_user_placeholder,
                                            width: double.maxFinite,
                                            height: double.maxFinite,
                                            fit: BoxFit.cover),
                                  )),
                                  if (isFileSelected) ...[
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedFile = null;
                                            isFileSelected = false;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: backImage,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Icon(
                                            Icons.close,
                                            color: grey,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ],
                              ),
                              borderType: BorderType.RRect,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextFieldEditBoxBig(
                            context: context,
                            controller: description,
                            label: "Description",
                            length: null,
                            validator: (val) {
                              // if (val!.length <= 2) return validatorEnterMobile;
                              return null;
                            },
                            hint: "Description",
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            BlocConsumer<IncedenceCubit, IncedenceState>(
              listener: (context, state) async {
                if (state is IncedenceLoadingState) {
                  onLoading(context, "Loading..");
                }
                if (state is IncedenceSuccessState) {
                  if (state.response?.status == "200") {
                    appRouter.pop();
                    setState(() {
                      selectedFile = null;
                      isFileSelected = false;
                      description.text = "";
                    });
                    snackBar(context, "${state.response?.message}");
                    Navigator.pop(context);
                  }
                } else if (state is IncedenceErrorState) {
                  snackBar(context, "${state.error?.message}");
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ButtonThemeLarge(
                          context: context,
                          label: "Incidence Report",
                          color: defaultColor,
                          onClick: () {
                            if (!isFileSelected) {
                              snackBar(context, "Please capture image");
                            } else if (description.text.isEmpty) {
                              snackBar(context, "Please enter description");
                            } else {
                              var assamDb;

                              Geolocator.isLocationServiceEnabled()
                                  .then((isGps) async => {
                                        assamDb = await $FloorAssamAppDatabase
                                            .databaseBuilder(databaseName)
                                            .build(),
                                        await assamDb.geoLocationDao
                                            .getLastGeoLocation()
                                            .then((location) => {
                                                  if (isGps)
                                                    {
                                                      if (location != null)
                                                        {
                                                          if (hasPermission)
                                                            {
                                                              if (location
                                                                      .latitude
                                                                      .toString()
                                                                      .isNotEmpty &&
                                                                  location
                                                                      .longitude
                                                                      .toString()
                                                                      .isNotEmpty)
                                                                {
                                                                  cubit.incedence(
                                                                      locationImage:
                                                                          base64EncodeFile(
                                                                              selectedFile!),
                                                                      latitude: location
                                                                          .latitude
                                                                          .toString(),
                                                                      longitude: location
                                                                          .longitude
                                                                          .toString(),
                                                                      createdBy:
                                                                          user
                                                                              ?.email,
                                                                      description:
                                                                          description
                                                                              .text)
                                                                }
                                                              else
                                                                {
                                                                  snackBar(
                                                                      context,
                                                                      "Location not found")
                                                                }
                                                            }
                                                          else
                                                            {
                                                              _requestPermission()
                                                            }
                                                        }
                                                      else
                                                        {
                                                          snackBar(context,
                                                              "Location not found")
                                                        }
                                                    }
                                                  else
                                                    {
                                                      snackBar(context,
                                                          "GPS Service is not enabled, turn on GPS location")
                                                    }
                                                }),
                                      });
                            }
                          }),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  fetchLocation() {
    Geolocator.isLocationServiceEnabled().then((value) => {
          if (value)
            {
              GpsLocation.gpsLocation.getLocation(
                (position) {
                  this.position = position;
                },
              )
            }
          else
            {
              // removeLoading(),
              snackBar(
                  context, "GPS Service is not enabled, turn on GPS location")
            }
        });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      hasPermission = true;
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    super.initState();

    _requestPermission();
    cubit = context.read<IncedenceCubit>();

    checkPermission();
    location = GpsLocationEnable.Location();

    Timer(const Duration(seconds: 3), () => {checkGpsEnable()});

    checkGps();

    getUser();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        animationController = AnimationController(
            vsync: this, duration: const Duration(seconds: 2));
        animationController!.forward();
      }
    });

    if (hasPermission) {
      getLocation();
      fetchLocation();
    }
  }

  AnimationController? initAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationController!.forward();
    return animationController;
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (mounted) {
      animationController?.dispose();
    }
  }

  checkGpsEnable() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    setState(() {
      serviceStatus;
    });
  }

  checkGps() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        setState(() {
          //refresh the UI
        });
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {});
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position?.longitude); //Output: 80.24599079
    print(position?.latitude); //Output: 29.6593457

    long = position!.longitude.toString();
    lat = position!.latitude.toString();

    setState(() {
      long = position!.longitude.toString();
      lat = position!.latitude.toString();
    });

    LocationSettings locationSettings = const LocationSettings(
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        long = position.longitude.toString();
        lat = position.latitude.toString();
      });
    });
  }

  checkPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        fetchLocation();
        hasPermission = true;
      }
    } else {
      fetchLocation();
      hasPermission = true;
    }
    setState(() {
      if (hasPermission) {
        getLocation();
      }
    });
  }

  enableGps() async {
    if (hasPermission) {
      if (!await location.serviceEnabled()) {
        bool isTurnedOn = await location.requestService();
        if (isTurnedOn) {
          serviceStatus = await Geolocator.isLocationServiceEnabled();
          getLocation();
        } else {
          serviceStatus = await Geolocator.isLocationServiceEnabled();
        }
      } else {
        serviceStatus = await Geolocator.isLocationServiceEnabled();
        getLocation();
      }
    }
  }

  base64EncodeFile(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    print(imageBytes);
    return base64Encode(imageBytes);
  }
}
