import 'package:flutter/material.dart';

import '../../../config/router/app_router.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../widgets/common_widgets.dart';

class EditMembersAddress extends StatefulWidget {
  const EditMembersAddress({super.key});

  @override
  State<EditMembersAddress> createState() => _EditMembersAddressState();
}

class _EditMembersAddressState extends State<EditMembersAddress> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    setState(() {
      _nameController.text = "Anil Thakor" ;
      _ageController.text = "28" ;
      _mobileController.text = "9924226515" ;
      _addressController.text = "Elite bussiness hub";
      _remarkController.text = "Sg highway";
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Address",
        ),
        leading:  InkWell(
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
                      TextFieldEditBox(
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
                          // if (val!.length <= 2) return validatorEnterMobile;

                          return null;
                        },
                        hint: memberHintName,
                        icon: '',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFieldEditBox(
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
                          // if (val!.length <= 2) return validatorEnterMobile;

                          return null;
                        },
                        hint: memberHintAge,
                        icon: '',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFieldEditBox(
                        textInputType: TextInputType.phone,

                        textInputAction: TextInputAction.next,
                        context: context,
                        controller: _mobileController,
                        label: memberMobile,
                        length: null,
                        validator: (val) {
                          // if (val!.length <= 2) return validatorEnterMobile;

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
                          decoration: const BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0)),
                              color: skyBlue),
                          padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.13,
                              child:
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_pin,color: defaultColor,),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        keyboardType:                        TextInputType.text,

                                        maxLines: null,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        decoration: InputDecoration(

                                            hintText: "Address",
                                            hintStyle: styleIbmPlexSansRegular(
                                                size: 16, color: grey),
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true,
                                            border: InputBorder.none),
                                        controller: _addressController,
                                        cursorColor: defaultColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )

                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFieldEditBox(
                        textInputAction: TextInputAction.done,

                        context: context,
                        controller: _remarkController,
                        flutterIcon: const Icon(
                          Icons.area_chart,
                          color: defaultColor,
                        ),
                        label: memberAddress,
                        length: null,
                        validator: (val) {
                          if (val!.length <= 2) return validatorEnterMobile;

                          return null;
                        },
                        hint: memberHintRemark,
                        icon: '',                       textInputType: TextInputType.text,

                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ButtonThemeLarge(
                          context: context,
                          color: defaultColor,
                          label: save,
                          onClick: () {

                            if(_formKey.currentState!.validate()){

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
                            appRouter.pop();
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
