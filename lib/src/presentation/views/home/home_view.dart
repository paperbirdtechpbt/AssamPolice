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

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController mobileController = TextEditingController();

  late List<String> listDistrict = [];
  late List<String> listPoliceStation = [];
  late List<District>? listDistrictResponse = [];
  late List<District>? listPoliceStationResponse = [];
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
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
          setState(() {
            user = data?.user;
            cubit.getDistrict(user?.email);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        "Geo Tagging",
                        style:
                            styleIbmPlexSansLite(size: 20, color: defaultColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          sizeHeightBox(),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeLoadingState) {
                onLoading(context, "Loading..");
              }
              if (state is HomeCategoryErrorState) {
                appRouter.pop();
                snackBar(context, "${state.error?.message}");
                setState(() {
                  listCategory = [];
                });
              }
              if (state is GetCategorySuccessState) {
                appRouter.pop();
                if (state.response?.status == "201") {
                  setState(() {
                    listCategory = [];
                  });
                } else {
                  var response = state.categoryResponse?.data;
                  setState(() {
                    listCategory = response?.listCategory;
                  });
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child:
                  CustomDropdownButton2(
                    buttonWidth: MediaQuery.of(context).size.width * 0.38,
                    hint: 'District',
                    dropdownItems: listDistrict,
                    value:
                        selectedDistrict.isNotEmpty ? selectedDistrict : null,
                    onChanged: (value) {
                      selectedDistrictId = mapDistrict[value];
                      var myInt = int.parse(selectedDistrictId!);
                      cubit.getPoliceStation(myInt, user?.email);
                      selectedDistrict = value!;
                      setState(() {
                        selectedPoliceStation = "";
                      });
                    },
                    colorBorder: Colors.black38,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.005,
                ),
                Flexible(
                  child: CustomDropdownButton2(
                    buttonWidth: MediaQuery.of(context).size.width * 0.38,
                    hint: 'Police Station',
                    colorBorder: Colors.black38,
                    dropdownItems: listPoliceStation,
                    value: selectedPoliceStation.isNotEmpty
                        ? selectedPoliceStation
                        : null,
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
          if (listCategory != null && listCategory!.isNotEmpty) ...[
            Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: listCategory?.length,
                    itemBuilder: (BuildContext context, int index) {
                      Category? category = listCategory?[index];

                      return InkWell(
                        onTap: () {
                          appRouter.push(AddressViewRoute(
                              arguments: Arguments(
                                  mobile: '',
                                  policeStationId: selectedPoliceStationId,
                                  categoryID: category?.categoryId)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 15),
                          child: Container(
                            child: Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.network("${category!.icon}",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      color: defaultColor),
                                  // networkImage(category?.icon, 50, 50),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "${category.categoryName}",
                                    style: styleIbmPlexSansBold(
                                        size: 15, color: black),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                      );
                    }))
          ]
        ],
      ),
    )));
  }
}
