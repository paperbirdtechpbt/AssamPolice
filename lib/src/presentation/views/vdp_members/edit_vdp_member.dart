import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/get_all_vdp_member.dart';
import '../../../domain/models/data/get_all_vdp_roles.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/vdp_member/vdp_member_cubit.dart';
import '../../cubits/vdp_member/vdp_member_state.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/custom_dropdown.dart';

class EditVdpMember extends StatefulWidget {
   EditVdpMember({super.key,this.getAllVdpMember});
 GetAllVdpMember? getAllVdpMember;
  @override
  State<EditVdpMember> createState() => _EditVdpMemberState(getAllVdpMember);
}

class _EditVdpMemberState extends State<EditVdpMember> {
  _EditVdpMemberState(this.getAllVdpMember);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetAllVdpMember? getAllVdpMember;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

// validator var
  bool isNameValidate = false;
  bool isEmailValidate = false;
  bool isMobileValidate = false;
  bool isAddressValidate = false;
  bool isRemarkValidate = false;

  List<String> listStatus = ["True", "False"];
  List<GetAllVdpRoles> listRoles = [];
  List<String> listRolesString = [];
  String selectedStatus = '';
  String selectedRoles = '';
  var mapRole = Map();
  int? selectedRoleId ;

  @override
  void initState() {
    context.read<VdpMemberCubit>().getVdpMemberRoles();

    getUser();

    super.initState();
  }

