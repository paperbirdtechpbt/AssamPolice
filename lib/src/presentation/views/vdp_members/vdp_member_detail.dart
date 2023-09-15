import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/get_all_vdp_member.dart';
import '../../../utils/constants/colors.dart';
import '../../cubits/vdp_member/vdp_member_cubit.dart';
import '../../cubits/vdp_member/vdp_member_state.dart';
import '../../widgets/common_widgets.dart';

class VdpMemberDetailView extends StatefulWidget {
   VdpMemberDetailView({super.key,this.getAllVdpMember});
   GetAllVdpMember? getAllVdpMember;

  @override
  State<VdpMemberDetailView> createState() => _VdpMemberDetailViewState(getAllVdpMember);
}

class _VdpMemberDetailViewState extends State<VdpMemberDetailView> {
  GetAllVdpMember? getAllVdpMember;
  _VdpMemberDetailViewState(this.getAllVdpMember);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                appRouter.pop();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 15,
              )),
          title: const Text("VDP Member Details"),
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
                                                Icons.person,
                                                color: Colors.white,
                                              ),
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
                                                          "${getAllVdpMember?.name}",
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
                                              child: const Text("Mobile No: "),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth * 0.40,
                                              child: Text(
                                                  "${getAllVdpMember?.mobileNumber}"),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: const Text("Email: "),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth * 0.40,
                                              child: Text(
                                                  "${getAllVdpMember?.emailId}"),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),

                                        Row(
                                          children: [
                                            Container(
                                              child: const Text("VDP Role: "),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth * 0.40,
                                              child: Text(
                                                  "${getAllVdpMember?.role}"),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: const Text("VDP Committee: "),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth * 0.40,
                                              child: Text(
                                                  "${getAllVdpMember?.vdpCommitteeName}"),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        getAllVdpMember?.createdBy != null ?      Row(
                                          children: [
                                            Container(
                                              child: const Text("Created by: "),
                                            ),
                                            Container(
                                              width: SizeConfig.screenWidth * 0.40,
                                              child: Text(
                                                  "${getAllVdpMember?.createdBy}"),
                                            ),
                                          ],
                                        ) : Container()
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
                                                  EditVdpMemberRoute(
                                                      getAllVdpMember:
                                                      getAllVdpMember)).then((value) => {


                                                map = value as Map?,
                                                if (map?["refreshData"] != null && map?["refreshData"] == "refresh")
                                                  {

                                                    setState(() {
                                                      if (map?["name"] != null)
                                                        getAllVdpMember?.name =  map?["name"];
                                                      if (map?["mobileNumber"] != null)
                                                        getAllVdpMember?.mobileNumber =  map?["mobileNumber"];
                                                      if (map?["emailId"] != null)
                                                        getAllVdpMember?.emailId =  map?["emailId"];
                                                      if (map?["role"] != null)
                                                        getAllVdpMember?.role =  map?["role"];

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
                                                        context.read<VdpMemberCubit>().deleteVdpMember(memberId: getAllVdpMember?.vdpMemberId);
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

              ],
            ),

            BlocConsumer<VdpMemberCubit, VdpMemberState>(
              listener: (context, state) {
                if(state is DeleteVdpMemberSuccessState){
                  if(state.deleteVdpMemberResponse?.code == "Success"){
                    Navigator.of(context)..pop()..pop();
                    snackBar(context, "${state.deleteVdpMemberResponse?.message}");
                  }else {
                    snackBar(context, "${state.deleteVdpMemberResponse?.message}");
                  }
                }
              },
              builder: (context, state) {
                return Container();
              },
            ),
          ],
        ),
       );
  }
}
