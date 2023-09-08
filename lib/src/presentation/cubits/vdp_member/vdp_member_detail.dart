import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/colors.dart';
import '../../widgets/common_widgets.dart';

class VdpMemberDetailView extends StatefulWidget {
  const VdpMemberDetailView({super.key});

  @override
  State<VdpMemberDetailView> createState() => _VdpMemberDetailViewState();
}

class _VdpMemberDetailViewState extends State<VdpMemberDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Member Detail"),),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: Container(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: defaultColor,
                              child: Text(
                                "A" ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    color: Colors.white),
                              ),
                              maxRadius: 40,
                              foregroundImage: NetworkImage("enterImageUrl"),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.edit,color: defaultColor,),
                      Text("Edit",style: styleIbmPlexSansRegular(size: 16, color: defaultColor),),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Row(
                  children: [
                    Text("Name : ",style: styleIbmPlexSansBold(size: 16, color: grey),),
                    Text("Anil Thakor",style: styleIbmPlexSansBold(size: 16, color: grey),),
                  ],
                ),
              )
            ],
          ),
        ),

      ],),
    );
  }
}
