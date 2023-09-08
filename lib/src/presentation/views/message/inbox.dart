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
import 'package:intl/intl.dart'; // Import the intl package
import 'package:flutter/foundation.dart';

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
    await preferences.getSignInModel(keySaveSignInModel).then((data) =>
    {
      // setState(() {
        user = data?.user,
        context.read<MessageCubit>().getReceivedMessages("${user?.email}", 0, 1),

      // })
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
          .map((MenuItemType menuItemType) =>
          PopupMenuItem<MenuItemType>(
            value: menuItemType,
            child: Text(getMenuItemString(menuItemType)),
          ))
          .toList(),
    ).then((MenuItemType? item) {
      if (item == MenuItemType.SENTMSG) {
        appRouter.push(SentMessageViewRoute());
      }
    });
  }
  int index = 0;
  String userNetworkImage =
      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKgAAACmCAMAAAB5nzT2AAAA7VBMVEX///9rgJv/zrVPYHQAAADo6OgAvNXTqpbFzdZedpQCq8I8UWi7wcf/0bdNXnHes51hdY1UZnvw8PDRpY9le5dHWm8AuNMfHx/i4uLFxcXey8P/1rzYuKldcIfW3OJRXHBJSUnX19c+Pj7pvaZ2gZCLi4uDg4OYmJi0tLRaWlp+ZVkzMzP/2MT/6+KVnahpdoYxSGGHl6qyu8ifqrp4i6MykqhHcIWkpKRsa2o+MixLPTWmh3YbFBK0lIKWeWpvWk8pIR1cSUEUAABgVE713dG21dyRytVCtchivM3e8/d6ydic3enI6vJExduz5e4KHUelAAAHnElEQVR4nO2aa3eaShSGQaWICgpCgjHapJomTdtYTdKkWm3S01suzf//OWcGUebCAGOM267F+6VLzGwe332ZwaoouXLlypUrV65cuXLlyvXPS2udHB+9RTo6vmpp0DQCOSfXB+93S0vtvj843j5WrfWuFKc3J1vF6hwfxGJiHRxD00U6eSPEDFBb0IBz+fFJJ3XkQEMiHSbbOde1D42pnOymYyK9ASY9FDcRK1DSq2x2gnvayo6JdA3WUYcSfmK9hQJ9K8dZKgHNU1/SUDT5YbZTuQoNdPSvgL4D6adredATCM5DeU6YzEv3fKl0BQIanpm+jLODXkNwOvNdfmwWJplR38GBfq23C+3eNA11Ngn+OYBoei04hk7MQqFgmqb+7UYE+fXLtGeapwEoxMD3Mei4h0Exa7swnd1ysDe3p5N6u43e1/F77w+hQGftwkJm2+zV9cnp7fjmK0b8cjubTPUeujx//xYUtG4WSJlYczIz1OKt9hT9+S7EqUTDzdQuxMo0+Us9KFDc9WMBaJzaN4CgMxnQGRCogkCnfIqFMnUoULSF6hKghd4NHGhPBrTwDQj0Go17GU5zAjNHlaPSqQxnwZwCPdpfzTf67KD6DcihBD0yTSWmE9b4AIJTOfwu1fRokt6CnEeV/bGcn4X26X8QnB/1b5KZb09PfwCA7jVlS9TUZ/ub53T2m3KYmLTZ3HzbO01dHlRv7m0c1G/qUvtSCLr53P9AoHLTCUnX/w3Qnq7rEKB1SVCzB+Eoaqa6pKFmHaKZHJTGFUABvoHYk59PdYCmR9pvSs4nVKIgxzxHskjNXvMjBCfeRSUdBeJE+iDlKBgmOurJgH4ABFVkQOESr8jlHpJTJvegmVeU7Ns9aOYlLAU2NDsosKHZ2wkcNOOEgnhOZpTNUmhKJWOVwideyWQpdMuHSp2l5lYYqijpT6Nb8hPS1G8i9G0BTTnp1/UtSb2eTIoelbYGNOFLE/ytwxaBCss04Gxuwb6E5KAnfF3w/U7Aqe9vRTM5Wkgag1kIObVtIEUUWkCK0m8ymPUFpwb/Y2xNi0gx6lIh5pwTnlQLMUJSVAGhwpcLTmhSZ4GhLUlpLTlhyzTiFJASnJCkJCfKPofZpDjhku/4FAfnKcOp+TCeamd2zUkiZTmdmn22cVStPPjkeX2N0V4Cp6b1Pe/ToLxJ1u7ZoOoVi0WvzJE2xZzlYEl1cNbdFGet4+F7orsOHBEpz+kMwkVep/byjE63NjQ6xYWqbJUush/DWasul3WMYa37kjOgOxqqhqs2lne0uCqde8pzogq1lssaqmuow9FLlUB5qLquihQ5WrR4SxFpDKdTiziLHRwFxRqW10/ZHblGQIlBo3t6fZ9j0vb2eHq/70WfrhMGQiHXbKt/rhrqUgQoqlLevJ+/eHiiQiNQJEM9X+Nvoc5VVyVkE6B84zvdSuUXd3HgEaA2Gc1Vz9eEWTYMlYpsFwlxjY84K5WfbIVWyTU29blVw1hHrTrndFQESt4TNT5dpd3flYCUwveJlsfiQp4/e1g5F2xQ1aVv6tGW/qnM1aUM9aglFh/z4pmkXZWLiVNPotI7/oKTJu2ToBab+nmlPqv94ziRGh3biljJKr1fclZ++5GhUYValt1pxMV8Fqkfzxmos2wpy16C/qoQ+rMEjcaE3REGdNWV55QzFHOS+9PSUucPCVq54w0VcyLS4ap1OkriVKMhtWh8R7n7TXDeh48qZMvbSRHd0WqcvpEUldyevNqcU1GeCNDH8KGKbHkryVLVWC35iYl36cbHluI1j68i3SkBqU+3fGLQ4Sqc3YyJX1RpsOgh4tx5VAJSelNKSf4qnc/tSKQa1M1x488X3ROgT8EVx6b3h2LscFqArrDtaxfZDcWW8qAPwRXG0BRLL+Qf/cpJreSyoF4/sPTuLwF6Hxja91jQpEytcDxJzDybetz4eNHjDtFMfwNDWc7E1K+S+6RwKp97dC5Fi55I0FfY0AFnaEpgWU4ncYhyRyhUpThpDyToDrpQZis0cTwhGbK7UzcFlLPUstGqv6ShO2iQsi2faqghO6BqaaBcleLGpzKPBinX8skVikFlv5wYpYFSe2hgad+5o0EflD77N4k7aAAqu98nNz0W/USC5LWeGNAW1/LpUWXbPnGjj7fU61MliuYTO0PTDZXf7oeCOOQLtlFeX9Kgl6+ZP7CEoSLJgsZvoC7VC6ylxSINyr5LG9qIJ71YDyh1K24jpS3lDKU3z856QGODqA16DHYYkuJnopt2PrPv0hVqCyaVHKcjALXo1ywKaSlnaJFeawlA5bYmIajLvBZayhnKgLkvCtpho4stTTO0IZpVcqC+CJSJzlm6bHz2OvsRuVALyT3gdeOD2BZ7qBA1Pt/yqaFCyZ1KBE92Nnc/7mwyr1K+5dmK5EPNJfl8V47/tDa/W8dbmmqoKzzxyT2MlGMddWOc4arURpbucKdVbllRcEJx1wJqxXx7xJ6NsaWsoXw9dkSHfUnQUVwM7B7fq1yVFvmW58/L6JwgGKRyB9KRESe7Wq163FWvyujykr0Sv8iOvYkcaLccqxpS7MU0ZYsUaGP/pZsrV65cuXLlypUrVy44/Q+V6dxBU8gaIAAAAABJRU5ErkJggg==";

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

          title: Text(
            "Inbox",

          ),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.more_vert_outlined)
                    ),
                    onTapDown: (details) {
                      showPopUpMenu(details.globalPosition);
                    })
            ),


          ],
        ),
        body: Center(
          child: RefreshIndicator(
            color: defaultColor,
            onRefresh: (){
return Future.delayed( Duration(seconds: 1),(){

  setState(() {
    context.read<MessageCubit>().getReceivedMessages("${user?.email}", 0, 1);

    print("Refreshed Page ============================>");
  });
});
            },
            child: SingleChildScrollView(
              child: Container(
                alignment:Alignment.center,
                child: BlocConsumer<MessageCubit, MessageState>(
                  listener: (context, state) {
                    if(state is GetReceivedMessagesSuccessState){
                      members = state.getReceivedMessagesResponse?.data ?? [];


                    }
                  },
                  builder: (context, state) {

                    switch(state.runtimeType){
                      case GetReceivedMessagesInitialState :  return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: List.generate(members.length, (index) {
                                  final parsedDate = DateTime.parse(members[index].creationDate.toString());
                                  final formattedDate = DateFormat('dd MMM').format(parsedDate);
                                  return sendReceivedMessageBox(
                                    isSeenMessage: members[index].isSeen,
                                    icon: '',
                                      subject: members[index].subject,
                                      firstChar: members[index].senderUserName?.substring(0, 1),
                                      name: members[index].senderUserName,
                                      date: formattedDate,
                                      onTap: () {
                                        appRouter
                                            .push(MessageScreenRoute(getReceivedMessages: members[index]));
                                      },
                                      subTitle: members[index].messageBody,

                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      );
                      case GetReceivedMessagesLoadingState : return const Center(child: CircularProgressIndicator(color: defaultColor,),);
                      case GetReceivedMessagesSuccessState :  return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Column(
                                  children: List.generate(members.length, (index) {
                                    final parsedDate = DateTime.parse(members[index].creationDate.toString());
                                    final formattedDate = DateFormat('dd MMM').format(parsedDate);
                                    return sendReceivedMessageBox(
                                      isSeenMessage: members[index].isSeen,
                                        icon: '',
                                        subject: members[index].subject,
                                        firstChar: members[index].senderUserName?.substring(0, 1),
                                        name: members[index].senderUserName,
                                        date: formattedDate,
                                        onTap: () {
                                          appRouter
                                              .push(MessageScreenRoute(getReceivedMessages: members[index],isSentMessage: false));
                                        },
                                        subTitle: members[index].messageBody);
                                  }),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                      default : return  SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Column(
                                  children: List.generate(members.length, (index) {
                                    final parsedDate = DateTime.parse(members[index].creationDate.toString());
                                    final formattedDate = DateFormat('dd MMM').format(parsedDate);
                                    return sendReceivedMessageBox(
                                        icon: '',
                                        subject: members[index].subject,
                                        firstChar: members[index].senderUserName?.substring(0, 1),
                                        name: members[index].senderUserName,
                                        date: formattedDate,
                                        onTap: () {
                                          appRouter
                                              .push(MessageScreenRoute(getReceivedMessages: members[index]));
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
