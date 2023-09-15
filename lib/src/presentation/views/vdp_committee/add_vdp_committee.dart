import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../main.dart';
import '../../../config/router/app_router.dart';
import '../../../data/datasources/local/assam_app_database.dart';
import '../../../domain/models/data/district.dart';
import '../../../domain/models/data/geo_location.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/GpsLocation.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/home/home_state.dart';
import '../../cubits/vdp_committee/vdp_committee_cubit.dart';
import '../../cubits/vdp_committee/vdp_committee_state.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/custom_dropdown.dart';
import 'package:location/location.dart' as GpsLocationEnable;

class AddVdpCommitteeView extends StatefulWidget {
  const AddVdpCommitteeView({super.key});

  @override
  State<AddVdpCommitteeView> createState() => _AddVdpCommitteeViewState();
}

class _AddVdpCommitteeViewState extends State<AddVdpCommitteeView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

// validator var
  bool isNameValidate = false;
  var assamDb;
  var geoLocation;
  Map? map;
  late List<GeoLocation> listGeoLocation = [];
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

  late List<String> listDistrict = [];
  late List<String> listPoliceStation = [];
  late List<District>? listDistrictResponse = [];
  late List<District>? listPoliceStationResponse = [];
  // late List<String> listPolice = ["BHARALUMUKH"];
  var mapDistrict = Map();
  var mapPolice = Map();

  String selectedDistrict = "";
  String? selectedDistrictId;
  String selectedPoliceStation = "";
  String? selectedPoliceStationId;
  late var cubit;
  late User? user = User();
  var location;
  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeCubit>();
    checkPermission();
    location = GpsLocationEnable.Location();

    Timer(const Duration(seconds: 3), () => {checkGpsEnable()});
    getUser();
  }

  bool serviceStatus = false;

  checkGpsEnable() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    setState(() {
      serviceStatus;
    });
  }

  late LocationPermission permission;
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

  Position? position = null;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
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

  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
          setState(() {
            user = data?.user;
            cubit.getDistrict(user?.email);
          })
        });
  }

  Future<bool> onWillPop() {
    // context.read<VdpCommitteeCubit>().getAllVdpCommittee();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Committee",
          ),
          leading: InkWell(
              onTap: () {
                appRouter.pop();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        BlocConsumer<HomeCubit, HomeState>(
                          listener: (context, state) {
                            if (state is HomeLoadingState) {
                              onLoading(context, "Loading..");
                            }
                            if (state is HomeCategoryErrorState) {
                              appRouter.pop();
                              snackBar(context, "${state.error?.message}");
                            }
                            if (state is GetCategorySuccessState) {
                              appRouter.pop();
                              if (state.response?.status == "201") {
                              } else {
                                var response = state.categoryResponse?.data;
                              }
                            } else if (state is GetDistrictSuccessState) {
                              var response = state.response;
                              listDistrictResponse =
                                  state.response?.data?.listDistrict;
                              mapDistrict.clear();
                              listDistrict.clear();
                              setState(() {
                                listDistrictResponse?.forEach((element) {
                                  listDistrict.add(element.name!);
                                  mapDistrict[element.name] = element.id;
                                });
                              });
                            } else if (state is GetPoliceStationSuccessState) {
                              var response = state.response;
                              listPoliceStationResponse =
                                  state.response?.data?.listDistrict;
                              mapPolice.clear();
                              listPoliceStation.clear();
                              setState(() {
                                listPoliceStationResponse?.forEach((element) {
                                  listPoliceStation.add(element.name!);
                                  mapPolice[element.name] = element.id;
                                });
                              });
                            } else if (state is HomeErrorState) {
                              snackBar(context, "${state.error}");
                            }
                          },
                          builder: (context, state) {
                            return Container();
                          },
                        ),
                        CoustomTextFieldEditBox(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          border: Border.all(
                              color: isNameValidate
                                  ? defaultColor
                                  : Colors.transparent),
                          textInputAction: TextInputAction.next,
                          context: context,
                          textInputType: TextInputType.text,
                          inputBorder: InputBorder.none,
                          controller: _nameController,
                          flutterIcon: const Icon(
                            Icons.person,
                            color: defaultColor,
                          ),
                          label: memberName,
                          length: null,
                          validator: (val) {},
                          onChanged: (value) {
                            if (value!.length <= 2) {
                              setState(() {
                                isNameValidate = true;
                              });
                            } else {
                              setState(() {
                                isNameValidate = false;
                              });
                            }
                          },
                          hint: memberHintName,
                          icon: '',
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: skyBlue),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Icon(
                                  Icons.location_city,
                                  color: defaultColor,
                                ),
                              ),
                              Expanded(
                                child: CustomDropdownButton2(
                                  buttonWidth: double.infinity,
                                  hint: 'District',
                                  dropdownItems: listDistrict,
                                  value: selectedDistrict.isEmpty
                                      ? null
                                      : selectedDistrict,
                                  onChanged: (value) {
                                    selectedDistrict = value ?? '';
                                    selectedDistrictId = mapDistrict[value];
                                    var myInt = int.parse(selectedDistrictId!);
                                    if (value != null) {
                                      cubit.getPoliceStation(
                                          myInt, user?.email);
                                    }

                                    setState(() {
                                      selectedPoliceStation = "";
                                    });
                                  },
                                  colorBorder: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: skyBlue),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Icon(
                                  Icons.local_police_outlined,
                                  color: defaultColor,
                                ),
                              ),
                              MediaQuery.removePadding(
                                removeLeft: true,
                                context: context,
                                child: Expanded(
                                  child: CustomDropdownButton2(
                                    buttonWidth: double.infinity,
                                    hint: 'Police Station',
                                    dropdownItems: listPoliceStation,
                                    value: selectedPoliceStation.isEmpty
                                        ? null
                                        : selectedPoliceStation,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedPoliceStation = value ?? '';
                                      });
                                      selectedPoliceStationId =
                                          mapPolice[value];
                                      var myInt =
                                          int.parse(selectedPoliceStationId!);
                                    },
                                    colorBorder: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        BlocConsumer<VdpCommitteeCubit, VdpCommitteeState>(
                          listener: (context, state) {
                            if (state is AddVdpCommitteeSuccessState) {
                              if (state.addVdpCommitteeResponse?.code ==
                                  "Success") {
                                snackBar(context,
                                    "${state.addVdpCommitteeResponse?.message}");
                                appRouter.pop();
                              } else {
                                snackBar(context, "something went wrong !");
                              }
                            }
                          },
                          builder: (context, state) {
                            switch (state.runtimeType) {
                              case AddVdpCommitteeInitialState:
                                return ButtonThemeLarge(
                                    context: context,
                                    color: defaultColor,
                                    label: add,
                                    onClick: () {
                                      if (validateName(_nameController.text)) {
                                        setState(() {
                                          isNameValidate = true;
                                        });
                                      } else if (selectedDistrict.isEmpty ==
                                          true) {
                                        snackBar(context, "Select District");
                                      } else if (selectedPoliceStation
                                              .isEmpty ==
                                          true) {
                                        snackBar(
                                            context, "Select Police station");
                                      } else {
                                        context
                                            .read<VdpCommitteeCubit>()
                                            .addVdpCommittee(
                                            vdpName: _nameController.text,
                                            longitude: long,
                                            latitude: lat,
                                            policeStationId: int.parse(
                                                selectedPoliceStationId!),
                                            districtId: int.parse(
                                                selectedDistrictId!),
                                            status: "true",createdBy: user?.email);
                                      }
                                    });
                              case AddVdpCommitteeLoadingState:
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: defaultColor,
                                  ),
                                );
                              case AddVdpCommitteeSuccessState:
                                return ButtonThemeLarge(
                                    context: context,
                                    color: defaultColor,
                                    label: add,
                                    onClick: () {
                                      if (validateName(_nameController.text)) {
                                        setState(() {
                                          isNameValidate = true;
                                        });
                                      } else if (selectedDistrict.isEmpty ==
                                          true) {
                                        snackBar(context, "Select District");
                                      } else if (selectedPoliceStation
                                              .isEmpty ==
                                          true) {
                                        snackBar(
                                            context, "Select Police station");
                                      } else {
                                        context
                                            .read<VdpCommitteeCubit>()
                                            .addVdpCommittee(
                                            vdpName: _nameController.text,
                                            longitude: long,
                                            latitude: lat,
                                            policeStationId: int.parse(
                                                selectedPoliceStationId!),
                                            districtId: int.parse(
                                                selectedDistrictId!),
                                            status: "true",createdBy: user?.email);
                                      }
                                    });
                              default:
                                return ButtonThemeLarge(
                                    context: context,
                                    color: defaultColor,
                                    label: add,
                                    onClick: () {
                                      if (validateName(_nameController.text)) {
                                        setState(() {
                                          isNameValidate = true;
                                        });
                                      } else if (selectedDistrict.isEmpty ==
                                          true) {
                                        snackBar(context, "Select District");
                                      } else if (selectedPoliceStation
                                              .isEmpty ==
                                          true) {
                                        snackBar(
                                            context, "Select Police station");
                                      } else {
                                        context
                                            .read<VdpCommitteeCubit>()
                                            .addVdpCommittee(
                                            vdpName: _nameController.text,
                                            longitude: long,
                                            latitude: lat,
                                            policeStationId: int.parse(
                                                selectedPoliceStationId!),
                                            districtId: int.parse(
                                                selectedDistrictId!),
                                            status: "true",createdBy: user?.email);
                                      }
                                    });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateName(String value) {
    if (value.isEmpty) {
      return true;
    }
    if (value.length <= 2) {
      return true;
    } else {
      return false;
    }
  }
}
