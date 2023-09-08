import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as GpsLocationEnable;
import 'package:permission_handler/permission_handler.dart';

import '../../../config/router/app_router.dart';
import '../../../data/datasources/local/assam_app_database.dart';
import '../../../domain/models/data/geo_location.dart';
import '../../../domain/models/data/user.dart';
import '../../../domain/models/requests/add_geo_location_request.dart';
import '../../../utils/GpsLocation.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../../utils/utils.dart';
import '../../cubits/add_geo_location/add_geo_location_cubit.dart';
import '../../cubits/add_geo_location/add_geo_location_state.dart';
import '../../widgets/common_widgets.dart';

class AddPhotoCaptureView extends StatefulWidget {
  final int? locationId;
  final int? photoId;
  final String? addressLat;
  final String? addressLng;

  AddPhotoCaptureView({
    Key? key,
    required this.locationId,
    required this.photoId,
    required this.addressLat,
    required this.addressLng,
  }) : super(key: key);

  @override
  State<AddPhotoCaptureView> createState() => _AddPhotoCaptureViewState(
        locationId,
        photoId,
        addressLat,
        addressLng,
      );
}

class _AddPhotoCaptureViewState extends State<AddPhotoCaptureView>
    with TickerProviderStateMixin {
  final int? locationId;
  final int? photoId;
  final String? addressLat;
  final String? addressLng;

  _AddPhotoCaptureViewState(
      this.locationId, this.photoId, this.addressLat, this.addressLng);

  TextEditingController mobileController = TextEditingController();

  AnimationController? animationController;
  late var pr;

  List<File?> listFile = [];
  late List<String> listCameraType = [];
  late List<GeoLocation> listGeoLocation = [];
  String? selectedCameraType;
  bool isFileSelected = false;
  File? selectedFile;
  late String selectedBase64 = "";

  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  Position? position = null;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  late User? user = User();
  late var cubit = context.read<AddGeoLocationCubit>();
  GeoLocation? geoLocation;

  var location;

  bool isPhotoClick = true;
  bool isGeoLocationClick = true;
  bool isSubmitClick = true;
  bool isDataSubmit = false;
  bool isSubmit = true;

  @override
  void initState() {
    super.initState();

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

  checkPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        hasPermission = true;
        fetchLocation();
      }
    } else {
      hasPermission = true;
      fetchLocation();
    }
    setState(() {
      if (hasPermission) {
        getLocation();
        fetchLocation();
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

  Future<bool> onWillPop() {
    appRouter.pop({"refreshData": "refresh"});
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          body: Stack(
        children: [
          Flex(direction: Axis.vertical, children: [
            Flexible(
                child: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              onWillPop();
                            },
                            child: SvgPicture.asset(ic_arrow_left,
                                color: defaultColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            addPhoto,
                            style: styleIbmPlexSansLite(
                                size: 20, color: defaultColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                                    });
                                  });
                            }
                          }
                          ;
                        },
                        child: Container(
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
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
                      const SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<AddGeoLocationCubit, AddGeoLocationState>(
                          listener: (context, state) async {
                        if (state is AddGeoLocationLoadingState) {
                          onLoading(context, "Loading..");
                        }
                        if (state is AddGeoLocationSuccessState) {
                          appRouter.pop();
                          if (state.response?.status == "201") {
                            snackBar(context, "${state.response?.message}");
                          } else {
                            if (currentUploadIndex <
                                listGeoLocation.length + 1) {
                              listGeoLocation[currentUploadIndex].isFileUpload =
                                  true;
                              listGeoLocation[currentUploadIndex].fileStatus =
                                  2;
                              if (currentUploadIndex < listGeoLocation.length) {
                                if (currentUploadIndex ==
                                    listGeoLocation.length - 1) {
                                  redirectApp();
                                } else {
                                  currentUploadIndex = currentUploadIndex + 1;
                                  doUpload();
                                }
                              } else {
                                snackBar(context, "Submit successfully");
                                onWillPop();
                              }

                              setState(() {
                                listGeoLocation;
                              });
                            }
                            // snackBar(context, "${state.response?.message}");
                          }
                        } else if (state is AddGeoLocationErrorState) {
                          listGeoLocation[currentUploadIndex].isFileUpload =
                              false;
                          listGeoLocation[currentUploadIndex].fileStatus = 3;
                          appRouter.pop();
                          snackBar(context, "${state.error?.message}");
                        }
                      }, builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Column(
                            children: [
                              ButtonThemeLarge(
                                  context: context,
                                  label: "${addPhoto} With Geo Location",
                                  color: defaultColor,
                                  onClick: () {
                                    if (isPhotoClick) {
                                      isPhotoClick = false;
                                      AddGeoLocationRequest request;
                                      Map? map;
                                      if (isFileSelected) {
                                        var assamDb;
                                        Geolocator.isLocationServiceEnabled()
                                            .then((isGps) async => {
                                                  assamDb =
                                                      await $FloorAssamAppDatabase
                                                          .databaseBuilder(
                                                              databaseName)
                                                          .build(),
                                                  await assamDb.geoLocationDao
                                                      .getLastGeoLocation()
                                                      .then((location) => {
                                                            if (isGps)
                                                              {
                                                                if (hasPermission)
                                                                  {
                                                                    if (location !=
                                                                        null)
                                                                      {
                                                                        geoLocation =
                                                                            GeoLocation(
                                                                          photo:
                                                                              selectedFile,
                                                                          lat: location
                                                                              .latitude
                                                                              .toString(),
                                                                          long: location
                                                                              .longitude
                                                                              .toString(),
                                                                          isFileUpload:
                                                                              false,
                                                                          fileStatus:
                                                                              0,
                                                                        ),
                                                                        setState(
                                                                            () {
                                                                          isPhotoClick =
                                                                              true;
                                                                          listGeoLocation
                                                                              .add(geoLocation!);
                                                                          geoLocation =
                                                                              null;
                                                                          if (selectedFile !=
                                                                              null) {
                                                                            selectedFile =
                                                                                null;
                                                                            isFileSelected =
                                                                                false;
                                                                          }
                                                                        }),

                                                                        // appRouter.push(GoogleMapPickLocationRoute(addressLat: location.latitude.toString(), addressLng: location.longitude.toString())).then((value) =>
                                                                        //     {
                                                                        //       map = value as Map?,
                                                                        //       if (map?["refreshData"] != null && map?["refreshData"] == "refresh")
                                                                        //         {
                                                                        //           print("Google Map Camera Position Location ====>>>> ${map?["lat"]},${map?["lng"]}"),
                                                                        //           geoLocation = GeoLocation(
                                                                        //             photo: selectedFile,
                                                                        //             lat: location.latitude.toString(),
                                                                        //             long: location.longitude.toString(),
                                                                        //             isFileUpload: false,
                                                                        //             fileStatus: 0,
                                                                        //           ),
                                                                        //           setState(() {
                                                                        //             listGeoLocation.add(geoLocation!);
                                                                        //             geoLocation = null;
                                                                        //             if (selectedFile != null) {
                                                                        //               selectedFile = null;
                                                                        //               isFileSelected = false;
                                                                        //             }
                                                                        //           }),
                                                                        //         }
                                                                        //       else
                                                                        //         {
                                                                        //           isPhotoClick = true
                                                                        //         }
                                                                        //     })
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
                                                                snackBar(
                                                                    context,
                                                                    "GPS Service is not enabled, turn on GPS location")
                                                              }
                                                          }),
                                                });
                                      } else {
                                        snackBar(context,
                                            "Please capture image first.");

                                        isPhotoClick = true;
                                      }
                                    }

                                    return null;
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              ButtonThemeLarge(
                                  context: context,
                                  label: "Add Geo Location",
                                  color: defaultColor,
                                  onClick: () {
                                    AddGeoLocationRequest request;
                                    Map? map;

                                    var assamDb;

                                    Geolocator.isLocationServiceEnabled()
                                        .then((isGps) async => {
                                              assamDb =
                                                  await $FloorAssamAppDatabase
                                                      .databaseBuilder(
                                                          databaseName)
                                                      .build(),
                                              await assamDb.geoLocationDao
                                                  .getLastGeoLocation()
                                                  .then((location) => {
                                                        if (isGps)
                                                          {
                                                            if (hasPermission)
                                                              {
                                                                if (location !=
                                                                    null)
                                                                  {
                                                                    appRouter
                                                                        .push(GoogleMapPickLocationRoute(
                                                                            addressLat: location.latitude
                                                                                .toString(),
                                                                            addressLng: location.longitude
                                                                                .toString()))
                                                                        .then((value) =>
                                                                            {
                                                                              map = value as Map?,
                                                                              if (map?["refreshData"] != null && map?["refreshData"] == "refresh")
                                                                                {
                                                                                  print("Google Map Camera Position Location ====>>>> ${map?["lat"]},${map?["lng"]}"),
                                                                                  geoLocation = GeoLocation(
                                                                                    photo: null,
                                                                                    lat: map?["lat"],
                                                                                    long: map?["lng"],
                                                                                    isFileUpload: false,
                                                                                    fileStatus: 0,
                                                                                  ),
                                                                                  setState(() {
                                                                                    listGeoLocation.add(geoLocation!);
                                                                                    geoLocation = null;
                                                                                  })
                                                                                }
                                                                            })
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
                                                                "GPS Service is not enabled, turn on GPS location")
                                                          }
                                                      }),
                                            });
                                    return null;
                                  }),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Flexible(
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: listGeoLocation.length,
                        itemBuilder: (context, index) {
                          GeoLocation geoLocation = listGeoLocation[index];
                          var file = geoLocation.photo;
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Container(
                                height: 120,
                                width: 120,
                                decoration: const BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(14.0)),
                                    color: backImage),
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: InkWell(
                                                  child: file == null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: SizedBox(
                                                            child: SvgPicture
                                                                .asset(
                                                              ic_image_placeholder,
                                                              width: 100,
                                                              height: 100,
                                                            ),
                                                          ),
                                                        )
                                                      : Image(
                                                          image:
                                                              FileImage(file),
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            if (loadingProgress ==
                                                                null) {
                                                              debugPrint(
                                                                  'image loading null');
                                                              return child;
                                                            }
                                                            return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child: SizedBox(
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  ic_image_placeholder,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                  onTap: () {}),
                                            ),
                                          ),
                                          if (geoLocation.isFileUpload !=
                                                  null &&
                                              geoLocation.isFileUpload ==
                                                  false) ...[
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    listGeoLocation
                                                        .removeAt(index);
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: backImage,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]
                                        ],
                                      ),
                                      onTap: () {},
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Latitude : ${(double.parse(geoLocation.lat ?? "0.0")).toStringAsFixed(5)}",
                                              style: styleIbmPlexSansLite(
                                                  size: 15, color: black),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Longitude : ${(double.parse(geoLocation.long ?? "0.0")).toStringAsFixed(5)}",
                                              style: styleIbmPlexSansLite(
                                                  size: 15, color: black),
                                            ),
                                          ],
                                        ),
                                        if (geoLocation.fileStatus == 1 ||
                                            geoLocation.fileStatus == 2 ||
                                            geoLocation.fileStatus == 3) ...[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Icon(
                                              geoLocation.fileStatus == 1
                                                  ? Icons.cloud_upload_outlined
                                                  : (geoLocation.fileStatus == 3
                                                      ? Icons
                                                          .error_outline_rounded
                                                      : Icons.cloud_done),
                                              color: geoLocation.fileStatus == 1
                                                  ? Colors.black12
                                                  : (geoLocation.fileStatus == 3
                                                      ? Colors.red
                                                      : Colors.green),
                                              size: 50,
                                            ),
                                          ),
                                        ]
                                      ],
                                    )
                                  ],
                                )),
                          );
                        },
                      ),
                      if (listGeoLocation.isNotEmpty)
                        Positioned(
                          bottom: 5,
                          child: Center(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ButtonThemeLarge(
                                  context: context,
                                  label: "Submit",
                                  color: defaultColor,
                                  onClick: () {
                                    // snackBar(context, "Submit successfully");
                                    // onWillPop();
                                    currentUploadIndex = 0;
                                    doUpload();

                                    return null;
                                  }),
                            ),
                          )),
                        ),

                      // if(isDataSubmit)
                      //   Positioned(
                      //     bottom: 5,
                      //     child: Center(
                      //         child: Container(
                      //           width: MediaQuery.of(context).size.width * 1,
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(12.0),
                      //             child: ButtonThemeLarge(
                      //                 context: context,
                      //                 label: "Back",
                      //                 color: defaultColor,
                      //                 onClick: () {
                      //                   onWillPop();
                      //                   return null;
                      //                 }),
                      //           ),
                      //         )),
                      //   ),
                    ],
                  ),
                ),
              ],
            )))
          ])
        ],
      )),
      onWillPop: onWillPop,
    );
  }

  var currentUploadIndex = 0;

  redirectApp() {
    setState(() {
      isDataSubmit = true;
      isSubmit = false;
    });

    Timer(const Duration(seconds: 0),
        () => {snackBar(context, "Submit successfully"), onWillPop()});
  }

  removeLoading() {
    Timer(const Duration(seconds: 1), () => {onWillPop()});
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

  doUpload() {
    var count = 0;

    var request;
    listGeoLocation.forEach((element) {
      if (currentUploadIndex == count) {
        if (element.photo != null) {
          if (element.isFileUpload == false) {
            selectedBase64 = base64EncodeFile(element.photo!);
            request = AddGeoLocationRequest(
                id: photoId == null ? 0 : photoId,
                locationId: locationId,
                locationImage: selectedBase64,
                latitude: element.lat,
                longitude: element.long,
                status: "1",
                createdBy: user?.email);
            listGeoLocation[currentUploadIndex].fileStatus = 1;
            setState(() {
              listGeoLocation;
            });

            cubit.addGeoLocation(request);
          }
        } else {
          if (element.isFileUpload == false) {
            request = AddGeoLocationRequest(
                id: photoId == null ? 0 : photoId,
                locationId: locationId,
                locationImage: selectedBase64,
                latitude: element.lat,
                longitude: element.long,
                status: "1",
                createdBy: user?.email);
            listGeoLocation[currentUploadIndex].fileStatus = 1;
            setState(() {
              listGeoLocation;
            });
            cubit.addGeoLocation(request);
          }
        }
      }

      count++;
    });
  }

  base64EncodeFile(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    print(imageBytes);
    return base64Encode(imageBytes);
  }
}
