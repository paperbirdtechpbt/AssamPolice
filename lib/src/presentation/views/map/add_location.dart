import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config/router/app_router.dart';
import '../../../data/datasources/local/assam_app_database.dart';
import '../../../domain/models/data/get_all_vdp_committee.dart';
import '../../../utils/GpsLocation.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../cubits/vdp_committee/vdp_committee_cubit.dart';
import '../../cubits/vdp_committee/vdp_committee_state.dart';
import '../../widgets/common_widgets.dart';
class AddLocationScreen extends StatefulWidget {
  bool? isUpdateLocation;
  GetAllVDPCommittee? getAllVDPCommittee;
  AddLocationScreen({Key? key, this.isUpdateLocation, this.getAllVDPCommittee})
      : super(key: key);

  @override
  State<AddLocationScreen> createState() =>
      _AddLocationScreenState(isUpdateLocation, getAllVDPCommittee);
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  _AddLocationScreenState(this.isUpdateLocation, this.getAllVDPCommittee);
  late GoogleMapController _googleMapController;
  bool? isUpdateLocation;
  GetAllVDPCommittee? getAllVDPCommittee;

  Position? position;
  Position? currentLocationPosition;

  late CameraPosition cameraPosition;

  late LatLng latLngPosition;

  String selectedText = " ";
  bool hasPermission = true;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
 bool isLatLongValidate = false ;
  var bitMap;

  @override
  void initState() {
    super.initState();

    latLngPosition = LatLng(
        double.parse(getAllVDPCommittee?.latitude ?? " 26.3455527"),
        double.parse(getAllVDPCommittee?.longitude ?? "92.6686367"));

    fetchLocation();

    cameraPosition = CameraPosition(
      target: latLngPosition,
      zoom: 20.0,
    );
  }

