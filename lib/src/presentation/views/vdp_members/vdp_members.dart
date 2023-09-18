import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../../config/router/app_router.dart';
import '../../../domain/models/data/category.dart';
import '../../../domain/models/data/district.dart';
import '../../../domain/models/data/get_all_vdp_committee.dart';
import '../../../domain/models/data/get_all_vdp_member.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/vdp_committee/vdp_committee_cubit.dart';
import '../../cubits/vdp_committee/vdp_committee_state.dart';
import '../../cubits/vdp_member/vdp_member_cubit.dart';
import '../../cubits/vdp_member/vdp_member_state.dart';
import '../../widgets/common_widgets.dart';

class VdpMembersListView extends StatefulWidget {
  VdpMembersListView({Key? key, this.getAllVDPCommittee}) : super(key: key);
  GetAllVDPCommittee? getAllVDPCommittee;
  @override
  State<VdpMembersListView> createState() =>
      _VdpMembersListViewState(getAllVDPCommittee);
}

class _VdpMembersListViewState extends State<VdpMembersListView> {
  TextEditingController mobileController = TextEditingController();
  GetAllVDPCommittee? getAllVDPCommittee;

  _VdpMembersListViewState(this.getAllVDPCommittee);
  late List<String> listDistrict = [];
  late List<String> listPoliceStation = [];
  late List<District>? listDistrictResponse = [];
  late List<District>? listPoliceStationResponse = [];
  // late List<String> listPolice = ["BHARALUMUKH"];
  late List<Category>? listCategory = [];
  var mapDistrict = Map();
  var mapPolice = Map();

  String selectedDistrict = "";
  String? selectedDistrictId;

