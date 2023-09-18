import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../config/router/app_router.dart';
import '../../../domain/models/data/get_sent_message.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/message/message_cubit.dart';
import '../../cubits/message/message_state.dart';
import '../../widgets/common_widgets.dart';

class SentMessageView extends StatefulWidget {
  const SentMessageView({super.key});

  @override
  State<SentMessageView> createState() => _SentMessageViewState();
}

class _SentMessageViewState extends State<SentMessageView> {
  late User? user = User();
  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
          user = data?.user,
          context.read<MessageCubit>().getSentMessages(user?.email, 0, 1),
        });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  List<GetSentMessages> _getSentMessages = [];
  String? _toRecipient;
  Future<bool> onWillPop() {
    context.read<MessageCubit>().getReceivedMessages(user?.email, 0, 1);
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    print("WorkDarling");
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sent messages"),
        ),
        body: RefreshIndicator(
          color: defaultColor,
          onRefresh: (){
            return Future.delayed( const Duration(seconds: 1),(){
              setState(() {
                context.read<MessageCubit>().getSentMessages("${user?.email}", 0, 1);
              });
            });
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<MessageCubit, MessageState>(
                  listener: (context, state) {
                    if (state is GetSentMessagesSuccessState) {
                      if (state.getSentMessagesResponse?.code == "Success") {
                        _getSentMessages =
                            state.getSentMessagesResponse?.data ?? [];

                        print(
                            "=================================>${_getSentMessages.length}");
                      }
                    }
                  },
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case GetSentMessagesLoadingState:
                        return  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Center(
                              child: CircularProgressIndicator(
                                color: defaultColor,
                              ),
                            ),
                          ],
                        );
                      case GetSentMessagesSuccessState:
                        if(_getSentMessages.isNotEmpty)
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(children: [
                            ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _getSentMessages.length,
                                itemBuilder: (BuildContext context, index) {
                                  // _toRecipientUserNameList = _getSentMessages[index].toRecipientUserNameList ?? [];
                                  final parsedDate = DateTime.parse(
                                      _getSentMessages[index]
                                          .creationDate
                                          .toString());
                                  final formattedDate =
                                      DateFormat('dd MMM').format(parsedDate);
                                  return sendReceivedMessageBox(
                                      icon: '',
                                      subject: _getSentMessages[index].subject,
                                      firstChar: _getSentMessages[index].toRecipientUserNameList?.join(", ").substring(0, 1),
                                      name: _getSentMessages[index].toRecipientUserNameList?.join(", "),
                                      date: formattedDate,
                                      onTap: () {
                                        appRouter.push(MessageScreenRoute(
                                            getSentMessages:
                                                _getSentMessages[index],
                                            isSentMessage: true));
                                      },
                                      subTitle:
                                          _getSentMessages[index].messageBody);
                                }),
                          ]),
                        );
                        else
                          return    Center(
                          child: Padding(
                            padding:  EdgeInsets.only(top: SizeConfig.screenHeight * 0.30),
                            child: Column(
                              children: [
                                SvgPicture.asset(ic_not_data,color: defaultColor,
                                  height: SizeConfig.screenHeight * 0.20,
                                ),
                                Center(child: Text("No Record Found",style: styleIbmPlexSansBold(size: 20, color: defaultColor),),),

                              ],
                            ),
                          ),);
                      case GetSentMessagesErrorState:
                        return const Center(
                          child: Text(
                            "something went wrong !",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
