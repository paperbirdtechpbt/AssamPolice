import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../config/router/app_router.dart';
import '../../../domain/models/data/get_message_body.dart';
import '../../../domain/models/data/get_received_message.dart';
import '../../../domain/models/data/get_received_messages_with_parent_details.dart';
import '../../../domain/models/data/get_sent_message.dart';
import '../../../domain/models/data/get_sent_messages_with_parent_details.dart';
import '../../../domain/models/data/get_user_list_tocc.dart';
import '../../../domain/models/data/user.dart';
import '../../../domain/models/responses/get_sent_messages_with_parent_details_response.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/message/message_cubit.dart';
import '../../cubits/message/message_state.dart';
import '../../widgets/common_widgets.dart';

class ComposeMessageScreen extends StatefulWidget {
  GetReceivedMessages? getReceivedMessages;
  GetSentMessages? getSentMessages;
  GetMessageBody? getMessageBody;
  GetReceivedMessagesWithParentDetails? getReceivedMessagesWithParentDetails;
  GetSentMessagesWithParentDetails? getSentMessagesWithParentDetails;
  bool? isSentMessage;
  bool? isReply;
  ComposeMessageScreen({
    super.key,
    this.getReceivedMessages,
    this.getSentMessages,
    this.isSentMessage,
    this.getReceivedMessagesWithParentDetails,
    this.getSentMessagesWithParentDetails,
    this.isReply,
    this.getMessageBody,
  });

  @override
  State<ComposeMessageScreen> createState() =>
      _ComposeMessageScreenState(getReceivedMessages, isReply,getSentMessages,isSentMessage,getMessageBody,getSentMessagesWithParentDetails,getReceivedMessagesWithParentDetails);
}

class _ComposeMessageScreenState extends State<ComposeMessageScreen> {
  GetMessageBody? getMessageBody;
  GetReceivedMessagesWithParentDetails? getReceivedMessagesWithParentDetails;
  GetSentMessagesWithParentDetails? getSentMessagesWithParentDetails;
  _ComposeMessageScreenState(this.getReceivedMessages, this.isReply,this.getSentMessages,this.isSentMessage,this.getMessageBody,this.getSentMessagesWithParentDetails,this.getReceivedMessagesWithParentDetails);

  List<GetUserListTOCC> ToMembers = [];
  List<GetUserListTOCC> ToResponseMembers = [];
  List<GetUserListTOCC> CcMembers = [];
  List<GetUserListTOCC> CcResponseMembers = [];
  List<String> menuUserList = [];

