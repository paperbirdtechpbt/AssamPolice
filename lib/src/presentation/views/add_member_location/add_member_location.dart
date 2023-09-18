import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/home/home_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/district.dart';
import '../../../domain/models/data/get_user_menu_option.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/home/home_state.dart';
import '../../cubits/user_menu_option/user_menu_option_cubit.dart';
import '../../cubits/user_menu_option/user_menu_option_state.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/custom_dropdown.dart';

class AddMemberLocation extends StatefulWidget {
  const AddMemberLocation({super.key});

  @override
  State<AddMemberLocation> createState() => _AddMemberLocationState();
}

class _AddMemberLocationState extends State<AddMemberLocation> {


  late User? user = User();
  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
      setState(() {
        user = data?.user;
      }),
      context.read<UserMenuOptionCubit>().getUserMenuOptions(user?.email, 5),
    });

  }
  @override
  void initState() {
    getUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Column(
         children: <Widget>[


           Padding(
             padding: const EdgeInsets.only(top: 100.0),
             child:

             BlocConsumer<UserMenuOptionCubit, UserMenuOptionState>(
               listener: (context, state) {
                 if(state is UserMenuOptionSuccessState){
                   if(state.getUserMenuOptionResponse?.code == "Success"){
                 // state.getUserMenuOptionResponse?.data ?? [];
                   }else {
                     snackBar(context, state.getUserMenuOptionResponse?.message ?? '');
                   }
                 }
               },
               builder: (context, state) {
                switch(state.runtimeType){
                  case UserMenuOptionLoadingState : return Center(child: CircularProgressIndicator(color: defaultColor,));
                  case UserMenuOptionSuccessState :  return Column(
                    children: [


                      Image.asset(
                        ic_logo_png,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 350,
                        child: Text(
                          "ASSAM POLICE",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.red.shade700,
                              fontFamily: ibmPlexSansRegular),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                               Row(
                              children: [
                                state.getUserMenuOptionResponse?.data![0].vdpCommittee == 0 ?  InkWell(
                                 onTap: () {
                                   appRouter.push(VdpCommitteeViewRoute(isDashBoard: true));
                                 },
                                 child: Container(
                                   height: 120,
                                   width: SizeConfig.screenWidth * 0.45,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(12),
                                     color: Colors.white,
                                     boxShadow: [
                                       BoxShadow(
                                         color: Colors.grey.withOpacity(0.3),
                                         spreadRadius: 1,
                                         blurRadius: 2,
                                         offset: const Offset(0, 1),
                                       ),
                                     ],
                                   ),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       const Icon(Icons.person,
                                           size: 33, color: defaultColor),
                                       const SizedBox(
                                         height: 20.0,
                                       ),
                                       Text(
                                         "VDP Committee",
                                         style: styleIbmPlexSansBold(
                                             size: 15, color: Colors.black),
                                       ),
                                     ],
                                   ),
                                 ),
                               ) : Container() ,
                                const SizedBox(
                                  width: 10,
                                ),
                                state.getUserMenuOptionResponse?.data![0].message == 0 ?      InkWell(
                                  child: Container(
                                    height: 120,
                                    width: SizeConfig.screenWidth * 0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.message,
                                            size: 33, color: defaultColor),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20),
                                          child: Text(
                                            "Messages",
                                            style: styleIbmPlexSansBold(
                                                size: 15, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    appRouter.push(InBoxScreenRoute());
                                  },
                                ) : Container(),
                                // Expanded(
                                //   child: InkWell(
                                //     child: Container(
                                //       height: 120,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(12),
                                //         color: Colors.white,
                                //         boxShadow: [
                                //           BoxShadow(
                                //             color: Colors.grey.withOpacity(0.3),
                                //             spreadRadius: 1,
                                //             blurRadius: 2,
                                //             offset: const Offset(0, 1),
                                //           ),
                                //         ],
                                //       ),
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //         children: [
                                //           const Icon(Icons.location_on,
                                //               size: 33, color: defaultColor),
                                //           const SizedBox(
                                //             height: 20.0,
                                //           ),
                                //           Text(
                                //             "Add Location of the VDP Committee",
                                //             style: styleIbmPlexSansRegular(
                                //                 size: 13, color: grey),
                                //             textAlign: TextAlign.center,
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //     onTap: () async {
                                //       appRouter.push(AddLocationScreenRoute());
                                //     },
                                //   ),
                                // ),
                              ],
                            ) ,
                            const SizedBox(
                              height: 10.0,
                            ),
                                      Row(
                              children: [
                                state.getUserMenuOptionResponse?.data![0].sos == 0 ?       InkWell(
                                  onTap: () {

                                    snackBar(context, 'coming soon...');
                                  },
                                  child: Container(
                                    width: SizeConfig.screenWidth * 0.45,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(ic_menu_sos,
                                            height: 25,
                                            width: 25,
                                            color: defaultColor),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          "SOS",
                                          style: styleIbmPlexSansBold(
                                              size: 15, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ) : Container(),
                                const SizedBox(
                                  width: 10,
                                ),
                                state.getUserMenuOptionResponse?.data![0].logout == 0 ?     InkWell(
                                  child: Container(
                                    width: SizeConfig.screenWidth * 0.45,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.login,
                                            size: 33, color: defaultColor),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20),
                                          child: Text(
                                            "Logout",
                                            style: styleIbmPlexSansBold(
                                                size: 15, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: const [
                                                  Icon(Icons.exit_to_app_sharp, color: defaultColor),
                                                  SizedBox(width: 10),
                                                  Text('Logout',
                                                      style:
                                                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                ]),
                                            content: const Text('Are you sure you want to Logout?'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('No',
                                                    style: TextStyle(fontSize: 15, color: primaryColor)),
                                                onPressed: () {
                                                  Navigator.of(context).pop(false); //Will not exit the App
                                                },
                                              ),
                                              TextButton(
                                                child: const Text(
                                                  'Yes',
                                                  style: TextStyle(fontSize: 15, color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  var  preff =MySharedPreference();
                                                  preff.clear();
                                                  appRouter.pushAndPopUntil(const LoginViewRoute(),
                                                      predicate: (Route<dynamic> route) => true);
                                                },
                                              )
                                            ],
                                          );
                                        });

                                  },
                                ) : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                  default : return Container();
                }
               },
             ),
           ),
         ],
       ),
     );
   }

}