  late User? user = User();
  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) =>
    {
      setState(() {
        user = data?.user;
        _nameController.text = getAllVdpMember?.name ?? '';
        _mobileController.text = getAllVdpMember?.mobileNumber ?? '';
        _emailController.text = getAllVdpMember?.emailId ?? '';
        selectedRoles = getAllVdpMember?.role ?? '';
        selectedRoleId = getAllVdpMember?.vdpRoleId;
      })
    });
  }


  Future<bool> onWillPop() {
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit VDP Member",
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
                            if (value!.length <= 0) {
                              setState(() {
                                isNameValidate = false;
                              });
                            }
                            else if (value!.length <= 2) {
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

                        CoustomTextFieldEditBox(
                          border: Border.all(
                              color: isMobileValidate ? defaultColor : Colors
                                  .transparent),
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          context: context,
                          controller: _mobileController,
                          label: memberMobile,
                          length: 10,
                          onChanged: (value) {
                            if (value!.length <= 0) {
                              setState(() {
                                isMobileValidate = false;
                              });
                            }
                            else if (value!.length <= 2) {
                              setState(() {
                                isMobileValidate = true;
                              });
                            } else {
                              setState(() {
                                isMobileValidate = false;
                              });
                            }
                          },
                          validator: (val) {
                            if (val!.length <= 2) {
                              setState(() {
                                isMobileValidate = true;
                              });
                            }
                            return null;
                          },
                          hint: memberHintMobile,
                          icon: ic_phone,
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        CoustomTextFieldEditBox(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          border: Border.all(
                              color:
                              isEmailValidate ? defaultColor
                                  : Colors.transparent),
                          textInputAction: TextInputAction.next,
                          context: context,
                          textInputType: TextInputType.emailAddress,
                          inputBorder: InputBorder.none,
                          controller: _emailController,
                          flutterIcon: const Icon(
                            Icons.person,
                            color: defaultColor,
                          ),
                          label: memberEmail,
                          length: null,
                          validator: (val) {},
                          onChanged: (value) {
                            if (value!.length <= 0) {
                              setState(() {
                                isEmailValidate = false;
                              });
                            }
                            else if (value!.length <= 2) {
                              setState(() {
                                isEmailValidate = true;
                              });
                            } else {
                              setState(() {
                                isEmailValidate = false;
                              });
                            }
                          },
                          hint: memberEmail,
                          icon: '',
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        BlocConsumer<VdpMemberCubit, VdpMemberState>(
                          listener: (context, state) {
                            if(state is GetVdpMemberRolesSuccessState){
                              if(state.getAllVdpRolesResponse?.code == "Success"){
                                listRoles = state.getAllVdpRolesResponse?.data ?? [];

                                listRoles.forEach((element) {
                                  listRolesString.add(element.role.toString());


                                  mapRole.clear();
                                  listRolesString.clear();
                                  setState(() {
                                    listRoles?.forEach((element) {
                                      listRolesString.add(element.role!);
                                      mapRole[element.role] = element.vdpRoleId;
                                    });
                                  });
                                });
                              }
                            }
                          },
                          builder: (context, state) {
                            return Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
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
                                        hint: 'Role',
                                        dropdownItems: listRolesString,
                                        value: selectedRoles.isEmpty
                                            ? null
                                            : selectedRoles,
                                        onChanged: (value) {

                                          setState(() {
                                            selectedRoleId = mapRole[value];
                                            selectedRoles = value ?? '';
                                          });
                                        },
                                        colorBorder: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        // Container(
                        //   decoration: const BoxDecoration(
                        //       borderRadius: BorderRadius.all(
                        //           Radius.circular(10.0)),
                        //       color: skyBlue),
                        //   child: Row(
                        //     children: [
                        //       const Padding(
                        //         padding: EdgeInsets.only(left: 20.0),
                        //         child: Icon(
                        //           Icons.local_police_outlined,
                        //           color: defaultColor,
                        //         ),
                        //       ),
                        //       MediaQuery.removePadding(
                        //         removeLeft: true,
                        //         context: context,
                        //         child: Expanded(
                        //           child: CustomDropdownButton2(
                        //             buttonWidth: double.infinity,
                        //             hint: 'Status',
                        //             dropdownItems: listStatus,
                        //             value: selectedStatus.isEmpty
                        //                 ? null
                        //                 : selectedStatus,
                        //             onChanged: (value) {
                        //               setState(() {
                        //                 selectedStatus = value ?? '';
                        //               });
                        //             },
                        //             colorBorder: Colors.transparent,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
                          height: 25,
                        ),
                        // CoustomTextFieldEditBox(
                        //   textInputType: TextInputType.phone,
                        //   textInputAction: TextInputAction.next,
                        //   context: context,
                        //   controller: _ageController,
                        //   flutterIcon: const Icon(
                        //     Icons.calendar_today_rounded,
                        //     color: defaultColor,
                        //   ),
                        //   label: memberAge,
                        //   length: null,
                        //   validator: (val) {
                        //     if (val!.length <= 2) return '';
                        //     return null;
                        //   },
                        //   hint: memberHintAge,
                        //   icon: '',
                        // ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        // CoustomTextFieldEditBox(
                        //   border: Border.all(color: isMobileValidate ? defaultColor : Colors.transparent),
                        //   textInputType: TextInputType.phone,
                        //   textInputAction: TextInputAction.next,
                        //   context: context,
                        //   controller: _mobileController,
                        //   label: memberMobile,
                        //   length: null,
                        //   onChanged: (value){
                        //     if (value!.length <= 2){
                        //       setState(() {
                        //         isMobileValidate = true;
                        //       });
                        //     }else {
                        //       setState(() {
                        //         isMobileValidate = false;
                        //       });
                        //     }
                        //
                        //   },
                        //   validator: (val) {
                        //     if (val!.length <= 2) {
                        //       setState(() {
                        //         isMobileValidate = true;
                        //       });
                        //     }
                        //     return null;
                        //   },
                        //   hint: memberHintMobile,
                        //   icon: ic_phone,
                        // ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         border: Border.all(
                        //             color: isAddressValidate
                        //                 ? defaultColor
                        //                 : Colors.transparent),
                        //         borderRadius: const BorderRadius.all(
                        //             const Radius.circular(10.0)),
                        //         color: skyBlue),
                        //     padding:
                        //     const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        //     child: Container(
                        //         width: double.infinity,
                        //         height: MediaQuery.of(context).size.height * 0.13,
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             const Icon(
                        //               Icons.location_pin,
                        //               color: defaultColor,
                        //             ),
                        //             Expanded(
                        //               child: Padding(
                        //                 padding:
                        //                 const EdgeInsets.only(left: 10.0),
                        //                 child: TextFormField(
                        //                   textInputAction: TextInputAction.next,
                        //                   keyboardType: TextInputType.text,
                        //                   maxLines: null,
                        //                   enableSuggestions: false,
                        //                   autocorrect: false,
                        //                   decoration: InputDecoration(
                        //                     border: InputBorder.none,
                        //                     hintText: "Address",
                        //                     hintStyle: styleIbmPlexSansRegular(
                        //                         size: 16, color: grey),
                        //                     contentPadding: EdgeInsets.zero,
                        //                     isDense: true,
                        //                   ),
                        //                   controller: _addressController,
                        //                   cursorColor: defaultColor,
                        //                   onChanged: (value){
                        //                     if (value!.length <= 2){
                        //                       setState(() {
                        //                         isAddressValidate = true;
                        //                       });
                        //                     }else {
                        //                       setState(() {
                        //                         isAddressValidate = false;
                        //                       });
                        //                     }
                        //
                        //                   },
                        //                   validator: (val) {
                        //                     if (val!.length <= 2)  return '';
                        //                     return null;
                        //                   },
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         )),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        // CoustomTextFieldEditBox(
                        //   border: Border.all(color: isRemarkValidate ? defaultColor : Colors.transparent),
                        //   textInputAction: TextInputAction.done,
                        //   onChanged: (value){
                        //     if (value!.length <= 2){
                        //       setState(() {
                        //         isRemarkValidate = true;
                        //       });
                        //     }else {
                        //       setState(() {
                        //         isRemarkValidate = false;
                        //       });
                        //     }
                        //
                        //   },
                        //   context: context,
                        //   controller: _remarkController,
                        //   flutterIcon: const Icon(
                        //     Icons.area_chart,
                        //     color: defaultColor,
                        //   ),
                        //   label: memberAddress,
                        //   length: null,
                        //   validator: (val) {
                        //     if (val!.length <= 2)  {
                        //       setState(() {
                        //         isRemarkValidate = true;
                        //       });
                        //     }
                        //     return null;
                        //   },
                        //   hint: memberHintRemark,
                        //   icon: '',
                        //   textInputType: TextInputType.text,
                        // ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                        BlocConsumer<VdpMemberCubit, VdpMemberState>(
                          listener: (context, state) {
                            if(state is UpdateVdpMemberSuccessState){
                              if(state.updateVdpMemberResponse?.code == "Success"){
                                appRouter.pop({
                                  "refreshData": "refresh" ,
                                  "name": _nameController.text,
                                  "mobileNumber": _mobileController.text,
                                  "role": selectedRoles,
                                  'emailId' : _emailController.text,
                                });
                                snackBar(context, "${state.updateVdpMemberResponse?.message}");

                                // context.read<VdpMemberCubit>().getAllVdpMember();
                              }else {
                                snackBar(context, "${state.updateVdpMemberResponse?.message}");
                              }
                            }
                          },
                          builder: (context, state) {
                            switch(state.runtimeType){
                              case UpdateVdpMemberInitialState : return ButtonThemeLarge(
                                  context: context,
                                  color: defaultColor,
                                  label: save,
                                  onClick: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (validateName(_nameController.text)) {
                                        setState(() {
                                          isNameValidate = true;
                                        });
                                      } else
                                      if (validateMobile(_mobileController.text)) {
                                        setState(() {
                                          isMobileValidate = true;
                                        });
                                      }else
                                      if (validateEmail(_emailController.text)) {
                                        setState(() {
                                          isEmailValidate = true;
                                        });
                                      }else {
                                        context.read<VdpMemberCubit>().updateVdpMember(vdpMemberId: getAllVdpMember?.vdpMemberId ?? 0 ,vdpCommitteeId: getAllVdpMember?.vdpCommitteeId ?? 0,vdpRoleId: selectedRoleId,mobileNumber: _mobileController.text,emailId: _emailController.text,name: _nameController.text,status: true,createdBy: user?.email);
                                      }
                                    }

                                  });
                              case UpdateVdpMemberLoadingState : return const Center(child: CircularProgressIndicator(color: defaultColor,),
                              );
                              case UpdateVdpMemberSuccessState : return ButtonThemeLarge(
                                  context: context,
                                  color: defaultColor,
                                  label: save,
                                  onClick: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (validateName(_nameController.text)) {
                                        setState(() {
                                          isNameValidate = true;
                                        });
                                      } else
                                      if (validateMobile(_mobileController.text)) {
                                        setState(() {
                                          isMobileValidate = true;
                                        });
                                      }else
                                      if (validateEmail(_emailController.text)) {
                                        setState(() {
                                          isEmailValidate = true;
                                        });
                                      }else {
                                        context.read<VdpMemberCubit>().updateVdpMember(vdpMemberId: getAllVdpMember?.vdpMemberId ?? 0 ,vdpCommitteeId: getAllVdpMember?.vdpCommitteeId ?? 0,vdpRoleId: selectedRoleId,mobileNumber: _mobileController.text,emailId: _emailController.text,name: _nameController.text,status: true,createdBy: user?.email);
                                      }
                                    }
                                    // if (userNameController.text.isEmpty) {
                                    //   snackBar(context, validatorUserName);
                                    // } else if (passwordController.text.isEmpty) {
                                    //   snackBar(context, validatorPassword);
                                    // } else {
                                    //   cubit.doLogin(
                                    //       userName: userNameController.text,
                                    //       password: passwordController.text);
                                    // }
                                    // return null;
                                  });
                              default :  return ButtonThemeLarge(
                                  context: context,
                                  color: defaultColor,
                                  label: save,
                                  onClick: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (validateName(_nameController.text)) {
                                        setState(() {
                                          isNameValidate = true;
                                        });
                                      } else
                                      if (validateMobile(_mobileController.text)) {
                                        setState(() {
                                          isMobileValidate = true;
                                        });
                                      }else
                                      if (validateEmail(_emailController.text)) {
                                        setState(() {
                                          isEmailValidate = true;
                                        });
                                      }else {
                                        context.read<VdpMemberCubit>().updateVdpMember(vdpMemberId: getAllVdpMember?.vdpMemberId ?? 0 ,vdpCommitteeId: getAllVdpMember?.vdpCommitteeId ?? 0,vdpRoleId: selectedRoleId,mobileNumber: _mobileController.text,emailId: _emailController.text,name: _nameController.text,status: true,createdBy: user?.email);
                                      }
                                    }
                                    // if (userNameController.text.isEmpty) {
                                    //   snackBar(context, validatorUserName);
                                    // } else if (passwordController.text.isEmpty) {
                                    //   snackBar(context, validatorPassword);
                                    // } else {
                                    //   cubit.doLogin(
                                    //       userName: userNameController.text,
                                    //       password: passwordController.text);
                                    // }
                                    // return null;
                                  });
                            }
                          },
                        ),
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

  bool validateAge(String value) {
    if (value.isEmpty) {
      return true;
    }
    if (value.length <= 2) {
      return true;
    } else {
      return false;
    }
  }

  bool validateMobile(String value) {
    if (value.isEmpty) {
      return true;
    }
    if (value.length <= 2) {
      return true;
    } else {
      return false;
    }
  }

  bool validateEmail(String value) {
    if (value.isEmpty) {
      return true;
    }
    if (value.length <= 2) {
      return true;
    } else if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return false;
    } else {
      return false;
    }
  }
}