  String selectedPoliceStation = "";
  String? selectedPoliceStationId;
  late var cubit;
  late User? user = User();
  var latitude ;

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeCubit>();
    latitude = getAllVDPCommittee?.latitude;
    getUser();
  }

  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
          setState(() {
            user = data?.user;
            // cubit.getDistrict(user?.email);
            context.read<VdpMemberCubit>().getAllVdpMember(vdpCommitteeId: getAllVDPCommittee?.vdpId);
          })
        });
  }

  List<GetAllVdpMember> member = [];


  Future<bool> onWillPop() {
  // appRouter.replace(VdpCommitteeViewRoute());
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  appRouter.pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                )),
            title: const Text("VDP Details"),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Container(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          width: double.infinity,
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: defaultColor,
                                            child: Icon(
                                              Icons.people_alt_rounded,
                                              color: Colors.white,
                                            ),
                                            // child: Text(
                                            //   firstChar ?? '',
                                            //   style: const TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 20,
                                            //       color: Colors.white),
                                            // ),
                                            maxRadius: 20,
                                            foregroundImage:
                                                NetworkImage("enterImageUrl"),
                                          ),
                                           SizedBox(
                                            width: SizeConfig.screenWidth * 0.020,
                                          ),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            Row(
                                              children: [
                                                Container(
                                                    width:
                                                        SizeConfig.screenWidth * 0.40,
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      "${getAllVDPCommittee?.vdpName}",
                                                      style: styleIbmPlexSansBold(
                                                          size: 18, color: grey),
                                                    )),

                                              ],
                                            ),
                                              const SizedBox(height: 5.0),
                                              Container(
                                                  width:
                                                  SizeConfig.screenWidth * 0.40,
                                                  child: Text(
                                                    overflow: TextOverflow.ellipsis,
                                                    "(Registered)",
                                                    style: styleIbmPlexSansRegular(
                                                        size: 15, color: grey),
                                                  )),
                                          ],)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: const Text("District: "),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.40,
                                            child: Text(
                                                "${getAllVDPCommittee?.districtName}"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: const Text("Police Station: "),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.40,
                                            child: Text(
                                                "${getAllVDPCommittee?.policeStationName}"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: const Text("Latitude & Longitude: "),
                                          ),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.40,
                                            child: Text(
                                                "${double.parse(getAllVDPCommittee?.latitude ?? '0').toStringAsFixed(4)},${double.parse(getAllVDPCommittee?.longitude ?? '0').toStringAsFixed(4)}"),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(
                                        height: 15,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       child: const Text("longitude : "),
                                      //     ),
                                      //     Container(
                                      //       width: SizeConfig.screenWidth * 0.40,
                                      //       child: Text(
                                      //           "${double.parse(getAllVDPCommittee?.longitude ?? '0').toStringAsFixed(4)}"),
                                      //     ),
                                      //
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   height: 15,
                                      // ),

                                    ],
                                  ),
                                  Column(

                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                    InkWell(
                                      onTap: () {},
                                      child: InkWell(
                                        onTap: () {

                                          Map? map;

                                          appRouter.push(
                                              UpdateVdpCommitteeViewRoute(
                                                  getAllVDPCommittee:
                                                  getAllVDPCommittee)).then((value) => {


                                              map = value as Map?,
                                            if (map?["refreshData"] != null && map?["refreshData"] == "refresh")
                                              {

                                                setState(() {
                                                  if (map?["policeStation"] != null)
                                                    getAllVDPCommittee?.policeStationName =  map?["policeStation"];
                                                  if (map?["district"] != null)
                                                    getAllVDPCommittee?.districtName =  map?["district"];
                                                  if (map?["vdpName"] != null)
                                                    getAllVDPCommittee?.vdpName =  map?["vdpName"];
                                                  if (map?["latitude"] != null)
                                                    getAllVDPCommittee?.latitude =  map?["latitude"];
                                                  if (map?["longitude"] != null)
                                                    getAllVDPCommittee?.longitude =  map?["longitude"];
                                                }),


                                                print(
                                                    "Google Map Camera Position Location ====>>>> ${map.toString()}"),
                                                // geoLocation =
                                                //     GeoLocation(
                                                //       photo: selectedFile,
                                                //       lat: location
                                                //           .latitude
                                                //           .toString(),
                                                //       long: location
                                                //           .longitude
                                                //           .toString(),
                                                //       isFileUpload: false,
                                                //       fileStatus: 0,
                                                //     ),
                                              }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Edit",
                                              style: styleIbmPlexSansRegular(
                                                  size: 16,
                                                  color: defaultColor),
                                            ),
                                             SizedBox(
                                              width: SizeConfig.screenWidth * 0.005,
                                            ),
                                            const Icon(
                                              Icons.edit,
                                              color: defaultColor,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    InkWell(
                                      onTap: () async {
                                        final shouldPop = await showDialog<bool>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Delete'),
                                              content: const Text('Are you sure ?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context, false);
                                                  },
                                                  child: const Text(
                                                    'No',

                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    context.read<VdpCommitteeCubit>().deleteVdp(getAllVDPCommittee?.vdpId);
                                                  },
                                                  child: const Text('Yes',style: TextStyle(color: Colors.red),),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [

                                          Text("Delete",style: styleIbmPlexSansRegular(size: 16, color: defaultColor),),
                                          const Icon(Icons.delete,color: defaultColor,size:20 ,),
                                        ],
                                      ),
                                    ),
                                      const SizedBox(
                                        height: 15,
                                      ),


                                  ],),

                                ],
                              ),
                            ),
                          ),
                        ),
                        // sizeHeightBox(),
                        // BlocConsumer<HomeCubit, HomeState>(
                        //   listener: (context, state) {
                        //     if (state is HomeLoadingState) {
                        //       onLoading(context, "Loading..");
                        //     }
                        //     if (state is HomeCategoryErrorState) {
                        //       appRouter.pop();
                        //       snackBar(context, "${state.error?.message}");
                        //       setState(() {
                        //         listCategory = [];
                        //       });
                        //     }
                        //     if (state is GetCategorySuccessState) {
                        //       appRouter.pop();
                        //       if (state.response?.status == "201") {
                        //         setState(() {
                        //           listCategory = [];
                        //         });
                        //       } else {
                        //         var response = state.categoryResponse?.data;
                        //         setState(() {
                        //           listCategory = response?.listCategory;
                        //         });
                        //       }
                        //     } else if (state is GetDistrictSuccessState) {
                        //       var response = state.response;
                        //       listDistrictResponse = state.response?.data?.listDistrict;
                        //       mapDistrict.clear();
                        //       listDistrict.clear();
                        //       setState(() {
                        //         listDistrictResponse?.forEach((element) {
                        //           listDistrict.add(element.name!);
                        //           mapDistrict[element.name] = element.id;
                        //         });
                        //       });
                        //     } else if (state is GetPoliceStationSuccessState) {
                        //       var response = state.response;
                        //       listPoliceStationResponse = state.response?.data?.listDistrict;
                        //       mapPolice.clear();
                        //       listPoliceStation.clear();
                        //       setState(() {
                        //         listPoliceStationResponse?.forEach((element) {
                        //           listPoliceStation.add(element.name!);
                        //           mapPolice[element.name] = element.id;
                        //         });
                        //       });
                        //     } else if (state is HomeErrorState) {
                        //       snackBar(context, "${state.error}");
                        //     }
                        //   },
                        //   builder: (context, state) {
                        //     return Container();
                        //   },
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     left: MediaQuery.of(context).size.width * 0.05,
                        //     right: MediaQuery.of(context).size.width * 0.05,
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Flexible(
                        //         child:
                        //         CustomDropdownButton2(
                        //           buttonWidth: MediaQuery.of(context).size.width * 0.38,
                        //           hint: 'District',
                        //           dropdownItems: listDistrict,
                        //           value: selectedDistrict.isEmpty ? null : selectedDistrict,
                        //           onChanged: (value) {
                        //             selectedDistrict = value ?? '';
                        //             selectedDistrictId = mapDistrict[value];
                        //             var myInt = int.parse(selectedDistrictId!);
                        //             if(value != null){
                        //               cubit.getPoliceStation(myInt, user?.email);
                        //             }
                        //
                        //             setState(() {
                        //
                        //               selectedPoliceStation = "";
                        //             });
                        //           },
                        //           colorBorder: Colors.black38,
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: MediaQuery.of(context).size.width * 0.005,
                        //       ),
                        //       Flexible(
                        //         child: CustomDropdownButton2(
                        //           buttonWidth: MediaQuery.of(context).size.width * 0.38,
                        //           hint: 'Police Station',
                        //           colorBorder: Colors.black38,
                        //           dropdownItems: listPoliceStation,
                        //           value:
                        //           selectedPoliceStation.isEmpty ? null : selectedPoliceStation
                        //           ,
                        //           onChanged: (value) {
                        //             selectedPoliceStationId = mapPolice[value];
                        //             var myInt = int.parse(selectedPoliceStationId!);
                        //             cubit.getCategory(myInt);
                        //             selectedPoliceStation = value!;
                        //           },
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // if (listCategory != null && listCategory!.isNotEmpty) ...[
                        //   Expanded(
                        //       child: GridView.builder(
                        //           gridDelegate:
                        //           const SliverGridDelegateWithFixedCrossAxisCount(
                        //             crossAxisCount: 2,
                        //           ),
                        //           itemCount: listCategory?.length,
                        //           itemBuilder: (BuildContext context, int index) {
                        //             Category? category = listCategory?[index];
                        //
                        //             return InkWell(
                        //               onTap: () {
                        //                 appRouter.push(AddressViewRoute(
                        //                     arguments: Arguments(
                        //                         mobile: '',
                        //                         policeStationId: selectedPoliceStationId,
                        //                         categoryID: category?.categoryId)));
                        //               },
                        //               child: Padding(
                        //                 padding: const EdgeInsets.only(
                        //                     left: 10, right: 10, top: 10, bottom: 15),
                        //                 child: Container(
                        //                   child: Card(
                        //                     color: Colors.white,
                        //                     elevation: 5,
                        //                     shape: const RoundedRectangleBorder(
                        //                         borderRadius:
                        //                         BorderRadius.all(Radius.circular(30))),
                        //                     child: Center(
                        //                         child: Column(
                        //                           mainAxisAlignment: MainAxisAlignment.center,
                        //                           children: [
                        //                             SvgPicture.network("${category!.icon}",
                        //                                 width: 50,
                        //                                 height: 50,
                        //                                 fit: BoxFit.cover,
                        //                                 color: defaultColor),
                        //                             // networkImage(category?.icon, 50, 50),
                        //                             const SizedBox(
                        //                               height: 30,
                        //                             ),
                        //                             Text(
                        //                               "${category.categoryName}",
                        //                               style: styleIbmPlexSansBold(
                        //                                   size: 15, color: black),
                        //                             ),
                        //                           ],
                        //                         )),
                        //                   ),
                        //                 ),
                        //               ),
                        //             );
                        //           }))
                        // ]
                      ],
                    ),
                  )),


                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: BlocConsumer<VdpMemberCubit, VdpMemberState>(
                        listener: (context, state) {
                          if (state is VdpMemberSuccessState) {
                            if (state.getAllVdpMemberResponse?.code ==
                                "Success") {
                              member = state.getAllVdpMemberResponse?.data ?? [];
                            }
                          }
                        },
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case VdpMemberInitialState:
                              return Column(
                                children: List.generate(member.length, (index) {
                                  return membersList(
                                    memberId:member[index].vdpMemberId ,

                                    number: member[index].mobileNumber,
                                    icon: '',
                                    subTitle: member[index].role,
                                    firstChar:
                                        member[index].name?.substring(0, 1).toUpperCase(),
                                    name: member[index].name,
                                    onTap: () {
                                      // appRouter.push(EditVdpMemberRoute(getAllVdpMember: member[index])).then((value) {
                                      //   context.read<VdpMemberCubit>().getAllVdpMember(vdpCommitteeId: getAllVDPCommittee?.vdpId);
                                      //
                                      // });
                                      appRouter.push( VdpMemberDetailViewRoute(getAllVdpMember: member[index])).then((value) {
                                        context.read<VdpMemberCubit>().getAllVdpMember(vdpCommitteeId: getAllVDPCommittee?.vdpId);
                                      });
                                      return null;
                                    },
                                  );
                                }),
                              );
                            case VdpMemberLoadingState:
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: defaultColor,
                                ),
                              );
                            case VdpMemberSuccessState:
                              if(member.isNotEmpty){
                                return Column(
                                  children: List.generate(member.length, (index) {
                                    return membersList(
                                      memberId:member[index].vdpMemberId ,
                                      number: member[index].mobileNumber,
                                      icon: '',
                                      subTitle: member[index].role,
                                      firstChar:
                                      member[index].name?.substring(0, 1).toUpperCase(),
                                      name: member[index].name,
                                      onTap: () {
                                        // appRouter.push(EditVdpMemberRoute(getAllVdpMember: member[index])).then((value) {
                                        //   context.read<VdpMemberCubit>().getAllVdpMember(vdpCommitteeId: getAllVDPCommittee?.vdpId);
                                        //
                                        // });
                                        appRouter.push( VdpMemberDetailViewRoute(getAllVdpMember: member[index])).then((value) {
                                          context.read<VdpMemberCubit>().getAllVdpMember(vdpCommitteeId: getAllVDPCommittee?.vdpId);
                                        });
                                        return null;
                                      },
                                    );
                                  }),
                                );
                              }else {
                                return  Center(
                                  child: Padding(
                                    padding:  EdgeInsets.only(top: SizeConfig.screenHeight * 0.20),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(ic_not_data,color: defaultColor,
                                          height: SizeConfig.screenHeight * 0.20,
                                        ),
                                        Center(child: Text("No Record Found",style: styleIbmPlexSansBold(size: 20, color: defaultColor),),),

                                      ],
                                    ),
                                  ),);                              }

                            default:
                              return Column(
                                children: List.generate(member.length, (index) {
                                  return membersList(
                                    memberId:member[index].vdpMemberId ,

                                    number: member[index].mobileNumber,
                                    icon: '',
                                    subTitle: member[index].role,
                                    firstChar:
                                        member[index].name?.substring(0, 1).toUpperCase(),
                                    name: member[index].name,
                                    onTap: () {
                                      // appRouter.push(EditVdpMemberRoute(getAllVdpMember: member[index])).then((value) {
                                      //   context.read<VdpMemberCubit>().getAllVdpMember(vdpCommitteeId: getAllVDPCommittee?.vdpId);
                                      // });
                                      appRouter.push( VdpMemberDetailViewRoute(getAllVdpMember: member[index])).then((value) {
                                        context.read<VdpMemberCubit>().getAllVdpMember(vdpCommitteeId: getAllVDPCommittee?.vdpId);
                                      });
                                      return null;
                                    },
                                  );
                                }),
                              );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),

              BlocConsumer<VdpCommitteeCubit, VdpCommitteeState>(
                listener: (context, state) {
                  if(state is DeleteVdpSuccessState){
                    if(state.deleteVdpCommitteeResponse?.code == "Success"){
                      Navigator.of(context)..pop()..pop();

                      snackBar(context, "${state.deleteVdpCommitteeResponse?.message}");

                    }else {
                      snackBar(context, "${state.deleteVdpCommitteeResponse?.message}");
                    }
                  }
                },
                builder: (context, state) {
                  return Container();
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: defaultColor,
            foregroundColor: Colors.white,
            onPressed: () {
              appRouter.push( AddVdpMemberRoute(getAllVDPCommittee: getAllVDPCommittee)).then((value) {
                context.read<VdpMemberCubit>().getAllVdpMember(vdpCommitteeId: getAllVDPCommittee?.vdpId);
              });
            },
            label: const Text('Add'),
            icon: const Icon(Icons.add),
          )),
    );
  }

  membersList({
    Icon? flutterIcon,
    String? icon,
    String? name,
    Function? onTap()?,
    String? subTitle,
    String? firstChar,
    String? subject,
    String? number,
    int? memberId,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              // so here your custom shadow goes:
              BoxShadow(
                color: Colors.black.withAlpha(4),
                blurRadius: 0.5,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: ListTile(
            subtitle: Container(
              padding: const EdgeInsets.only(top: 7,bottom: 7),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.40,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            name ?? '',
                            style: styleIbmPlexSansBold(size: 16, color: grey),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            UrlLauncher.launch("tel://$number");
                          },
                          child: Container(

                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              number ?? '',
                              style: styleIbmPlexSansBold(size: 16, color: grey),
                            ),
                          ),
                        ),
                      ],),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              subTitle ?? '',
                              style:
                                  styleIbmPlexSansRegular(size: 14, color: grey),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 5.0,
                      // ),
                      // Container(
                      //   width: SizeConfig.screenWidth * 0.40,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         overflow: TextOverflow.ellipsis,
                      //         number ?? '',
                      //         style:
                      //         styleIbmPlexSansRegular(size: 14, color: grey),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // MaterialButton(
                //   minWidth: 30,
                //   height: 25,
                //
                //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                //   onPressed: () async {
                //
                //     final shouldPop = await showDialog<bool>(
                //       context: context,
                //       builder: (context) {
                //         return AlertDialog(
                //           title: const Text('Delete'),
                //           content: const Text('Are you sure ?'),
                //           actions: [
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.pop(context, false);
                //               },
                //               child: const Text(
                //                 'No',
                //
                //               ),
                //             ),
                //             TextButton(
                //               onPressed: () {
                //                 appRouter.pop();
                //               },
                //               child: const Text('Yes',style: TextStyle(color: Colors.red),),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //
                //
                //   },child: Row(
                //   children: [
                //     const Icon(Icons.delete,color: defaultColor,size:20 ,),
                //     Text("Delete",style: styleIbmPlexSansRegular(size: 13, color: defaultColor),),
                //   ],
                // ),)
              ],
            )),
            leading: icon!.isEmpty
                ? CircleAvatar(
                    backgroundColor: defaultColor,
                    child: Text(
                      firstChar ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    maxRadius: 20,
                    foregroundImage: const NetworkImage("enterImageUrl"),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(icon),
                  ),
          ),
        ),
      ),
    );
  }
}
