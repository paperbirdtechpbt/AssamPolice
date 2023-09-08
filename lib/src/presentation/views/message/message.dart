import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/get_message_body.dart';
import '../../../domain/models/data/get_received_message.dart';
import '../../../domain/models/data/get_received_messages_with_parent_details.dart';
import '../../../domain/models/data/get_sent_message.dart';
import '../../../domain/models/data/get_sent_messages_with_parent_details.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/message/message_cubit.dart';
import '../../cubits/message/message_state.dart';
import '../../widgets/common_widgets.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen(
      {super.key,
      this.getReceivedMessages,
      this.getSentMessages,
      this.isSentMessage,
      this.isReplyed});
  GetReceivedMessages? getReceivedMessages;
  bool? isReplyed;
  GetSentMessages? getSentMessages;
  bool? isSentMessage;

  @override
  State<MessageScreen> createState() => _MessageScreenState(
      getReceivedMessages, isReplyed, getSentMessages, isSentMessage);
}

class _MessageScreenState extends State<MessageScreen> {
  GetReceivedMessages? getReceivedMessages;
  GetSentMessages? getSentMessages;
  bool? isSentMessage;

  bool? isReplyed;
  _MessageScreenState(this.getReceivedMessages, this.isReplyed,
      this.getSentMessages, this.isSentMessage);

  bool isShowMessage = true;
  bool isShowMessage2 = false;
  String bodyMessage = '';
  List<String> msgBodyList = [];
  List<GetMessageBody> getMsgBody = [];
  late User? user = User();
  List<GetReceivedMessagesWithParentDetails>
      getReceivedMessagesWithParentDetails = [];

  GetReceivedMessagesWithParentDetails? getReceivedMessagesWithParentDetails2;

