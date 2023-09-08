import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

debugLog(BuildContext context, String tag, String message) {
  print("$tag , =====>>>  $message");
}

enum AddressType { home, office, other }

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future selectFile(
    {required BuildContext context,
    required bool? isCamera,
    required Function(String) error,
    required Function(List<File>) response}) async {
  double sizeInMb = 0;
  List<File> file = [];
  try {
    if (isCamera == true) {
      await ImagePicker()
          .pickImage(source: ImageSource.camera)
          .then((value) async {
        if (value != null) {
          file.add(File(value.path));
          sizeInMb = fileSize(File(value.path));
          if (sizeInMb > 5) {
            file = [];
            error.call("Image size is maximum 5 MB Supported");
          } else {
            response.call(file);
          }
        }
      });
    } else {
      final result = await ImagePicker().pickMultiImage();
      if (result.isNotEmpty) {
        result.forEach((element) async {
          file.add(File(element.path));
          sizeInMb = fileSize(File(element.path));
          if (sizeInMb > 5) {
            file = [];
            error.call("Image size is maximum 5 MB Supported");
          } else {
            response.call(file);
          }
        });
      }
    }
  } catch (e) {
    error("Sorry file is not selected please try again ");
  }
}

fileSize(File file) {
  final files = file;
  int sizeInBytes = files.lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  return sizeInMb;
}
