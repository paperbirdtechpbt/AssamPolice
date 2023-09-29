import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/router/app_router.dart';
import '../../../domain/models/data/get_received_message.dart';
import '../../../domain/models/data/user.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/reference/my_shared_reference.dart';
import '../../cubits/message/message_cubit.dart';
import '../../cubits/message/message_state.dart';
import '../../widgets/common_widgets.dart';
import 'package:intl/intl.dart';

enum MenuItemType {
  SENTMSG,
}

getMenuItemString(MenuItemType menuItemType) {
  switch (menuItemType) {
    case MenuItemType.SENTMSG:
      return "Sent message";
  }
}

class InBoxScreen extends StatefulWidget {
  const InBoxScreen({super.key});

  @override
  State<InBoxScreen> createState() => _InBoxScreenState();
}

class _InBoxScreenState extends State<InBoxScreen> {
  List<GetReceivedMessages> members = [];
  late User? user = User();
  getUser() async {
    var preferences = MySharedPreference();
    await preferences.getSignInModel(keySaveSignInModel).then((data) => {
          user = data?.user,
          context.read<MessageCubit>()
              .getReceivedMessages("${user?.email}", 0, 1),
        });
  }

  showPopUpMenu(Offset offset) async {
    final screenSize = MediaQuery.of(context).size;
    double left = offset.dx;
    double top = offset.dy;
    double right = screenSize.width - offset.dx;
    double bottom = screenSize.height - offset.dy;

    await showMenu<MenuItemType>(
      context: context,
      position: RelativeRect.fromLTRB(left, top, right, bottom),
      items: MenuItemType.values
          .map((MenuItemType menuItemType) => PopupMenuItem<MenuItemType>(
                value: menuItemType,
                child: Text(getMenuItemString(menuItemType)),
              ))
          .toList(),
    ).then((MenuItemType? item) {
      if (item == MenuItemType.SENTMSG) {
        appRouter.push(const SentMessageViewRoute());
      }
    });
  }

  int index = 0;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Inbox",
          ),
          actions: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: GestureDetector(
                    child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.more_vert_outlined)),
                    onTapDown: (details) {
                      showPopUpMenu(details.globalPosition);
                    })),
          ],
        ),
        body: RefreshIndicator(
          color: defaultColor,
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                context
                    .read<MessageCubit>()
                    .getReceivedMessages("${user?.email}", 0, 1);
              });
            });
          },
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: BlocConsumer<MessageCubit, MessageState>(
                listener: (context, state) {
                  if (state is GetReceivedMessagesSuccessState) {
                    members = state.getReceivedMessagesResponse?.data ?? [];
                  }
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case GetReceivedMessagesInitialState:
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children:
                                    List.generate(members.length, (index) {
                                  final parsedDate = DateTime.parse(
                                      members[index].creationDate.toString());
                                  final formattedDate =
                                      DateFormat('dd MMM').format(parsedDate);
                                  return sendReceivedMessageBox(
                                    isSeenMessage: members[index].isSeen,
                                    icon: '',
                                    subject: members[index].subject,
                                    firstChar: members[index]
                                        .senderUserName
                                        ?.substring(0, 1),
                                    name: members[index].senderUserName,
                                    date: formattedDate,
                                    onTap: () {
                                      appRouter.push(MessageScreenRoute(
                                          getReceivedMessages: members[index]));
                                      return null;
                                    },
                                    subTitle: members[index].messageBody,
                                      messageCount :members[index].messageCount
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      );
                    case GetReceivedMessagesLoadingState:
                      return const Center(
                        child: CircularProgressIndicator(
                          color: defaultColor,
                        ),
                      );
                    case GetReceivedMessagesSuccessState:
                      if (members.isNotEmpty)
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    children:
                                        List.generate(members.length, (index) {
                                      final parsedDate = DateTime.parse(
                                          members[index]
                                              .creationDate
                                              .toString());
                                      final formattedDate = DateFormat('dd MMM')
                                          .format(parsedDate);
                                      return sendReceivedMessageBox(
                                          isSeenMessage: members[index].isSeen,
                                          icon: '',
                                          subject: members[index].subject,
                                          firstChar: members[index]
                                              .senderName
                                              ?.substring(0, 1),
                                          name: members[index].senderName,
                                          date: formattedDate,
                                          onTap: () {
                                            appRouter.push(MessageScreenRoute(
                                                getReceivedMessages:
                                                    members[index],
                                                isSentMessage: false));
                                            return null;
                                          },
                                          subTitle: members[index].messageBody);
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      else
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.30),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  ic_not_data,
                                  color: defaultColor,
                                  height: SizeConfig.screenHeight * 0.20,
                                ),
                                Center(
                                  child: Text(
                                    "No Record Found",
                                    style: styleIbmPlexSansBold(
                                        size: 20, color: defaultColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                    default:
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Column(
                                  children:
                                      List.generate(members.length, (index) {
                                    final parsedDate = DateTime.parse(
                                        members[index].creationDate.toString());
                                    final formattedDate =
                                        DateFormat('dd MMM').format(parsedDate);
                                    return sendReceivedMessageBox(
                                        icon: '',
                                        subject: members[index].subject,
                                        firstChar: members[index]
                                            .senderUserName
                                            ?.substring(0, 1),
                                        name: members[index].senderUserName,
                                        date: formattedDate,
                                        onTap: () {
                                          appRouter.push(MessageScreenRoute(
                                              getReceivedMessages:
                                                  members[index]));
                                          return null;
                                        },
                                        subTitle: members[index].messageBody);
                                  }),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: defaultColor,
          foregroundColor: Colors.white,
          onPressed: () {
            appRouter.push(ComposeMessageScreenRoute());
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ));
  }
}