  List<GetSentMessagesWithParentDetails> getSentMessagesWithParentDetails = [];
  GetSentMessagesWithParentDetails? getSentMessagesWithParentDetails2;
  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
          setState(() {
            user = data?.user;
            context
                .read<MessageCubit>()
                .getMessageBody(
                    user?.email,
                    isSentMessage == true
                        ? getSentMessages?.messageId
                        : getReceivedMessages?.messageId)
                .then((value) {
              if (isSentMessage == true) {
                context
                    .read<MessageCubit>()
                    .getSentMessagesWithParentDetails(user?.email, 0, 1);
              } else {
                context
                    .read<MessageCubit>()
                    .getReceivedMessagesWithParentDetails(user?.email, 0, 1);
              }
            });
          })
        });
  }

  String? formattedDate;
  @override
  void initState() {
    final parsedDate = DateTime.parse(isSentMessage == true
        ? "${getSentMessages?.creationDate}"
        : "${getReceivedMessages?.creationDate}");
    formattedDate = DateFormat('dd MMM').format(parsedDate);
    getUser();
  }

  Future<bool> onWillPop() {
    if (isSentMessage == true) {
      context.read<MessageCubit>().getSentMessages(user?.email, 0, 1);
    } else if (isSentMessage == false) {
      context.read<MessageCubit>().getReceivedMessages(user?.email, 0, 1);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                appRouter.pop();
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
              )),
          actions: [
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.delete,
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            // const Padding(
            //   padding: EdgeInsets.only(right: 10.0),
            //   child: Icon(
            //     Icons.more_vert_outlined,
            //   ),
            // ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              messageBox(),
              isSentMessage == true
                  ? BlocConsumer<MessageCubit, MessageState>(
                      listener: (context, state) {
                        if (state
                            is GetSentMessagesWithParentDetailsSuccessState) {
                          if (state.getSentMessagesWithParentDetailsResponse
                                  ?.code ==
                              "Success") {
                            getSentMessagesWithParentDetails = state
                                    .getSentMessagesWithParentDetailsResponse
                                    ?.data ??
                                [];
                          }
                        }
                      },
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case GetSentMessagesWithParentDetailsInitialState:
                            return Column(
                              children: List.generate(
                                  getSentMessagesWithParentDetails.length,
                                  (index) {
                                // context.read<MessageCubit>().getMessageBody(
                                //     user?.email,
                                //     GetSentMessagesWithParentDetails[index].messageId
                                //         );

                                return sentReplyMessageBox(getSentMessages
                                            ?.parentMessagesId ==
                                        getSentMessagesWithParentDetails[index]
                                            .parentMessagesId
                                    ? getSentMessagesWithParentDetails[index]
                                    : getSentMessagesWithParentDetails2);
                              }),
                            );
                          case GetSentMessagesWithParentDetailsLoadingState:
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          case GetSentMessagesWithParentDetailsSuccessState:
                            return Column(
                              children: List.generate(
                                  getSentMessagesWithParentDetails.length,
                                  (index) {
                                // context.read<MessageCubit>().getMessageBody(
                                //     user?.email,
                                //     GetSentMessagesWithParentDetails[index].messageId
                                // );
                                return sentReplyMessageBox(
                                  getSentMessages?.parentMessagesId ==
                                          getSentMessagesWithParentDetails[
                                                  index]
                                              .parentMessagesId
                                      ? getSentMessagesWithParentDetails[index]
                                      : getSentMessagesWithParentDetails2,
                                );
                              }),
                            );
                          default:
                            return Container();
                        }
                      },
                    )
                  : BlocConsumer<MessageCubit, MessageState>(
                      listener: (context, state) {
                        if (state
                            is GetReceivedMessagesWithParentDetailsSuccessState) {
                          if (state.getReceivedMessagesWithParentDetailsResponse
                                  ?.code ==
                              "Success") {
                            getReceivedMessagesWithParentDetails = state
                                    .getReceivedMessagesWithParentDetailsResponse
                                    ?.data ??
                                [];
                          }
                        }
                      },
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case GetReceivedMessagesWithParentDetailsInitialState:
                            return Column(
                              children: List.generate(
                                  getReceivedMessagesWithParentDetails.length,
                                  (index) {
                                // context.read<MessageCubit>().getMessageBody(
                                //     user?.email,
                                //     getReceivedMessagesWithParentDetails[index].messageId
                                //         );
                                return receviedReplyMessageBox(
                                  getReceivedMessages?.parentMessagesId ==
                                          getReceivedMessagesWithParentDetails[
                                                  index]
                                              .parentMessagesId
                                      ? getReceivedMessagesWithParentDetails[
                                          index]
                                      : getReceivedMessagesWithParentDetails2,
                                );
                              }),
                            );
                          case GetReceivedMessagesWithParentDetailsLoadingState:
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          case GetReceivedMessagesWithParentDetailsSuccessState:
                            return Column(
                              children: List.generate(
                                  getReceivedMessagesWithParentDetails.length,
                                  (index) {
                                // context.read<MessageCubit>().getMessageBody(
                                //     user?.email,
                                //     getReceivedMessagesWithParentDetails[index].messageId
                                // );
                                return receviedReplyMessageBox(
                                  getReceivedMessages?.parentMessagesId ==
                                          getReceivedMessagesWithParentDetails[
                                                  index]
                                              .parentMessagesId
                                      ? getReceivedMessagesWithParentDetails[
                                          index]
                                      : getReceivedMessagesWithParentDetails2,
                                );
                              }),
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
    );
  }

  buttomButton(Icon icon, String name, Function? onTap()) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(20), right: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(
              name,
              style: styleIbmPlexSansRegular(size: 16, color: grey),
            )
          ],
        ),
      ),
    );
  }

  messageBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              isSentMessage == true
                  ? "${getSentMessages?.subject ?? ''} "
                  : "${getReceivedMessages?.subject ?? ''}",
              style: styleIbmPlexSansBold(size: 20, color: grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: defaultColor,
                    child: Text(
                      isSentMessage == true
                          ? "${getSentMessages?.toRecipientUserNameList?.join(", ")?.substring(0, 1) ?? ''} "
                          : "${getReceivedMessages?.toRecipientUserNameList?.join(", ").substring(0, 1) ?? ''}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    maxRadius: 20,
                    // foregroundImage: NetworkImage("enterImageUrl"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Text(
                        isSentMessage == true
                            ? "${getSentMessages?.toRecipientUserNameList?.join(", ")} "
                            : "${getReceivedMessages?.toRecipientUserNameList?.join(", ")}",
                        overflow: TextOverflow.ellipsis,
                        style: styleIbmPlexSansRegular(size: 16, color: grey),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      child: isShowMessage == false
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  isShowMessage = true;
                                });
                              },
                              child: const Icon(Icons.arrow_drop_down_outlined))
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isShowMessage = false;
                                });
                              },
                              child: const Icon(Icons.arrow_drop_up)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${formattedDate}' ?? '',
                            style:
                                styleIbmPlexSansRegular(size: 12, color: grey),
                          ),
                          InkWell(
                              onTap: () {
                                if (isSentMessage == true) {
                                  appRouter.push(ComposeMessageScreenRoute(
                                      isReply: true,
                                      isSentMessage: true,
                                      getSentMessages: getSentMessages));
                                } else {
                                  appRouter.push(ComposeMessageScreenRoute(
                                    getReceivedMessages: getReceivedMessages,
                                    isReply: true,
                                    isSentMessage: false,
                                  ));
                                }
                              },
                              child: const Icon(
                                Icons.reply,
                              )),
                          Container()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<MessageCubit, MessageState>(
            listener: (context, state) {
              if (state is GetMessageBodySuccessState) {
                setState(() {
                  bodyMessage =
                      state.getMessageBodyResponse?.data?.messageBody ?? '';
                });
              }
            },
            builder: (context, state) {
              return Visibility(
                visible: isShowMessage,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0)),
                            color: skyBlue),
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Text(
                              bodyMessage ?? '',
                              style: styleIbmPlexSansRegular(
                                  size: 13, color: Colors.black),
                            )),
                      ),
                      //                         Padding(
                      //                           padding: const EdgeInsets.only(top:20.0),
                      //                           child: Row(
                      //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                             children: [
                      //                               buttomButton(const Icon(Icons.reply), "Reply",()
                      // {
                      //
                      //                               }),
                      //                             ],
                      //                           ),
                      //                         )
                    ],
                  ),
                ),
              );
            },
          ),
          const Divider(
            height: 12,
            color: Color(0xFF928AD3),
            thickness: .5,
          ),
          // Container(child: Text(subject[widget.memberIndex ?? 0],style: styleIbmPlexSansRegular(size: 20, color: grey),),),
          // Padding(
          //   padding: const EdgeInsets.only(top:30.0),
          //   child: Container(
          //     child: Row(
          //       children: [
          //         CircleAvatar(
          //           backgroundColor: defaultColor,
          //           child: Text(
          //             getReceivedMessages[widget.memberIndex ?? 0].substring(0, 1),
          //             style: const TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 20,
          //                 color: Colors.white),
          //           ),
          //           maxRadius: 20,
          //           // foregroundImage: NetworkImage("enterImageUrl"),
          //         ),
          //         const SizedBox(width: 20,),
          //         Container(
          //             width: MediaQuery.of(context).size.width * 0.40,
          //             child: Text(
          //               "${getReceivedMessages[widget.memberIndex ?? 0]}",
          //               overflow: TextOverflow.ellipsis,
          //
          //               style: styleIbmPlexSansRegular(size: 16, color: grey),)),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 10.0),
          //           child: Container(child: isShowMessage2 == false ? InkWell(onTap: (){setState(() {
          //             isShowMessage2 = true;
          //           });},child: Icon(Icons.arrow_drop_down_outlined)) :  InkWell(onTap: (){setState(() {
          //             isShowMessage2 = false;
          //           });},child: Icon(Icons.arrow_drop_up)),),
          //         ),
          //         Expanded(
          //           child: Container(
          //             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   'july 28' ?? '',
          //                   style: styleIbmPlexSansRegular(size: 12, color: grey),
          //                 ),
          //                 InkWell(onTap: (){
          //                   appRouter.push(ComposeMessageScreenRoute(subject: subject[widget.memberIndex ?? 0],to: getReceivedMessages[widget.memberIndex ?? 0],
          //                     isReply: 0,
          //                     from: "AsamPolice@gmail.com",
          //
          //                   ));
          //                 },
          //                     child: const Icon(Icons.reply,)),
          //                 const Icon(
          //                   Icons.more_vert_outlined,
          //                   color: Colors.black,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10,),
          // Visibility(
          //   visible: isShowMessage2,
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Column(
          //       children: [
          //         Container(
          //           decoration: const BoxDecoration(
          //               borderRadius: const BorderRadius.all(
          //                   const Radius.circular(10.0)),
          //               color: skyBlue),
          //           padding:
          //           const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          //           child: Container(
          //               width: double.infinity,
          //               height: MediaQuery.of(context).size.height * 0.25,
          //               child: Text(message[widget.memberIndex ?? 0],style: styleIbmPlexSansRegular(size: 13, color: Colors.black),)),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(top:20.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               buttomButton(const Icon(Icons.reply), "Reply",(){
          //                 appRouter.push(ComposeMessageScreenRoute(subject: subject[widget.memberIndex ?? 0],to: getReceivedMessages[widget.memberIndex ?? 0],
          //
          //                   isReply: 0,
          //                   from: "AsamPolice@gmail.com",
          //
          //                 ));
          //
          //               }),
          //               buttomButton(const Icon(Icons.reply_all), "Reply all",(){}),
          //
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  receviedReplyMessageBox(
    GetReceivedMessagesWithParentDetails? getReceivedMessagesWithParentDetails,

  ) {
    if (getReceivedMessagesWithParentDetails != null)
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                isSentMessage == true
                    ? "${getSentMessages?.subject ?? ''} "
                    : "${getReceivedMessagesWithParentDetails.subject ?? ''}",
                style: styleIbmPlexSansBold(size: 20, color: grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: defaultColor,
                      child: Text(
                        isSentMessage == true
                            ? "${getSentMessages?.toRecipientUserNameList?.join(", ")?.substring(0, 1) ?? ''} "
                            : "${getReceivedMessagesWithParentDetails?.senderUserName?.substring(0, 1) ?? ''}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      maxRadius: 20,
                      // foregroundImage: NetworkImage("enterImageUrl"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Text(
                          isSentMessage == true
                              ? "${getSentMessages?.toRecipientUserNameList?.join(", ")} "
                              : "${getReceivedMessagesWithParentDetails?.senderUserName}",
                          overflow: TextOverflow.ellipsis,
                          style: styleIbmPlexSansRegular(size: 16, color: grey),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                getReceivedMessagesWithParentDetails.isVisible =
                                    !getReceivedMessagesWithParentDetails
                                        .isVisible;
                              });
                            },
                            child: getReceivedMessagesWithParentDetails
                                    .isVisible
                                ? const Icon(Icons.arrow_drop_up)
                                : const Icon(Icons.arrow_drop_down_outlined)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${formattedDate}' ?? '',
                              style: styleIbmPlexSansRegular(
                                  size: 12, color: grey),
                            ),
                            InkWell(
                                onTap: () {
                                  if (isSentMessage == true) {
                                    appRouter.push(ComposeMessageScreenRoute(
                                        isReply: true,
                                        isSentMessage: true,
                                        getSentMessages: getSentMessages));
                                  } else {
                                    appRouter.push(ComposeMessageScreenRoute(
                                      getReceivedMessages: getReceivedMessages,
                                      isReply: true,
                                      isSentMessage: false,
                                    ));
                                  }
                                },
                                child: const Icon(
                                  Icons.reply,
                                )),
                            Container()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<MessageCubit, MessageState>(
              listener: (context, state) {
                if (state is GetMessageBodySuccessState) {
                  setState(() {
                    msgBodyList.add(
                        state.getMessageBodyResponse?.data?.messageBody ?? '');
                    getMsgBody = state.getMessageBodyResponse.data ?? [];
                  });
                }
              },
              builder: (context, state) {
                if (getReceivedMessagesWithParentDetails.isVisible)
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0)),
                              color: skyBlue),
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: Text(
                                getReceivedMessagesWithParentDetails
                                        .messageBody ??
                                    '',
                                style: styleIbmPlexSansRegular(
                                    size: 13, color: Colors.black),
                              )),
                        ),
                        //                         Padding(
                        //                           padding: const EdgeInsets.only(top:20.0),
                        //                           child: Row(
                        //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //                             children: [
                        //                               buttomButton(const Icon(Icons.reply), "Reply",()
                        // {
                        //
                        //                               }),
                        //                             ],
                        //                           ),
                        //                         )
                      ],
                    ),
                  );
                else
                  return Container();
              },
            ),
            const Divider(
              height: 12,
              color: Color(0xFF928AD3),
              thickness: .5,
            ),
            // Container(child: Text(subject[widget.memberIndex ?? 0],style: styleIbmPlexSansRegular(size: 20, color: grey),),),
            // Padding(
            //   padding: const EdgeInsets.only(top:30.0),
            //   child: Container(
            //     child: Row(
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: defaultColor,
            //           child: Text(
            //             getReceivedMessages[widget.memberIndex ?? 0].substring(0, 1),
            //             style: const TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 20,
            //                 color: Colors.white),
            //           ),
            //           maxRadius: 20,
            //           // foregroundImage: NetworkImage("enterImageUrl"),
            //         ),
            //         const SizedBox(width: 20,),
            //         Container(
            //             width: MediaQuery.of(context).size.width * 0.40,
            //             child: Text(
            //               "${getReceivedMessages[widget.memberIndex ?? 0]}",
            //               overflow: TextOverflow.ellipsis,
            //
            //               style: styleIbmPlexSansRegular(size: 16, color: grey),)),
            //         Padding(
            //           padding: const EdgeInsets.only(right: 10.0),
            //           child: Container(child: isShowMessage2 == false ? InkWell(onTap: (){setState(() {
            //             isShowMessage2 = true;
            //           });},child: Icon(Icons.arrow_drop_down_outlined)) :  InkWell(onTap: (){setState(() {
            //             isShowMessage2 = false;
            //           });},child: Icon(Icons.arrow_drop_up)),),
            //         ),
            //         Expanded(
            //           child: Container(
            //             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   'july 28' ?? '',
            //                   style: styleIbmPlexSansRegular(size: 12, color: grey),
            //                 ),
            //                 InkWell(onTap: (){
            //                   appRouter.push(ComposeMessageScreenRoute(subject: subject[widget.memberIndex ?? 0],to: getReceivedMessages[widget.memberIndex ?? 0],
            //                     isReply: 0,
            //                     from: "AsamPolice@gmail.com",
            //
            //                   ));
            //                 },
            //                     child: const Icon(Icons.reply,)),
            //                 const Icon(
            //                   Icons.more_vert_outlined,
            //                   color: Colors.black,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10,),
            // Visibility(
            //   visible: isShowMessage2,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Column(
            //       children: [
            //         Container(
            //           decoration: const BoxDecoration(
            //               borderRadius: const BorderRadius.all(
            //                   const Radius.circular(10.0)),
            //               color: skyBlue),
            //           padding:
            //           const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            //           child: Container(
            //               width: double.infinity,
            //               height: MediaQuery.of(context).size.height * 0.25,
            //               child: Text(message[widget.memberIndex ?? 0],style: styleIbmPlexSansRegular(size: 13, color: Colors.black),)),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top:20.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               buttomButton(const Icon(Icons.reply), "Reply",(){
            //                 appRouter.push(ComposeMessageScreenRoute(subject: subject[widget.memberIndex ?? 0],to: getReceivedMessages[widget.memberIndex ?? 0],
            //
            //                   isReply: 0,
            //                   from: "AsamPolice@gmail.com",
            //
            //                 ));
            //
            //               }),
            //               buttomButton(const Icon(Icons.reply_all), "Reply all",(){}),
            //
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    else
      return Container();
  }

  sentReplyMessageBox(
    GetSentMessagesWithParentDetails? getSentMessagesWithParentDetails,
  ) {
    if (getSentMessagesWithParentDetails != null)
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                isSentMessage == true
                    ? "${getSentMessages?.subject ?? ''} "
                    : "${getSentMessagesWithParentDetails?.subject ?? ''}",
                style: styleIbmPlexSansBold(size: 20, color: grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: defaultColor,
                      child: Text(
                        isSentMessage == true
                            ? "${getSentMessages?.toRecipientUserNameList?.join(", ")?.substring(0, 1) ?? ''} "
                            : "${getSentMessagesWithParentDetails?.toRecipientUserNameList?.join(", ").substring(0, 1) ?? ''}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      maxRadius: 20,
                      // foregroundImage: NetworkImage("enterImageUrl"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Text(
                          isSentMessage == true
                              ? "${getSentMessages?.toRecipientUserNameList?.join(", ")} "
                              : "${getSentMessagesWithParentDetails?.toRecipientUserNameList?.join(", ")}",
                          overflow: TextOverflow.ellipsis,
                          style: styleIbmPlexSansRegular(size: 16, color: grey),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                          child: InkWell(
                        onTap: () {
                          setState(() {
                            getSentMessagesWithParentDetails.isVisible == true
                                ? getSentMessagesWithParentDetails.isVisible =
                                    false
                                : getSentMessagesWithParentDetails.isVisible =
                                    true;
                          });
                        },
                        child: getSentMessagesWithParentDetails.isVisible
                            ? const Icon(Icons.arrow_drop_up)
                            : const Icon(Icons.arrow_drop_down_outlined),
                      )),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${formattedDate}' ?? '',
                              style: styleIbmPlexSansRegular(
                                  size: 12, color: grey),
                            ),
                            InkWell(
                                onTap: () {
                                  if (isSentMessage == true) {
                                    appRouter.push(ComposeMessageScreenRoute(
                                        isReply: true,
                                        isSentMessage: true,
                                        getSentMessages: getSentMessages));
                                  } else if (isSentMessage == false) {
                                    appRouter.push(ComposeMessageScreenRoute(
                                      getReceivedMessages: getReceivedMessages,
                                      isReply: true,
                                      isSentMessage: false,
                                    ));
                                  }
                                },
                                child: const Icon(
                                  Icons.reply,
                                )),
                            Container()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<MessageCubit, MessageState>(
              listener: (context, state) {
                if (state is GetMessageBodySuccessState) {
                  setState(() {
                    msgBodyList.add(
                        state.getMessageBodyResponse?.data?.messageBody ?? '');
                    bodyMessage =
                        state.getMessageBodyResponse?.data?.messageBody ?? '';
                  });
                }
              },
              builder: (context, state) {
                if (getSentMessagesWithParentDetails.isVisible == true)
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0)),
                              color: skyBlue),
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                          child: Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: Text(
                                getSentMessagesWithParentDetails?.messageBody ??
                                    '',
                                style: styleIbmPlexSansRegular(
                                    size: 13, color: Colors.black),
                              )),
                        ),
                        //                         Padding(
                        //                           padding: const EdgeInsets.only(top:20.0),
                        //                           child: Row(
                        //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //                             children: [
                        //                               buttomButton(const Icon(Icons.reply), "Reply",()
                        // {
                        //
                        //                               }),
                        //                             ],
                        //                           ),
                        //                         )
                      ],
                    ),
                  );
                else {
                  return Container();
                }
              },
            ),
            const Divider(
              height: 12,
              color: Color(0xFF928AD3),
              thickness: .5,
            ),
            // Container(child: Text(subject[widget.memberIndex ?? 0],style: styleIbmPlexSansRegular(size: 20, color: grey),),),
            // Padding(
            //   padding: const EdgeInsets.only(top:30.0),
            //   child: Container(
            //     child: Row(
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: defaultColor,
            //           child: Text(
            //             getReceivedMessages[widget.memberIndex ?? 0].substring(0, 1),
            //             style: const TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 20,
            //                 color: Colors.white),
            //           ),
            //           maxRadius: 20,
            //           // foregroundImage: NetworkImage("enterImageUrl"),
            //         ),
            //         const SizedBox(width: 20,),
            //         Container(
            //             width: MediaQuery.of(context).size.width * 0.40,
            //             child: Text(
            //               "${getReceivedMessages[widget.memberIndex ?? 0]}",
            //               overflow: TextOverflow.ellipsis,
            //
            //               style: styleIbmPlexSansRegular(size: 16, color: grey),)),
            //         Padding(
            //           padding: const EdgeInsets.only(right: 10.0),
            //           child: Container(child: isShowMessage2 == false ? InkWell(onTap: (){setState(() {
            //             isShowMessage2 = true;
            //           });},child: Icon(Icons.arrow_drop_down_outlined)) :  InkWell(onTap: (){setState(() {
            //             isShowMessage2 = false;
            //           });},child: Icon(Icons.arrow_drop_up)),),
            //         ),
            //         Expanded(
            //           child: Container(
            //             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   'july 28' ?? '',
            //                   style: styleIbmPlexSansRegular(size: 12, color: grey),
            //                 ),
            //                 InkWell(onTap: (){
            //                   appRouter.push(ComposeMessageScreenRoute(subject: subject[widget.memberIndex ?? 0],to: getReceivedMessages[widget.memberIndex ?? 0],
            //                     isReply: 0,
            //                     from: "AsamPolice@gmail.com",
            //
            //                   ));
            //                 },
            //                     child: const Icon(Icons.reply,)),
            //                 const Icon(
            //                   Icons.more_vert_outlined,
            //                   color: Colors.black,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10,),
            // Visibility(
            //   visible: isShowMessage2,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Column(
            //       children: [
            //         Container(
            //           decoration: const BoxDecoration(
            //               borderRadius: const BorderRadius.all(
            //                   const Radius.circular(10.0)),
            //               color: skyBlue),
            //           padding:
            //           const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            //           child: Container(
            //               width: double.infinity,
            //               height: MediaQuery.of(context).size.height * 0.25,
            //               child: Text(message[widget.memberIndex ?? 0],style: styleIbmPlexSansRegular(size: 13, color: Colors.black),)),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top:20.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               buttomButton(const Icon(Icons.reply), "Reply",(){
            //                 appRouter.push(ComposeMessageScreenRoute(subject: subject[widget.memberIndex ?? 0],to: getReceivedMessages[widget.memberIndex ?? 0],
            //
            //                   isReply: 0,
            //                   from: "AsamPolice@gmail.com",
            //
            //                 ));
            //
            //               }),
            //               buttomButton(const Icon(Icons.reply_all), "Reply all",(){}),
            //
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    else
      return Container();
  }
}
