import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/router/app_router.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../../utils/static_data.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/auth/auth_state.dart';
import '../../widgets/common_widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late var cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   welcomeBack,
                        //   style: styleIbmPlexSansLite(size: 20, color: defaultColor),
                        // ),
                        sizeHeightBox(),
                        // Text(
                        //   greetingMessage,
                        //   style: styleIbmPlexSansRegular(size: 15, color: grey),
                        // ),

                        Center(
                          child: ClipRRect(
                            child: Image.asset(ic_logo_png,height: 120),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        TextFieldEditBox(
                          context: context,
                          controller: userNameController,
                          icon: ic_account,
                          label: userName,
                          length: null,
                          validator: (val) {
                            // if (val!.length <= 2) return validatorEnterMobile;
                            return null;
                          },
                          hint: userName, textInputAction: TextInputAction.next, textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFieldEditBoxPassword(
                          textInputType: TextInputType.text,
                          context: context,
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          icon: ic_lock,
                          label: password,
                          length: null,
                          validator: (val) {
                            // if (val!.length <= 2) return validatorEnterMobile;
                            return null;
                          },
                          hint: password,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) async {
                            if (state is AuthLoadingState) {
                              onLoading(context, "Loading..");
                            }
                            if (state is AuthSuccessState) {
                              if (state.response?.status == "200") {
                                appRouter.pop();
                                var preferences = MySharedPreference();
                                StaticData.loginData = state.response?.data!;
                                await preferences.setSignInModel(
                                    state.response?.data, keySaveSignInModel);
                                await preferences.setBool(keyIsLogin, true);
                                appRouter.popAndPush(const AddMemberLocationRoute());
                                // appRouter.popAndPush(const DashBoardScreenRoute());
                              } else {
                                appRouter.pop();
                                snackBar(context, "${state.response?.message}");
                              }
                            } else if (state is AuthErrorState) {
                              snackBar(context, "${state.error?.message}");
                            }
                          },
                          builder: (context, state) {
                            return
                              ButtonThemeLarge(
                                  context: context,
                                  color: defaultColor,
                                  label: next,
                                  onClick: () {
                                    if (userNameController.text.isEmpty) {
                                      snackBar(context, validatorUserName);
                                    } else if (passwordController.text.isEmpty) {
                                      snackBar(context, validatorPassword);
                                    } else {
                                      cubit.doLogin(
                                          userName: userNameController.text,
                                          password: passwordController.text);
                                    }

                                    return null;


                                  //
                                  }


                                  );
                          },
                        ),
                      ],
                    ),
                  ))),
        ));
  }
}