  List<String> selectedToMembers = [];
  List<String> selectedCcMembers = [];
  // List<String> selectedBccMembers = [];
  TextEditingController _membersController = TextEditingController();
  TextEditingController _ccmembersController = TextEditingController();
  // TextEditingController _BccmembersController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  bool isShowCc = false;
  bool isShowBcc = false;
  GetReceivedMessages? getReceivedMessages;
  GetSentMessages? getSentMessages;
  bool? isSentMessage;
  bool? isReply;
  late User? user = User();
  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
      setState(() {
        user = data?.user;
      })
    });
    context.read<MessageCubit>().getUserListTO(user?.email, 6,"to");


  }


  @override
  void initState() {
    if(isReply != null && isReply == true && isSentMessage == true){

      setState(() {
        selectedToMembers = getSentMessages?.toRecipientUserNameList ?? [];
        selectedCcMembers = getSentMessages?.ccRecipientUserNameList ?? [];
        _subjectController.text = getSentMessages?.subject ?? '';
        _bodyController.text = getSentMessages?.messageBody ?? '';
      });
    }
    else if (isReply != null && isReply == true && isSentMessage == false) {
      setState(() {
        selectedToMembers.add(getReceivedMessages?.senderUserName ?? '');
        selectedCcMembers= getReceivedMessages?.ccRecipientUserNameList ?? [];
        _subjectController.text = getReceivedMessages?.subject ?? '';
        _bodyController.text = getReceivedMessages?.messageBody ?? '';
      });
    }
    for(var i in selectedToMembers){
      if(selectedToMembers.contains(i)){
        // members.remove(i);
      }
    }
    getUser();
  }

  Future<bool> onWillPop() {
    context.read<MessageCubit>().getReceivedMessages(user?.email, 0, 1);
    context
        .read<MessageCubit>()
        .getSentMessagesWithParentDetails(user?.email, 0, 1);
    context
        .read<MessageCubit>()
        .getReceivedMessagesWithParentDetails(user?.email, 0, 1);

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
          title: const Text(
            "Message",
          ),
          actions: [

            InkWell(
              child: const Icon(
                Icons.send,
              ),
              onTap: () {
                if (isReply != null && isReply == true && isSentMessage == true) {
                  context.read<MessageCubit>().sendMessage(
                      "${user?.email}",
                      selectedToMembers,
                      selectedCcMembers,
                      _subjectController.text,
                      _bodyController.text,
                      getSentMessages?.messageId ?? 0);
                } else {
                  context.read<MessageCubit>().sendMessage(
                      "${user?.email}",
                      selectedToMembers,
                      selectedCcMembers,
                      _subjectController.text,
                      _bodyController.text,
                      getReceivedMessages?.messageId ?? 0);
                }
              },
            ),
            const SizedBox(
              width: 20.0,
            ),

          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Column(
              children: <Widget>[

                BlocConsumer<MessageCubit, MessageState>(
                  listener: (context, state) {
                    if (state is SendMessageSuccessState) {
                      if (isReply != null && isReply == true) {
                        if(state.getSentMessagesResponse?.code == "Success"){
                          snackBar(context, "${state.getSentMessagesResponse?.message}");
                          appRouter.pop();
                        }else {
                          snackBar(context, "${state.getSentMessagesResponse?.message}");
                        }
                      } else {
                        appRouter.pop();

                        snackBar(context, "${state.getSentMessagesResponse?.message}");
                      }
                    }else if(state is SendMessageErrorState){
                      snackBar(context, "something went wrong!");
                    }else if (state is GetUserListTOCCSuccessState){
                      if(state.getUserListTOCCResponse?.code == "Success"){
                        ToResponseMembers =    state.getUserListTOCCResponse?.data?? [];
setState(() {
  ToMembers.addAll(ToResponseMembers);
});
                        context.read<MessageCubit>().getUserListCC(user?.email, 6,"cc");
                      }
                    }else if(state is GetUserListCCSuccessState){
                      if(state.getUserListTOCCResponse?.code == "Success"){
                        CcResponseMembers =    state.getUserListTOCCResponse?.data?? [];
                        setState(() {
                          CcMembers.addAll(CcResponseMembers);
                        });

                      }
                    }
                  },
                  builder: (context, state) {
                    return Container();
                  },
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0)),
                            color: skyBlue),
                        padding:
                        const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10.0,
                                          ),
                                          child: Container(
                                            child: Text(
                                              "To",
                                              style: styleIbmPlexSansRegular(
                                                  size: 16, color: grey),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Container(
                                          child: Row(
                                            children: [
                                              isShowCc == true
                                                  ? Container()
                                                  : InkWell(
                                                  onTap: () {
                                                    ccWidget(
                                                        ccBcc: "Cc",
                                                        isCcBcc: 0);
                                                    setState(() {
                                                      isShowCc = true;
                                                    });
                                                  },
                                                  child: Text(
                                                    "CC",
                                                    style:
                                                    styleIbmPlexSansRegular(
                                                        size: 16,
                                                        color: grey),
                                                  )),
                                              const SizedBox(
                                                width: 8.0,
                                              ),
                                              // isShowBcc == true
                                              //     ? Container()
                                              //     : InkWell(
                                              //         onTap: () {
                                              //           bccWidget(ccBcc: "BCC", isCcBcc: 1);
                                              //           setState(() {
                                              //             isShowBcc = true;
                                              //           });
                                              //         },
                                              //         child: Text(
                                              //           "BCC",
                                              //           style: styleIbmPlexSansRegular(
                                              //               size: 16, color: grey),
                                              //         )),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Wrap(children: selectedToMembers.map((item){
                                      return  Container(
                                        child:
                                        selectedMemberWidget(
                                          item,
                                          '',
                                          item
                                              .substring(0, 1).toUpperCase(),
                                        ),);
                                    }).toList(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: TypeAheadField(
                                          textFieldConfiguration:
                                          TextFieldConfiguration(
                                            enableInteractiveSelection:
                                            true,
                                            cursorColor: grey,
                                            decoration:
                                            const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            controller: this._membersController,
                                          ),
                                          suggestionsCallback:
                                              (pattern) async {
                                            return await getToMembers(pattern);
                                          },
                                          transitionBuilder: (context,
                                              suggestionsBox, controller) {
                                            return suggestionsBox;
                                          },
                                          itemBuilder:
                                              (context, GetUserListTOCC suggestion) {
                                            String icon = '';
                                            return Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 10,
                                                  bottom: 5),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        icon.isEmpty
                                                            ? CircleAvatar(
                                                          backgroundColor:
                                                          defaultColor,
                                                          child: Container(

                                                            child: Text(
                                                              suggestion.userName?.substring(
                                                                  0,
                                                                  1).toUpperCase() ??
                                                                  '',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  20,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          maxRadius: 15,
                                                          foregroundImage:
                                                          NetworkImage(
                                                              "enterImageUrl"),
                                                        )
                                                            : ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                          child:
                                                          Image.asset(
                                                              icon),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Column(
                                                          children: [

                                                            Container(
                                                              width: SizeConfig.screenWidth * 0.65,
                                                              color: Colors.white,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10.0,
                                                                    top: 10),
                                                                child: Text(
                                                                  overflow: TextOverflow.ellipsis,
                                                                  suggestion
                                                                      .userName.toString(),
                                                                  style:
                                                                  styleIbmPlexSansRegular(
                                                                      size: 18,
                                                                      color:
                                                                      grey),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: SizeConfig.screenWidth * 0.65,
                                                              color: Colors.white,
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10.0,
                                                                    top: 10),
                                                                child: Text(
                                                                  overflow: TextOverflow.ellipsis,
                                                                  suggestion
                                                                      .name.toString(),
                                                                  style:
                                                                  styleIbmPlexSansRegular(
                                                                      size: 16,
                                                                      color:
                                                                      grey),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          onSuggestionSelected:
                                              (GetUserListTOCC suggestion) {
                                                this._membersController.text =
                                                suggestion.userName.toString();
                                            selectedToMembers.add(
                                                _membersController.text);

                                            if (selectedToMembers
                                                .contains(suggestion.userName)) {
                                              ToMembers.remove(suggestion);
                                            } else {
                                              selectedToMembers.add(
                                                  _membersController.text);
                                            }
                                            _membersController.clear();
                                          }),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isShowCc,
                      child: ccWidget(
                          ccBcc: "CC",
                          selectedCCMembers: selectedCcMembers,
                          controller: _ccmembersController),
                    ),
                    // Visibility(
                    //   visible: isShowBcc,
                    //   child: bccWidget(
                    //       ccBcc: "BCC",
                    //       selectedMemeber: selectedBccMembers,
                    //       controller: _BccmembersController),
                    // ),
                    subject(controller: _subjectController),
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
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,

                              maxLines: null,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                  hintText: "Message",
                                  hintStyle: styleIbmPlexSansRegular(
                                      size: 16, color: grey),
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  border: InputBorder.none),
                              controller: _bodyController,
                              cursorColor: grey,
                            )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      if(selectedToMembers.isEmpty){
                        snackBar(context, "Please add one in to message.");
                      }else if(_bodyController.text.isEmpty){
                        snackBar(context, "Please enter message.");
                      }else {
                        if (isReply != null && isReply == true && isSentMessage == true) {
                          context.read<MessageCubit>().sendMessage(
                              "${user?.email}",
                              selectedToMembers,
                              selectedCcMembers,
                              _subjectController.text,
                              _bodyController.text,
                             0
                              );
                        } else {
                          context.read<MessageCubit>().sendMessage(
                              "${user?.email}",
                              selectedToMembers,
                              selectedCcMembers,
                              _subjectController.text,
                              _bodyController.text,
                             0
                          );
                        }
                      }
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14.0)),
                            color: defaultColor),
                        padding: const EdgeInsets.fromLTRB(17.0, 17.0, 17, 17.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send",
                              style: styleIbmPlexSansBold(size: 15, color: white),
                            )
                          ],
                        )),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  ccWidget(
      {String? ccBcc,
        TextEditingController? controller,
        List<String>? selectedCCMembers,
        int? isCcBcc}) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(
                const Radius.circular(10.0)),
            color: skyBlue),
        padding:
        const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Container(
                            child: Text(
                              "Cc",
                              style: styleIbmPlexSansRegular(
                                  size: 16, color: grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(onTap:(){
                          setState(() {
                            isShowCc = false;
                          });
                        },child: Icon(Icons.clear,color: Colors.grey,size: 18,))
                      ],
                    ),
                    Wrap(children: selectedCcMembers.map((item){
                      return  Container(
                        child:
                        selectedCcMemberWidget(
                          item,
                          '',
                          item
                              .substring(0, 1),
                        ),);
                    }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TypeAheadField(

                          textFieldConfiguration:
                          TextFieldConfiguration(
                            enableInteractiveSelection:
                            true,
                            cursorColor: grey,
                            decoration:
                            const InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: _ccmembersController,
                          ),
                          suggestionsCallback:
                              (pattern) async {
                            return await getCcMembers(pattern);
                          },
                          transitionBuilder: (context,
                              suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          itemBuilder:
                              (context, GetUserListTOCC suggestion) {
                            String icon = '';
                            return Padding(
                              padding:
                              const EdgeInsets.only(
                                  left: 8.0,
                                  top: 10,
                                  bottom: 5),
                              child: Container(
                                child: Row(
                                  children: [
                                    icon.isEmpty
                                        ? CircleAvatar(
                                      backgroundColor:
                                      defaultColor,
                                      child: Text(
                                        suggestion.userName?.substring(
                                            0,
                                            1).toUpperCase() ??
                                            '',
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            20,
                                            color: Colors
                                                .white),
                                      ),
                                      maxRadius: 15,
                                      foregroundImage:
                                      NetworkImage(
                                          "enterImageUrl"),
                                    )
                                        : ClipRRect(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          10),
                                      child:
                                      Image.asset(
                                          icon),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: SizeConfig.screenWidth * 0.65,
                                          color: Colors.white,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 10.0,
                                                top: 10),
                                            child: Text(
                                              suggestion
                                                  .userName.toString(),
                                              style:
                                              styleIbmPlexSansRegular(
                                                  size: 18,
                                                  color:
                                                  grey),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth * 0.65,
                                          color: Colors.white,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 10.0,
                                                top: 10),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              suggestion
                                                  .name.toString(),
                                              style:
                                              styleIbmPlexSansRegular(
                                                  size: 16,
                                                  color:
                                                  grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          onSuggestionSelected:
                              (GetUserListTOCC suggestion) {
                            _ccmembersController.text =
                                suggestion.userName.toString();
                            selectedCCMembers?.add(
                                _ccmembersController.text);

                            if (selectedCCMembers
                                !.contains(suggestion.userName)) {
                              CcMembers.remove(suggestion);
                            } else {
                              selectedCCMembers.add(
                                  _ccmembersController.text);
                            }
                            _ccmembersController.clear();
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // bccWidget(
  //     {String? ccBcc,
  //     TextEditingController? controller,
  //     List<String>? selectedMemeber,
  //     int? isCcBcc}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Container(
  //       decoration: const BoxDecoration(
  //           borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
  //           color: skyBlue),
  //       padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Container(
  //               child: Row(
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: const EdgeInsets.only(
  //                       left: 10.0,
  //                     ),
  //                     child: Container(
  //                       child: Text(
  //                         ccBcc ?? '',
  //                         style: styleIbmPlexSansRegular(
  //                             size: 16, color: grey),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 10,
  //                   ),
  //                   // Expanded(
  //                   //   child: Container(
  //                   //     child: Row(
  //                   //       children: [
  //                   //         Container(
  //                   //           child: Row(
  //                   //             children: List.generate(
  //                   //                 selectedMemeber?.length ?? 0, (index) {
  //                   //               return selectedBccMemberWidget(
  //                   //                   selectedMemeber?[index]);
  //                   //             }),
  //                   //           ),
  //                   //         ),
  //                   //         const SizedBox(
  //                   //           width: 10,
  //                   //         ),
  //                   //         Expanded(
  //                   //           child: TypeAheadField(
  //                   //               textFieldConfiguration:
  //                   //                   TextFieldConfiguration(
  //                   //                 cursorColor: grey,
  //                   //                 decoration: const InputDecoration(
  //                   //                   border: InputBorder.none,
  //                   //                 ),
  //                   //                 controller: controller,
  //                   //               ),
  //                   //               suggestionsCallback: (pattern) async {
  //                   //                 return await getMembers(pattern);
  //                   //               },
  //                   //               transitionBuilder:
  //                   //                   (context, suggestionsBox, controller) {
  //                   //                 return suggestionsBox;
  //                   //               },
  //                   //               itemBuilder: (context, String suggestion) {
  //                   //                 return Container(
  //                   //                   color: Colors.white,
  //                   //                   child: Padding(
  //                   //                     padding: const EdgeInsets.only(
  //                   //                         left: 10.0, top: 10),
  //                   //                     child: Text(
  //                   //                       suggestion.toString(),
  //                   //                       style: styleIbmPlexSansRegular(
  //                   //                           size: 18, color: grey),
  //                   //                     ),
  //                   //                   ),
  //                   //                 );
  //                   //               },
  //                   //               onSuggestionSelected: (String suggestion) {
  //                   //                 controller?.text = suggestion.toString();
  //                   //                 selectedBccMembers
  //                   //                     .add(controller?.text ?? '');
  //                   //                 controller?.clear();
  //                   //               }),
  //                   //         ),
  //                   //       ],
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                   InkWell(
  //                       onTap: () {
  //                         setState(() {
  //                           isShowBcc = false;
  //                         });
  //                       },
  //                       child: const Icon(
  //                         Icons.clear,
  //                         color: Colors.black26,
  //                         size: 20,
  //                       ))
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Container(
  //             child: const Row(
  //               children: [],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  selectedMemberWidget(
      String? name,
      String? icon,
      String? firstChar,
      ) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(50.0),
          right: Radius.circular(50.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
            mainAxisSize:  MainAxisSize.min,
            children: [
              icon!.isEmpty
                  ? CircleAvatar(
                backgroundColor: defaultColor,
                child: Text(
                  firstChar ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                maxRadius: 15,
                foregroundImage: NetworkImage("enterImageUrl"),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(icon),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(name ?? ''),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedToMembers.remove(name);
                ToResponseMembers.forEach((element) {
                  if(element.userName == name){
                    ToMembers.insert(0,element);
                  }
                });
                  });
                },
                child: const Icon(
                  Icons.clear,
                  size: 15,
                ),
              )
            ]),
      ),
    );
  }

  selectedCcMemberWidget(String? name, String? icon, String? firstChar) {
    return Container(
      margin: const EdgeInsets.only(left: 8, top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50.0),
          right: Radius.circular(50.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon!.isEmpty
                  ? CircleAvatar(
                backgroundColor: defaultColor,
                child: Text(
                  firstChar ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                maxRadius: 15,
                foregroundImage: NetworkImage("enterImageUrl"),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(icon),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(name ?? ''),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedCcMembers.remove(name);
                    CcResponseMembers.forEach((element) {
                      if(element.userName == name){
                        CcMembers.insert(0,element);
                      }
                    });
                  });
                },
                child: const Icon(
                  Icons.clear,
                  size: 15,
                ),
              )
            ]),
      ),
    );
  }

  selectedBccMemberWidget(
      String? name,
      ) {
    return Container(
      decoration: const BoxDecoration(
        color: defaultColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50.0),
          right: Radius.circular(50.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Text(name ?? ''),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              setState(() {
                // selectedBccMembers.remove(name);
              });
            },
            child: const Icon(
              Icons.clear,
              size: 15,
            ),
          )
        ]),
      ),
    );
  }

  subject({
    TextEditingController? controller,
  }) {
    if (isReply != null) {
      // controller?.text = widget.subject ?? '';
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 60,
        ),
        decoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            color: skyBlue),
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,

                  maxLines: null,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Subject",
                      hintStyle: styleIbmPlexSansRegular(size: 16, color: grey),
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none),
                  controller: controller,
                  cursorColor: grey,
                )),
          ],
        ),
      ),
    );
  }

  List<GetUserListTOCC> getToMembers(String query) {
    List<GetUserListTOCC> matches = [];
    matches.addAll(ToMembers);
    matches.retainWhere(
            (s) => s.userName.toString().toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
  List<GetUserListTOCC> getCcMembers(String query) {
    List<GetUserListTOCC> matches = [];
    matches.addAll(CcMembers);
    matches.retainWhere(
            (s) => s.userName.toString().toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
