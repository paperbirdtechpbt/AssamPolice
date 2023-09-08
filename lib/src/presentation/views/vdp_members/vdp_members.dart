import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/arguments.dart';
import '../../../domain/models/data/category.dart';
import '../../../domain/models/data/district.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/home/home_state.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/custom_dropdown.dart';

class VdpMembersListView extends StatefulWidget {
  const VdpMembersListView({Key? key}) : super(key: key);

  @override
  State<VdpMembersListView> createState() => _VdpMembersListViewState();
}

class _VdpMembersListViewState extends State<VdpMembersListView> {
  TextEditingController mobileController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    cubit = context.read<HomeCubit>();
    getUser();
  }

  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) =>
    {
      setState(() {
        user = data?.user;
        cubit.getDistrict('anil@assampolice.org');
      })
    });
  }

  List<String> members = [
    "Rahul",
    "Chandan",
    "Gautam",
    "Raghu",
    "Anilbhai",
    "Krishi",
    "Ravi",
    "Anilbhai",
    "Krishi",
    "Ravi"
        "Chandan",
    "Gautam",
  ];

  List<String> message = [
    "To handle the scenario where the",
    "user taps outside the container and ",
    "you want to make the container invisible",
    "you can use a GestureDetector to detect",
    "taps outside the container and then",
    "update the visibility state",
    "the container accordingly.",
    "you can use a GestureDetector to detect",
    "To handle the scenario where the",
    "taps outside the container and then",
    "data:image/png;base64,iVBORw0KGgoAAAANSUh",
    'padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),'
  ];

  List<String> subject = [
    "Gaming",
    "music",
    "dance",
    "impoetant",
    "holiday",
    "Gaming",
    "music",
    "dance",
    "important",
    "holiday",
    "Gaming",
    "music",
  ];
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
          title: Text("Members"),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                            height: 140,

                            width: double.infinity,
                            child: Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
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
                                        ),
SizedBox(width: 10,),
                                        Container(width: SizeConfig.screenWidth * 0.25,
                                            child: Text("Vdp one",style: styleIbmPlexSansBold(size: 18, color: grey),)),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: InkWell(
                                        onTap: (){

                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.edit,color: defaultColor,),
                                            SizedBox(width: 5,),
                                            Text("Edit",style: styleIbmPlexSansRegular(size: 16, color: defaultColor),),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                                SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(child: Text("PoliceStation :"),),
                                          Container(width: SizeConfig.screenWidth * 0.40,child: Text(" BHARALUMUKH"),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(child: Text("District :"),),
                                          Container(width: SizeConfig.screenWidth * 0.40,child: Text(" Guwahati West"),),
                                        ],
                                      ),

                                    ],
                                  ),
                                )
                          ],),
                            ),)
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
                SizedBox(height:20,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: List.generate(members.length, (index) {
                      return membersList(
                        icon: '',
                        subTitle: "VDP",
                        firstChar: members[index].substring(0, 1),
                        name: members[index],
                        onTap: () {
                          appRouter
                              .push(EditMembersAddressRoute());
                        },
                      );
                    }),),
                  ),
                )
              ],
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: defaultColor,
          foregroundColor: Colors.white,
          onPressed: () {
            appRouter.push(AddMemberScreenRoute());
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ));
  }

  membersList({
    Icon? flutterIcon,
    String? icon,
    String? name,
    Function? onTap()?,
    String? subTitle,
    String? firstChar,
    String? subject,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.40,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            name ?? '',
                            style: styleIbmPlexSansBold(size: 16, color: grey),
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Container(
                          width: SizeConfig.screenWidth * 0.40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                  "President",
                                style: styleIbmPlexSansRegular(size: 14, color: grey),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                    MaterialButton(
                      minWidth: 30,
                      height: 25,

                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: (){},child: Text("Delete",style: styleIbmPlexSansRegular(size: 16, color: defaultColor),),)
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
              foregroundImage: NetworkImage("enterImageUrl"),
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