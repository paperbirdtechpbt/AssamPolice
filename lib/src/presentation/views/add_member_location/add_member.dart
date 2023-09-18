import 'package:flutter/material.dart';

import '../../../config/router/app_router.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../widgets/common_widgets.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

// validator var
  String isNameValidate = 'false';
  bool isAgeValidate = false;
  bool isMobileValidate = false;
  bool isAddressValidate = false;
  bool isRemarkValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Member",
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
                        textCapitalization: TextCapitalization.words,

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        border: Border.all(
                            color: isNameValidate == "false"
                                ? defaultColor
                                : Colors.transparent),
                        textInputAction: TextInputAction.next,
                        context: context,
                        textInputType: TextInputType.text,
                        controller: _nameController,
                        flutterIcon: const Icon(
                          Icons.person,
                          color: defaultColor,
                        ),
                        label: memberName,
                        length: null,
                        validator: (val) {
                          if (val!.length <= 2) {
                            isNameValidate = 'true';
                          } else {
                            isNameValidate = 'false';
                          }
                          return null;
                        },
                        hint: memberHintName,
                        icon: '',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CoustomTextFieldEditBox(
                        textCapitalization: TextCapitalization.characters,

                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        context: context,
                        controller: _ageController,
                        flutterIcon: const Icon(
                          Icons.calendar_today_rounded,
                          color: defaultColor,
                        ),
                        label: memberAge,
                        length: null,
                        validator: (val) {
                          if (val!.length <= 2) return '';
                          return null;
                        },
                        hint: memberHintAge,
                        icon: '',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CoustomTextFieldEditBox(
                        textCapitalization: TextCapitalization.characters,

                        border: Border.all(color: isMobileValidate ? defaultColor : Colors.transparent),
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        context: context,
                        controller: _mobileController,
                        label: memberMobile,
                        length: null,
                        onChanged: (value){
                          if (value!.length <= 2){
                            setState(() {
                              isMobileValidate = true;
                            });
                          }else {
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: isAddressValidate
                                      ? defaultColor
                                      : Colors.transparent),
                              borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0)),
                              color: skyBlue),
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.13,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_pin,
                                    color: defaultColor,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        maxLines: null,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Address",
                                          hintStyle: styleIbmPlexSansRegular(
                                              size: 16, color: grey),
                                          contentPadding: EdgeInsets.zero,
                                          isDense: true,
                                        ),
                                        controller: _addressController,
                                        cursorColor: defaultColor,
                                        onChanged: (value){
                                          if (value!.length <= 2){
                                            setState(() {
                                              isAddressValidate = true;
                                            });
                                          }else {
                                            setState(() {
                                              isAddressValidate = false;
                                            });
                                          }

                                        },
                                        validator: (val) {
                                          if (val!.length <= 2)  return '';
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CoustomTextFieldEditBox(
                        textCapitalization: TextCapitalization.characters,

                        border: Border.all(color: isRemarkValidate ? defaultColor : Colors.transparent),
                        textInputAction: TextInputAction.done,
                        onChanged: (value){
                          if (value!.length <= 2){
                            setState(() {
                              isRemarkValidate = true;
                            });
                          }else {
                            setState(() {
                              isRemarkValidate = false;
                            });
                          }

                        },
                        context: context,
                        controller: _remarkController,
                        flutterIcon: const Icon(
                          Icons.area_chart,
                          color: defaultColor,
                        ),
                        label: memberAddress,
                        length: null,
                        validator: (val) {
                          if (val!.length <= 2)  {
                            setState(() {
                              isRemarkValidate = true;
                            });
                          }
                          return null;
                        },
                        hint: memberHintRemark,
                        icon: '',
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ButtonThemeLarge(
                          context: context,
                          color: defaultColor,
                          label: add,
                          onClick: () {
                            if (_formKey.currentState!.validate()) {appRouter.pop();}

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
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