  fetchLocation() {
    Geolocator.isLocationServiceEnabled().then((value) => {
          if (value)
            {
              GpsLocation.gpsLocation.getLocation(
                (position) {
                  this.currentLocationPosition = position;
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

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  bool isLatValidate = false;
  bool isLongValidate = false;
  TextEditingController _latController = TextEditingController();
  TextEditingController _longController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double paddingPin = MediaQuery.of(context).size.height * 0.05;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 1.5),
            color: Colors.white),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition: cameraPosition,
                    markers: markers.values.toSet(),
                    onCameraIdle: () async {
                      List<Placemark> placeMarks =
                          await placemarkFromCoordinates(
                        cameraPosition.target.latitude,
                        cameraPosition.target.longitude,
                      );
                      setState(() {
                        selectedText =
                            '${placeMarks.first.name}, ${placeMarks.first.administrativeArea}, ${placeMarks.first.country}';
                      });
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                    },
                    onCameraMoveStarted: () {
                      setState(() {
                        selectedText = "Fetching ...";
                      });
                    },
                    onCameraMove: (cameraPosition) {
                      this.cameraPosition = cameraPosition;
                    },
                  ),
                ),
              ],
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(bottom: paddingPin),
              child: SvgPicture.asset(
                ic_pin,
                color: defaultColor,
                height: 40,
                width: 40,
              ),
            )),
            Positioned(
                top: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedText,
                        style: styleIbmPlexSansBold(size: 20, color: grey),
                      ),
                    ),


                  ],
                )),
            Positioned(
                top: 130,
                left: 10,
                child:  Column(
crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Container(
                  width: SizeConfig.screenWidth * 0.45,
                  child: CoustomTextFieldEditBox(
                    textCapitalization: TextCapitalization.words,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    border: Border.all(
                        color: isLatValidate
                            ? defaultColor
                            : Colors.transparent),
                    textInputAction: TextInputAction.next,
                    context: context,
                    textInputType: TextInputType.phone,
                    inputBorder: InputBorder.none,
                    controller: _latController,
                    flutterIcon: const Icon(
                      Icons.gps_fixed,
                      color: defaultColor,
                    ),
                    label: location,
                    length: null,
                    validator: (val) {
                      return null;
                    },
                    onChanged: (value) {
                      if (value!.length <= 2) {
                        setState(() {
                          isLatValidate = true;
                        });
                      } else {
                        setState(() {
                          isLatValidate = false;
                        });
                      }
                      return null;
                    },
                    hint: "lat",
                    icon: '',
                  ),
                ),
SizedBox(height: SizeConfig.screenHeight * 0.01,),
                Container(

                  width: SizeConfig.screenWidth * 0.93,
                  child: CoustomTextFieldEditBox(
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    border: Border.all(
                        color: isLongValidate
                            ? defaultColor
                            : Colors.transparent),
                    textInputAction: TextInputAction.done,
                    context: context,
                    textInputType: TextInputType.phone,
                    inputBorder: InputBorder.none,
                    controller: _longController,
                    flutterIcon: const Icon(
                      Icons.gps_fixed,
                      color: defaultColor,
                    ),
                    label: location,
                    length: null,
                    validator: (val) {
                      return null;
                    },
                    onChanged: (value) {
                      if (value!.length <= 2) {
                        setState(() {
                          isLongValidate = true;
                        });
                      } else {
                        setState(() {
                          isLongValidate = false;
                        });
                      }
                      return null;
                    },
                    hint: "long",
                    icon: '',
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
height: 25,
                    minWidth: 30,
                    color: defaultColor,
                    onPressed: (){

                      if (isLocationValid(double.parse(_latController.text), double.parse(_longController.text))) {
                        setState(() {
                          isLatLongValidate = true ;
                        });
                        _googleMapController.animateCamera(
                            CameraUpdate.newLatLngZoom(
                                LatLng(double.parse(_latController.text),
                                    double.parse(_longController.text)),
                                20));

                     // setState(() {
                     //   LatLng       latLngPositionByInput = LatLng(
                     //       double.parse(_latController.text ?? " 26.3455527"),
                     //       double.parse(_longController.text ?? "92.6686367"));
                     //   cameraPosition = CameraPosition(
                     //     target: latLngPositionByInput,
                     //     zoom: 20.0,
                     //   );
                     // });
                      } else {

                     snackBar(context, "Invalid latitude or longitude");
                        print("Invalid latitude or longitude");
                      }

                    }, child: Text("Verify",style: styleIbmPlexSansRegular(size: 13, color: Colors.white),))
              ],)),
            Positioned(
                bottom: 80,
                right: 10,
                child: RawMaterialButton(
                  onPressed: () {
                    print("==============================>");
                    var assamDb;

                    Geolocator.isLocationServiceEnabled().then((isGps) async =>
                        {
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
                                            _googleMapController.animateCamera(
                                                CameraUpdate.newLatLngZoom(
                                                    LatLng(location.latitude,
                                                        location.longitude),
                                                    20))
                                          }
                                      }
                                    else
                                      {
                                        _requestPermission(),
                                        snackBar(context,
                                            "GPS Service is not enabled, turn on GPS location")
                                      }
                                  })
                        });

                    // var preferences = MySharedPreference();
                    // Geolocator.isLocationServiceEnabled()
                    //     .then((value) async => {
                    //           await preferences
                    //               .getStringValue(latitude)
                    //               .then((latitude) => {
                    //                     preferences
                    //                         .getStringValue(longitude)
                    //                         .then((longitude) => {
                    //                               if (latitude.isNotEmpty &&
                    //                                   longitude.isNotEmpty)
                    //                                 {
                    //                                   _googleMapController.animateCamera(
                    //                                       CameraUpdate.newLatLngZoom(
                    //                                           LatLng(
                    //                                               double.parse(
                    //                                                   latitude),
                    //                                               double.parse(
                    //                                                   longitude)),
                    //                                           20))
                    //                                 }
                    //                             })
                    //                   })
                    //         });
                  },
                  fillColor: Colors.white,
                  child: SvgPicture.asset(
                    ic_compass,
                    height: 20,
                    width: 20,
                    color: defaultColor,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  shape: const CircleBorder(),
                )),
            Positioned(
              bottom: 5,
              child: Center(
                  child: Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BlocConsumer<VdpCommitteeCubit, VdpCommitteeState>(
                    listener: (context, state) {
                      if (state is UpdateVdpCommitteeSuccessState) {
                        if (state.updateVdpCommitteeResponse?.code ==
                            "Success") {
                          snackBar(context, "Location Updated");

                          appRouter.pop();
                        } else {
                          snackBar(context, "something went wrong !");
                        }
                      }
                    },
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case UpdateVdpCommitteeInitialState:
                          return ButtonThemeLarge(
                              context: context,
                              label: "Add Location",
                              color: defaultColor,
                              onClick: () {
                                var assamDb;
                                var distance = 0.0;
                                if (hasPermission) {
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
                                                          if (location != null)
                                                            {
                                                              distance = Geolocator.distanceBetween(
                                                                  location
                                                                      .latitude,
                                                                  location
                                                                      .longitude,
                                                                  cameraPosition
                                                                      .target
                                                                      .latitude,
                                                                  cameraPosition
                                                                      .target
                                                                      .longitude),
                                                              // if (distance < 1000)
                                                              //   {
                                                              // appRouter.pop({
                                                              //   "refreshData":
                                                              //   "refresh",
                                                              //   "lat":
                                                              //   cameraPosition
                                                              //       .target
                                                              //       .latitude
                                                              //       .toString(),
                                                              //   "lng":
                                                              //   cameraPosition
                                                              //       .target
                                                              //       .longitude
                                                              //       .toString()
                                                              // }

                                                              // ),
                                                              if (isUpdateLocation ==
                                                                  true)
                                                                {
                                                                  // context.read<VdpCommitteeCubit>().updateVdpCommittee(
                                                                  //     vdpId: getAllVDPCommittee
                                                                  //         ?.vdpId,
                                                                  //     vdpName:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.vdpName,
                                                                  //     longitude: cameraPosition
                                                                  //         .target
                                                                  //         .longitude
                                                                  //         .toString(),
                                                                  //     latitude: cameraPosition
                                                                  //         .target
                                                                  //         .latitude
                                                                  //         .toString(),
                                                                  //     policeStation:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.policeStation,
                                                                  //     district:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.district,
                                                                  //     status: getAllVDPCommittee
                                                                  //         ?.status),
                                                                }
                                                              // }
                                                              // else
                                                              //   {
                                                              //     snackBar(context,
                                                              //         "Please select location under 1 km"),
                                                              //   }
                                                            }
                                                          else
                                                            {
                                                              snackBar(context,
                                                                  "Location not found"),
                                                            }
                                                        }
                                                      else
                                                        {
                                                          snackBar(context,
                                                              "GPS Service is not enabled, turn on GPS location")
                                                        }
                                                    })
                                          });
                                } else {
                                  _requestPermission();
                                }

                                // var preferences = MySharedPreference();
                                // var distance = 0.0;

                                // Geolocator.isLocationServiceEnabled().then((value) async => {
                                //   await preferences
                                //       .getStringValue(latitude)
                                //       .then((latitude) => {
                                //
                                //         print("Gooogle map get latitude ===>> $latitude"),
                                //     preferences
                                //         .getStringValue(longitude)
                                //         .then((longitude) => {
                                //       print("Gooogle map get longitude ===>> $longitude"),
                                //       if (value)
                                //         {
                                //           print("Gooogle map get longitude is location on ===>> $hasPermission"),
                                //
                                //           if (hasPermission)
                                //             {
                                //
                                //               print("Gooogle map get longitude is hasPermission ===>> $longitude"),
                                //               if (latitude.isNotEmpty &&
                                //                   longitude.isNotEmpty)
                                //                 {
                                //                   distance=  calculateDistance(
                                //                       cameraPosition
                                //                           .target
                                //                           .latitude,
                                //                       cameraPosition
                                //                           .target
                                //                           .longitude,
                                //                       double.parse(
                                //                           latitude),
                                //                       double.parse(
                                //                           longitude)),
                                //                   if (distance <
                                //                       1)
                                //                     {
                                //                       appRouter
                                //                           .pop({
                                //                         "refreshData":
                                //                         "refresh",
                                //                         "lat": cameraPosition
                                //                             .target
                                //                             .latitude
                                //                             .toString(),
                                //                         "lng": cameraPosition
                                //                             .target
                                //                             .longitude
                                //                             .toString()
                                //                       }),
                                //                     }
                                //                   else
                                //                     {
                                //                       snackBar(
                                //                           context,
                                //                           "Please select location under 1 km"),
                                //                     }
                                //                 }  else
                                //                 {
                                //                   snackBar(
                                //                       context,
                                //                       "Location not found")
                                //                 }}else{
                                //             _requestPermission()
                                //           }
                                //
                                //           // if (position != null)
                                //           //   {
                                //           //     appRouter.push(AddLocationScreenRoute(
                                //           //         addressLat: position
                                //           //             ?.latitude
                                //           //             .toString(),
                                //           //         addressLng: position
                                //           //             ?.longitude
                                //           //             .toString())).then((value) => {
                                //           //       map = value
                                //           //       as Map?,
                                //           //       if (map?["refreshData"] !=
                                //           //           null &&
                                //           //           map?["refreshData"] ==
                                //           //               "refresh")
                                //           //         {
                                //           //           geoLocation =
                                //           //               GeoLocation(
                                //           //                 photo:
                                //           //                 null,
                                //           //                 lat: map?[
                                //           //                 "lat"],
                                //           //                 long: map?[
                                //           //                 "lng"],
                                //           //                 isFileUpload:
                                //           //                 false,
                                //           //                 fileStatus:
                                //           //                 0,
                                //           //               ),
                                //           //           setState(
                                //           //                   () {
                                //           //                 listGeoLocation
                                //           //                     .add(geoLocation!);
                                //           //                 geoLocation =
                                //           //                 null;
                                //           //               })
                                //           //         }
                                //           //     })
                                //           //   }
                                //           // else
                                //           //   {
                                //           //     onLoadingWithMessage(context,"Getting Gps Location"),
                                //           //     GpsLocation.gpsLocation
                                //           //         .getLocation(
                                //           //             (gpsLocation) =>
                                //           //         {
                                //           //           removeLoading(),
                                //           //           appRouter
                                //           //               .push(AddLocationScreenRoute(
                                //           //               addressLat: gpsLocation.latitude.toString(),
                                //           //               addressLng: gpsLocation.longitude.toString()))
                                //           //               .then((value) => {
                                //           //             map = value as Map?,
                                //           //             if (map?["refreshData"] != null && map?["refreshData"] == "refresh")
                                //           //               {
                                //           //                 geoLocation = GeoLocation(
                                //           //                   photo: null,
                                //           //                   lat: map?["lat"],
                                //           //                   long: map?["lng"],
                                //           //                   isFileUpload: false,
                                //           //                   fileStatus: 0,
                                //           //                 ),
                                //           //                 setState(() {
                                //           //                   listGeoLocation.add(geoLocation!);
                                //           //                   geoLocation = null;
                                //           //                 })
                                //           //               }
                                //           //           })
                                //           //         })
                                //           //   }
                                //         }
                                //
                                //     })})});

                                // Geolocator.isLocationServiceEnabled().then((value) async => {
                                //           await preferences
                                //               .getStringValue(latitude)
                                //               .then((latitude) => {
                                //                     preferences
                                //                         .getStringValue(longitude)
                                //                         .then((longitude) => {
                                //                               if (value)
                                //                                 {
                                //                                   if (hasPermission)
                                //                                     {
                                //                                       if (latitude
                                //                                               .isNotEmpty &&
                                //                                           longitude
                                //                                               .isNotEmpty)
                                //                                         {
                                //                                           distance=  calculateDistance(
                                //                                               cameraPosition
                                //                                                   .target
                                //                                                   .latitude,
                                //                                               cameraPosition
                                //                                                   .target
                                //                                                   .longitude,
                                //                                               double.parse(
                                //                                                   latitude),
                                //                                               double.parse(
                                //                                                   longitude)),
                                //                                           if (distance <
                                //                                               1)
                                //                                             {
                                //                                               appRouter
                                //                                                   .pop({
                                //                                                 "refreshData":
                                //                                                     "refresh",
                                //                                                 "lat": cameraPosition
                                //                                                     .target
                                //                                                     .latitude
                                //                                                     .toString(),
                                //                                                 "lng": cameraPosition
                                //                                                     .target
                                //                                                     .longitude
                                //                                                     .toString()
                                //                                               }),
                                //                                             }
                                //                                           else
                                //                                             {
                                //                                               snackBar(
                                //                                                   context,
                                //                                                   "Please select location under 1 km"),
                                //                                             }
                                //                                         }
                                //                                       else
                                //                                         {
                                //                                           snackBar(
                                //                                               context,
                                //                                               "Location not found")
                                //                                         }
                                //                                     }
                                //                                   else
                                //                                     {
                                //                                       _requestPermission()
                                //                                     }
                                //                                 }
                                //                               else
                                //                                 {
                                //                                   snackBar(context,
                                //                                       "GPS Service is not enabled, turn on GPS location")
                                //                                 }
                                //                             })
                                //                   })
                                //         });

                                return null;
                              });
                        case UpdateVdpCommitteeLoadingState:
                          return const Center(
                            child: CircularProgressIndicator(
                              color: defaultColor,
                            ),
                          );
                        case UpdateVdpCommitteeSuccessState:
                          return ButtonThemeLarge(
                              context: context,
                              label: "Add Location",
                              color: defaultColor,
                              onClick: () {
                                var assamDb;
                                var distance = 0.0;
                                if (hasPermission) {
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
                                                          if (location != null)
                                                            {
                                                              distance = Geolocator.distanceBetween(
                                                                  location
                                                                      .latitude,
                                                                  location
                                                                      .longitude,
                                                                  cameraPosition
                                                                      .target
                                                                      .latitude,
                                                                  cameraPosition
                                                                      .target
                                                                      .longitude),
                                                              // if (distance < 1000)
                                                              //   {
                                                              // appRouter.pop({
                                                              //   "refreshData":
                                                              //   "refresh",
                                                              //   "lat":
                                                              //   cameraPosition
                                                              //       .target
                                                              //       .latitude
                                                              //       .toString(),
                                                              //   "lng":
                                                              //   cameraPosition
                                                              //       .target
                                                              //       .longitude
                                                              //       .toString()
                                                              // }),
                                                              if (isUpdateLocation ==
                                                                  true)
                                                                {
                                                                  // context.read<VdpCommitteeCubit>().updateVdpCommittee(
                                                                  //     vdpId: getAllVDPCommittee
                                                                  //         ?.vdpId,
                                                                  //     vdpName:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.vdpName,
                                                                  //     longitude: cameraPosition
                                                                  //         .target
                                                                  //         .longitude
                                                                  //         .toString(),
                                                                  //     latitude: cameraPosition
                                                                  //         .target
                                                                  //         .latitude
                                                                  //         .toString(),
                                                                  //     policeStation:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.policeStation,
                                                                  //     district:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.district,
                                                                  //     status: getAllVDPCommittee
                                                                  //         ?.status),
                                                                }
                                                              // }
                                                              // else
                                                              //   {
                                                              //     snackBar(context,
                                                              //         "Please select location under 1 km"),
                                                              //   }
                                                            }
                                                          else
                                                            {
                                                              snackBar(context,
                                                                  "Location not found"),
                                                            }
                                                        }
                                                      else
                                                        {
                                                          snackBar(context,
                                                              "GPS Service is not enabled, turn on GPS location")
                                                        }
                                                    })
                                          });
                                } else {
                                  _requestPermission();
                                }

                                // var preferences = MySharedPreference();
                                // var distance = 0.0;

                                // Geolocator.isLocationServiceEnabled().then((value) async => {
                                //   await preferences
                                //       .getStringValue(latitude)
                                //       .then((latitude) => {
                                //
                                //         print("Gooogle map get latitude ===>> $latitude"),
                                //     preferences
                                //         .getStringValue(longitude)
                                //         .then((longitude) => {
                                //       print("Gooogle map get longitude ===>> $longitude"),
                                //       if (value)
                                //         {
                                //           print("Gooogle map get longitude is location on ===>> $hasPermission"),
                                //
                                //           if (hasPermission)
                                //             {
                                //
                                //               print("Gooogle map get longitude is hasPermission ===>> $longitude"),
                                //               if (latitude.isNotEmpty &&
                                //                   longitude.isNotEmpty)
                                //                 {
                                //                   distance=  calculateDistance(
                                //                       cameraPosition
                                //                           .target
                                //                           .latitude,
                                //                       cameraPosition
                                //                           .target
                                //                           .longitude,
                                //                       double.parse(
                                //                           latitude),
                                //                       double.parse(
                                //                           longitude)),
                                //                   if (distance <
                                //                       1)
                                //                     {
                                //                       appRouter
                                //                           .pop({
                                //                         "refreshData":
                                //                         "refresh",
                                //                         "lat": cameraPosition
                                //                             .target
                                //                             .latitude
                                //                             .toString(),
                                //                         "lng": cameraPosition
                                //                             .target
                                //                             .longitude
                                //                             .toString()
                                //                       }),
                                //                     }
                                //                   else
                                //                     {
                                //                       snackBar(
                                //                           context,
                                //                           "Please select location under 1 km"),
                                //                     }
                                //                 }  else
                                //                 {
                                //                   snackBar(
                                //                       context,
                                //                       "Location not found")
                                //                 }}else{
                                //             _requestPermission()
                                //           }
                                //
                                //           // if (position != null)
                                //           //   {
                                //           //     appRouter.push(AddLocationScreenRoute(
                                //           //         addressLat: position
                                //           //             ?.latitude
                                //           //             .toString(),
                                //           //         addressLng: position
                                //           //             ?.longitude
                                //           //             .toString())).then((value) => {
                                //           //       map = value
                                //           //       as Map?,
                                //           //       if (map?["refreshData"] !=
                                //           //           null &&
                                //           //           map?["refreshData"] ==
                                //           //               "refresh")
                                //           //         {
                                //           //           geoLocation =
                                //           //               GeoLocation(
                                //           //                 photo:
                                //           //                 null,
                                //           //                 lat: map?[
                                //           //                 "lat"],
                                //           //                 long: map?[
                                //           //                 "lng"],
                                //           //                 isFileUpload:
                                //           //                 false,
                                //           //                 fileStatus:
                                //           //                 0,
                                //           //               ),
                                //           //           setState(
                                //           //                   () {
                                //           //                 listGeoLocation
                                //           //                     .add(geoLocation!);
                                //           //                 geoLocation =
                                //           //                 null;
                                //           //               })
                                //           //         }
                                //           //     })
                                //           //   }
                                //           // else
                                //           //   {
                                //           //     onLoadingWithMessage(context,"Getting Gps Location"),
                                //           //     GpsLocation.gpsLocation
                                //           //         .getLocation(
                                //           //             (gpsLocation) =>
                                //           //         {
                                //           //           removeLoading(),
                                //           //           appRouter
                                //           //               .push(AddLocationScreenRoute(
                                //           //               addressLat: gpsLocation.latitude.toString(),
                                //           //               addressLng: gpsLocation.longitude.toString()))
                                //           //               .then((value) => {
                                //           //             map = value as Map?,
                                //           //             if (map?["refreshData"] != null && map?["refreshData"] == "refresh")
                                //           //               {
                                //           //                 geoLocation = GeoLocation(
                                //           //                   photo: null,
                                //           //                   lat: map?["lat"],
                                //           //                   long: map?["lng"],
                                //           //                   isFileUpload: false,
                                //           //                   fileStatus: 0,
                                //           //                 ),
                                //           //                 setState(() {
                                //           //                   listGeoLocation.add(geoLocation!);
                                //           //                   geoLocation = null;
                                //           //                 })
                                //           //               }
                                //           //           })
                                //           //         })
                                //           //   }
                                //         }
                                //
                                //     })})});

                                // Geolocator.isLocationServiceEnabled().then((value) async => {
                                //           await preferences
                                //               .getStringValue(latitude)
                                //               .then((latitude) => {
                                //                     preferences
                                //                         .getStringValue(longitude)
                                //                         .then((longitude) => {
                                //                               if (value)
                                //                                 {
                                //                                   if (hasPermission)
                                //                                     {
                                //                                       if (latitude
                                //                                               .isNotEmpty &&
                                //                                           longitude
                                //                                               .isNotEmpty)
                                //                                         {
                                //                                           distance=  calculateDistance(
                                //                                               cameraPosition
                                //                                                   .target
                                //                                                   .latitude,
                                //                                               cameraPosition
                                //                                                   .target
                                //                                                   .longitude,
                                //                                               double.parse(
                                //                                                   latitude),
                                //                                               double.parse(
                                //                                                   longitude)),
                                //                                           if (distance <
                                //                                               1)
                                //                                             {
                                //                                               appRouter
                                //                                                   .pop({
                                //                                                 "refreshData":
                                //                                                     "refresh",
                                //                                                 "lat": cameraPosition
                                //                                                     .target
                                //                                                     .latitude
                                //                                                     .toString(),
                                //                                                 "lng": cameraPosition
                                //                                                     .target
                                //                                                     .longitude
                                //                                                     .toString()
                                //                                               }),
                                //                                             }
                                //                                           else
                                //                                             {
                                //                                               snackBar(
                                //                                                   context,
                                //                                                   "Please select location under 1 km"),
                                //                                             }
                                //                                         }
                                //                                       else
                                //                                         {
                                //                                           snackBar(
                                //                                               context,
                                //                                               "Location not found")
                                //                                         }
                                //                                     }
                                //                                   else
                                //                                     {
                                //                                       _requestPermission()
                                //                                     }
                                //                                 }
                                //                               else
                                //                                 {
                                //                                   snackBar(context,
                                //                                       "GPS Service is not enabled, turn on GPS location")
                                //                                 }
                                //                             })
                                //                   })
                                //         });

                                return null;
                              });
                        default:
                          return ButtonThemeLarge(
                              context: context,
                              label: "Add Location",
                              color: defaultColor,
                              onClick: () {
                                var assamDb;
                                var distance = 0.0;
                                if (hasPermission) {
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
                                                          if (location != null)
                                                            {
                                                              distance = Geolocator.distanceBetween(
                                                                  location
                                                                      .latitude,
                                                                  location
                                                                      .longitude,
                                                                  cameraPosition
                                                                      .target
                                                                      .latitude,
                                                                  cameraPosition
                                                                      .target
                                                                      .longitude),
                                                              // if (distance < 1000)
                                                              //   {
                                                              // appRouter.pop({
                                                              //   "refreshData":
                                                              //   "refresh",
                                                              //   "lat":
                                                              //   cameraPosition
                                                              //       .target
                                                              //       .latitude
                                                              //       .toString(),
                                                              //   "lng":
                                                              //   cameraPosition
                                                              //       .target
                                                              //       .longitude
                                                              //       .toString()
                                                              // }),
                                                              if (isUpdateLocation ==
                                                                  true)
                                                                {
                                                                  // context.read<VdpCommitteeCubit>().updateVdpCommittee(
                                                                  //     vdpId: getAllVDPCommittee
                                                                  //         ?.vdpId,
                                                                  //     vdpName:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.vdpName,
                                                                  //     longitude: cameraPosition
                                                                  //         .target
                                                                  //         .longitude
                                                                  //         .toString(),
                                                                  //     latitude: cameraPosition
                                                                  //         .target
                                                                  //         .latitude
                                                                  //         .toString(),
                                                                  //     policeStation:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.policeStation,
                                                                  //     district:
                                                                  //         getAllVDPCommittee
                                                                  //             ?.district,
                                                                  //     status: getAllVDPCommittee
                                                                  //         ?.status),
                                                                }
                                                              // }
                                                              // else
                                                              //     snackBar(context,
                                                              //         "Please select loc
                                                              //   {ation under 1 km"),
                                                              //   }
                                                            }
                                                          else
                                                            {
                                                              snackBar(context,
                                                                  "Location not found"),
                                                            }
                                                        }
                                                      else
                                                        {
                                                          snackBar(context,
                                                              "GPS Service is not enabled, turn on GPS location")
                                                        }
                                                    })
                                          });
                                } else {
                                  _requestPermission();
                                }

                                // var preferences = MySharedPreference();
                                // var distance = 0.0;

                                // Geolocator.isLocationServiceEnabled().then((value) async => {
                                //   await preferences
                                //       .getStringValue(latitude)
                                //       .then((latitude) => {
                                //
                                //         print("Gooogle map get latitude ===>> $latitude"),
                                //     preferences
                                //         .getStringValue(longitude)
                                //         .then((longitude) => {
                                //       print("Gooogle map get longitude ===>> $longitude"),
                                //       if (value)
                                //         {
                                //           print("Gooogle map get longitude is location on ===>> $hasPermission"),
                                //
                                //           if (hasPermission)
                                //             {
                                //
                                //               print("Gooogle map get longitude is hasPermission ===>> $longitude"),
                                //               if (latitude.isNotEmpty &&
                                //                   longitude.isNotEmpty)
                                //                 {
                                //                   distance=  calculateDistance(
                                //                       cameraPosition
                                //                           .target
                                //                           .latitude,
                                //                       cameraPosition
                                //                           .target
                                //                           .longitude,
                                //                       double.parse(
                                //                           latitude),
                                //                       double.parse(
                                //                           longitude)),
                                //                   if (distance <
                                //                       1)
                                //                     {
                                //                       appRouter
                                //                           .pop({
                                //                         "refreshData":
                                //                         "refresh",
                                //                         "lat": cameraPosition
                                //                             .target
                                //                             .latitude
                                //                             .toString(),
                                //                         "lng": cameraPosition
                                //                             .target
                                //                             .longitude
                                //                             .toString()
                                //                       }),
                                //                     }
                                //                   else
                                //                     {
                                //                       snackBar(
                                //                           context,
                                //                           "Please select location under 1 km"),
                                //                     }
                                //                 }  else
                                //                 {
                                //                   snackBar(
                                //                       context,
                                //                       "Location not found")
                                //                 }}else{
                                //             _requestPermission()
                                //           }
                                //
                                //           // if (position != null)
                                //           //   {
                                //           //     appRouter.push(AddLocationScreenRoute(
                                //           //         addressLat: position
                                //           //             ?.latitude
                                //           //             .toString(),
                                //           //         addressLng: position
                                //           //             ?.longitude
                                //           //             .toString())).then((value) => {
                                //           //       map = value
                                //           //       as Map?,
                                //           //       if (map?["refreshData"] !=
                                //           //           null &&
                                //           //           map?["refreshData"] ==
                                //           //               "refresh")
                                //           //         {
                                //           //           geoLocation =
                                //           //               GeoLocation(
                                //           //                 photo:
                                //           //                 null,
                                //           //                 lat: map?[
                                //           //                 "lat"],
                                //           //                 long: map?[
                                //           //                 "lng"],
                                //           //                 isFileUpload:
                                //           //                 false,
                                //           //                 fileStatus:
                                //           //                 0,
                                //           //               ),
                                //           //           setState(
                                //           //                   () {
                                //           //                 listGeoLocation
                                //           //                     .add(geoLocation!);
                                //           //                 geoLocation =
                                //           //                 null;
                                //           //               })
                                //           //         }
                                //           //     })
                                //           //   }
                                //           // else
                                //           //   {
                                //           //     onLoadingWithMessage(context,"Getting Gps Location"),
                                //           //     GpsLocation.gpsLocation
                                //           //         .getLocation(
                                //           //             (gpsLocation) =>
                                //           //         {
                                //           //           removeLoading(),
                                //           //           appRouter
                                //           //               .push(AddLocationScreenRoute(
                                //           //               addressLat: gpsLocation.latitude.toString(),
                                //           //               addressLng: gpsLocation.longitude.toString()))
                                //           //               .then((value) => {
                                //           //             map = value as Map?,
                                //           //             if (map?["refreshData"] != null && map?["refreshData"] == "refresh")
                                //           //               {
                                //           //                 geoLocation = GeoLocation(
                                //           //                   photo: null,
                                //           //                   lat: map?["lat"],
                                //           //                   long: map?["lng"],
                                //           //                   isFileUpload: false,
                                //           //                   fileStatus: 0,
                                //           //                 ),
                                //           //                 setState(() {
                                //           //                   listGeoLocation.add(geoLocation!);
                                //           //                   geoLocation = null;
                                //           //                 })
                                //           //               }
                                //           //           })
                                //           //         })
                                //           //   }
                                //         }
                                //
                                //     })})});

                                // Geolocator.isLocationServiceEnabled().then((value) async => {
                                //           await preferences
                                //               .getStringValue(latitude)
                                //               .then((latitude) => {
                                //                     preferences
                                //                         .getStringValue(longitude)
                                //                         .then((longitude) => {
                                //                               if (value)
                                //                                 {
                                //                                   if (hasPermission)
                                //                                     {
                                //                                       if (latitude
                                //                                               .isNotEmpty &&
                                //                                           longitude
                                //                                               .isNotEmpty)
                                //                                         {
                                //                                           distance=  calculateDistance(
                                //                                               cameraPosition
                                //                                                   .target
                                //                                                   .latitude,
                                //                                               cameraPosition
                                //                                                   .target
                                //                                                   .longitude,
                                //                                               double.parse(
                                //                                                   latitude),
                                //                                               double.parse(
                                //                                                   longitude)),
                                //                                           if (distance <
                                //                                               1)
                                //                                             {
                                //                                               appRouter
                                //                                                   .pop({
                                //                                                 "refreshData":
                                //                                                     "refresh",
                                //                                                 "lat": cameraPosition
                                //                                                     .target
                                //                                                     .latitude
                                //                                                     .toString(),
                                //                                                 "lng": cameraPosition
                                //                                                     .target
                                //                                                     .longitude
                                //                                                     .toString()
                                //                                               }),
                                //                                             }
                                //                                           else
                                //                                             {
                                //                                               snackBar(
                                //                                                   context,
                                //                                                   "Please select location under 1 km"),
                                //                                             }
                                //                                         }
                                //                                       else
                                //                                         {
                                //                                           snackBar(
                                //                                               context,
                                //                                               "Location not found")
                                //                                         }
                                //                                     }
                                //                                   else
                                //                                     {
                                //                                       _requestPermission()
                                //                                     }
                                //                                 }
                                //                               else
                                //                                 {
                                //                                   snackBar(context,
                                //                                       "GPS Service is not enabled, turn on GPS location")
                                //                                 }
                                //                             })
                                //                   })
                                //         });

                                return null;
                              });
                      }
                    },
                  ),
                ),
              )),
            ),
            Positioned(
              right: 0,
              top: 60,
              child: RawMaterialButton(
                onPressed: () {
                  appRouter.pop();
                },
                elevation: 2.0,
                fillColor: Colors.white,
                child: SvgPicture.asset(ic_clear,
                    height: 20, width: 20, color: black),
                padding: const EdgeInsets.all(12.0),
                shape: const CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
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

  bool isLocationValid(double latitude, double longitude) {
    // Check if latitude is within valid range (-90 to 90 degrees).
    if (latitude < -90.0 || latitude > 90.0) {
      return false;
    }

    // Check if longitude is within valid range (-180 to 180 degrees).
    if (longitude < -180.0 || longitude > 180.0) {
      return false;
    }

    // If both latitude and longitude pass the range checks, consider them valid.
    return true;
  }

}
