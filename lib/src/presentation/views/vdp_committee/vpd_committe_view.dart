import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/arguments.dart';
import '../../../domain/models/data/category.dart';
import '../../../domain/models/data/district.dart';
import '../../../domain/models/data/get_all_vdp_committee.dart';
import '../../../domain/models/data/user.dart';
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

class VdpCommitteeView extends StatefulWidget {
  const VdpCommitteeView({Key? key}) : super(key: key);

  @override
  State<VdpCommitteeView> createState() => _VdpCommitteeViewState();
}

class _VdpCommitteeViewState extends State<VdpCommitteeView> {
  TextEditingController mobileController = TextEditingController();


  late List<GetAllVDPCommittee>? getAllVdpCommittee = [];
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
  @override
  void initState() {
    super.initState();
    cubit = context.read<VdpCommitteeCubit>();
    getUser();
  }

  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) =>
    {
      setState(() {
        user = data?.user;
       cubit.getAllVdpCommittee();
      })
    });
  }


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
          title: const Text("VdP Committee"),
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  sizeHeightBox(),
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
                        listDistrictResponse = state.response?.data?.listDistrict;
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
                        listPoliceStationResponse = state.response?.data?.listDistrict;
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
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child:
                          CustomDropdownButton2(
                            buttonWidth: MediaQuery.of(context).size.width * 0.38,
                            hint: 'District',
                            dropdownItems: listDistrict,
                            value: selectedDistrict.isEmpty ? null : selectedDistrict,
                            onChanged: (value) {
                              selectedDistrict = value ?? '';
                              selectedDistrictId = mapDistrict[value];
                              var myInt = int.parse(selectedDistrictId!);
                              if(value != null){
                                cubit.getPoliceStation(myInt, user?.email);
                              }

                              setState(() {

                                selectedPoliceStation = "";
                              });
                            },
                            colorBorder: Colors.black38,
                          ),
                        ),

                        SizedBox(
                          width: SizeConfig.screenWidth* 0.002,
                        ),
                        Flexible(
                          child: CustomDropdownButton2(
                            buttonWidth: MediaQuery.of(context).size.width * 0.38,
                            hint: 'Police Station',
                            colorBorder: Colors.black38,
                            dropdownItems: listPoliceStation,
                            value:
                            selectedPoliceStation.isEmpty ? null : selectedPoliceStation
                            ,
                            onChanged: (value) {
                              selectedPoliceStationId = mapPolice[value];
                              var myInt = int.parse(selectedPoliceStationId!);
                              cubit.getCategory(myInt);
                              selectedPoliceStation = value!;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizeHeightBox(),
                          BlocConsumer<VdpCommitteeCubit, VdpCommitteeState>(
                            listener: (context, state) {
                              if (state is VdpCommitteeLoadingState) {
                              }
                              if (state is  VdpCommitteeErrorState) {
                                appRouter.pop();
                                snackBar(context, "${state.error?.message}");
                              }
                              if (state is  VdpCommitteeSuccessState) {
                                getAllVdpCommittee = state.getAllVDPCommitteeResponse?.data;

                              }
                            },
                            builder: (context, state) {
                           switch(state.runtimeType){
                             case VdpCommitteeInitialState :    return   Expanded(
                               child: SingleChildScrollView(
                                 child: Column(children: List.generate(getAllVdpCommittee?.length ?? 0, (index) {
                                   return VdpCommitteeView(
                                     icon: '',
                                     subTitle: "VDP",
                                     firstChar: getAllVdpCommittee![index].vdpName?.substring(0, 1),
                                     name: getAllVdpCommittee![index].vdpName,
                                     onTap: () {
                                       appRouter
                                           .push(EditMembersAddressRoute());
                                     },
                                   );
                                 }),),
                               ),
                             );
                             case VdpCommitteeLoadingState  :  return const Center(child: CircularProgressIndicator(color: defaultColor,),);
                             case VdpCommitteeSuccessState :    return   SingleChildScrollView(
                               child: Column(children: List.generate(getAllVdpCommittee?.length ?? 0, (index) {
                                 return VdpCommitteeView(
                                   icon: '',
                                   subTitle: "VDP",
                                   firstChar: getAllVdpCommittee![index].vdpName?.substring(0, 1).toUpperCase(),
                                   name: getAllVdpCommittee![index].vdpName,

                                     policeStation: getAllVdpCommittee![index].policeStation,
                                   onTap: (){
                                     appRouter
                                         .push(VdpMembersListViewRoute());
                                   }
                                 );
                               }),),
                             );
                             default : return Container();
                           }
                            },
                          ),


                        ],
                      )),


                ],
              ),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: defaultColor,
          foregroundColor: Colors.white,
          onPressed: () {
            appRouter.push(const AddVdpCommitteeViewRoute());
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ));
  }

  VdpCommitteeView({
    Icon? flutterIcon,
    String? icon,
    String? name,
    Function? onTap()?,
    Function? onEdit()?,
    String? subTitle,
    String? firstChar,
    String? subject,
    String? policeStation,
  }) {
    return InkWell(
      onTap: onTap,
      child:  Card(
        elevation: 3,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    icon!.isEmpty
                        ? CircleAvatar(
                      backgroundColor: defaultColor,
                      child: Icon(Icons.people_alt_rounded,color: Colors.white,),
                      // child: Text(
                      //   firstChar ?? '',
                      //   style: const TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 20,
                      //       color: Colors.white),
                      // ),
                      maxRadius: 20,
                      foregroundImage: NetworkImage("enterImageUrl"),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(Icons.people_alt_rounded),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(child: Text(name ?? '',style: styleIbmPlexSansBold(size: 16, color: grey),),),
                          SizedBox(height: 5,),
                          Container(child: Text(policeStation ?? '',style: styleIbmPlexSansRegular(size: 16, color: grey),),),
                        ],),
                    ),

                  ],),
                MaterialButton(
                  minWidth: 30,
                  height: 25,

                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  onPressed: (){},child: Text("Delete",style: styleIbmPlexSansRegular(size: 16, color: defaultColor),),)
              ],
            ),
          )
      ),

    );
  }
}