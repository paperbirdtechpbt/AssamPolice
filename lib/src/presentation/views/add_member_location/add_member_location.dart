import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/src/presentation/cubits/home/home_cubit.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/district.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/home/home_state.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/custom_dropdown.dart';

class AddMemberLocation extends StatefulWidget {
  const AddMemberLocation({super.key});

  @override
  State<AddMemberLocation> createState() => _AddMemberLocationState();
}

class _AddMemberLocationState extends State<AddMemberLocation> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: [
                Image.asset(
                  ic_logo_png,
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 15
                  ,),
                Container(
                  width: 350,
                  child: Text(
                    "ASSAM POLICE",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.red.shade700,
                        fontFamily: ibmPlexSansRegular
                    ),textAlign: TextAlign.center,),
                ),


SizedBox(
  height: 40,
),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          appRouter.push(VdpCommitteeViewRoute());
                        },
                        child: Container(
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
                              const Icon(Icons.person,
                                  size: 33, color: defaultColor),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Add member",
                                style: styleIbmPlexSansRegular(
                                    size: 13, color: grey),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
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
                                const Icon(Icons.location_on,
                                    size: 33, color: defaultColor),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Add Location of the VDP Committee",
                                  style: styleIbmPlexSansRegular(
                                      size: 13, color: grey),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            appRouter.push(AddLocationScreenRoute());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Container(
                    height: 80,
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
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Text(
                            "View or send message",
                            style:
                                styleIbmPlexSansRegular(size: 13, color: grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    appRouter.push(InBoxScreenRoute());
                  },
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top:60.0),
                //   child: Container(child: Text("Now you can add a member or location",style: styleIbmPlexSansRegular(size: 16, color: defaultColor),),),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
