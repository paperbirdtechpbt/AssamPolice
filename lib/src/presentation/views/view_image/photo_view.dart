import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import '../../../utils/constants/assets.dart';

class ViewImage extends StatefulWidget {
  final File file;

  const ViewImage({Key? key, required this.file})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewImage(file);
}

class _ViewImage extends State<ViewImage>
    with TickerProviderStateMixin {
  final File file;
  _ViewImage(this.file);

  @override
  Widget build(
      BuildContext context,
      ) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
      Brightness.light, //navigation bar icons' color
    ));
    ImageProvider<Object> imageProvider =  FileImage(file);


    return Scaffold(
        backgroundColor: Colors.black,
        body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Container(
                  color: Colors.black,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, right: 24 ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () =>
                                            {Navigator.pop(context)},
                                            child: SvgPicture.asset(ic_arrow_left)),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    )
                                  ]),
                            )),
                      ]),
                ),
              ),
              Expanded(child: Container(
                  child: PhotoView(
                    imageProvider :  imageProvider,
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  )),
              )],
          ),
        ));
  }
}
