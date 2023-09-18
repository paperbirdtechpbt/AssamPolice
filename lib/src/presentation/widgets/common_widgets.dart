import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../domain/models/data/address.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/strings.dart';

snackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}

CoustomTextFieldEditBox({
  required BuildContext context,
  required String label,
  required String icon,
  required TextEditingController controller,
  required String hint,
  required  TextCapitalization textCapitalization,
  Icon? flutterIcon,
  InputBorder? inputBorder,
  Border? border,
  required int? length,
  String? Function(String?)? onChanged,
  required String? Function(String?)? validator,
  required TextInputAction textInputAction,
  required TextInputType textInputType,
  AutovalidateMode? autovalidateMode,
}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
        border: border,
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        color: skyBlue),
    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    child: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: icon.isEmpty
                  ? flutterIcon
                  : SvgPicture.asset(icon, height: 25.0, color: defaultColor)),
        ),
        const SizedBox(width: 15),
        Flexible(
            child: TextFormField(
keyboardType: textInputType,
          controller: controller,
              textCapitalization : textCapitalization,

              decoration: InputDecoration(

              border: inputBorder,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
              )),
          onChanged: onChanged,
          validator: validator,
          textInputAction: textInputAction,

          autovalidateMode: autovalidateMode,
          inputFormatters:
              length != null ? [LengthLimitingTextInputFormatter(10)] : [],
        )),
      ],
    ),
  );
}
CoustomLatLongTextFieldEditBox({
  required BuildContext context,
  required String label,
  required String icon,
  required TextEditingController controller,
  required String hint,
  Icon? flutterIcon,
  InputBorder? inputBorder,
  Border? border,
  required int? length,
  String? Function(String?)? onChanged,
  required String? Function(String?)? validator,
  required TextInputAction textInputAction,
  required TextInputType textInputType,
  AutovalidateMode? autovalidateMode,
}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        color: Colors.transparent),
    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
    child: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: icon.isEmpty
                  ? flutterIcon
                  : SvgPicture.asset(icon, height: 25.0, color: defaultColor)),
        ),
        const SizedBox(width: 15),
        Flexible(
            child: TextFormField(
              keyboardType: textInputType,
              controller: controller,


              decoration: InputDecoration(

                  border: inputBorder,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: hint,
                  focusedErrorBorder: const OutlineInputBorder(

                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(
                      width: 0,
                      color: Colors.transparent,
                    ),
                  )),
              onChanged: onChanged,
              validator: validator,
              textInputAction: textInputAction,

              autovalidateMode: autovalidateMode,
              inputFormatters:
              length != null ? [LengthLimitingTextInputFormatter(10)] : [],
            )),
      ],
    ),
  );
}
TextFieldEditBox({
  required BuildContext context,
  required String label,
  required String icon,
  required TextEditingController controller,
  required String hint,
  Icon? flutterIcon,
  InputBorder? inputBorder,
  Border? border,
  Function()? onChanged()?,
  required int? length,
  required String? Function(String?)? validator,
  required TextInputAction textInputAction,
  required TextInputType textInputType,
  AutovalidateMode? autovalidateMode,
}) {
  return Container(
    decoration: BoxDecoration(
        border: border,
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        color: skyBlue),
    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    child: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: icon.isEmpty
                  ? flutterIcon
                  : SvgPicture.asset(icon, height: 25.0, color: defaultColor)),
        ),
        sizeWidthBox(),
        Flexible(
            child: TextFormField(
keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
              border: inputBorder,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
              )),
          onChanged: (value) {
            controller.value = TextEditingValue(
                text: value,
                selection: TextSelection(
                    baseOffset: value.length, extentOffset: value.length));
            controller.value = value.trim() as TextEditingValue;
          },
          validator: validator,
          autovalidateMode: autovalidateMode,
          inputFormatters:
              length != null ? [LengthLimitingTextInputFormatter(10)] : [],
        )),
      ],
    ),
  );
}

TextFieldEditBoxBig({
  required BuildContext context,
  required String label,
  required TextEditingController controller,
  required String hint,
  required int? length,
  required String? Function(String?)? validator,
}) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        color: skyBlue),
    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10),
          child: Container(
              child: Icon(
            Icons.description,
            color: defaultColor,
          )),
        ),
        sizeWidthBox(),
        Flexible(
            child: TextFormField(
          controller: controller,
          autofocus: false,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
              )),
          onChanged: (value) {
            controller.value = TextEditingValue(
                text: value,
                selection: TextSelection(
                    baseOffset: value.length, extentOffset: value.length));
            // controller.value = value.trim() as TextEditingValue;
          },
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters:
              length != null ? [LengthLimitingTextInputFormatter(10)] : [],
        )),
      ],
    ),
  );
}

TextFieldEditBoxPassword({
  required BuildContext context,
  required String label,
  Icon? flutterIcon,
  required String icon,
  required TextEditingController controller,
  required String hint,
  required int? length,
  required String? Function(String?)? validator,
  required TextInputAction textInputAction,
  required TextInputType textInputType,
}) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        color: skyBlue),
    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    child: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
              child: icon.isEmpty
                  ? flutterIcon
                  : SvgPicture.asset(icon, height: 25.0, color: defaultColor)),
        ),
        sizeWidthBox(),
        Flexible(
            child: TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          obscureText: true,
          keyboardType: textInputType,
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hint,
              // suffixIcon: Padding(
              //     padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              //     child: GestureDetector(
              //       onTap: _toggleObscured,
              //       child: Icon(
              //         _obscured
              //             ? Icons.visibility_rounded
              //             : Icons.visibility_off_rounded,
              //         size: 24,
              //       ),
              //     )),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              )),
          onChanged: (value) {
            controller.value = TextEditingValue(
                text: value,
                selection: TextSelection(
                    baseOffset: value.length, extentOffset: value.length));
            // controller.value = value.trim() as TextEditingValue;
          },
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters:
              length != null ? [LengthLimitingTextInputFormatter(10)] : [],
        )),
      ],
    ),
  );
}

Button({
  required BuildContext context,
  required String label,
  required String icon,
  required String? Function()? onClick,
}) {
  return MaterialButton(
    height: 52.00,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.00)),
    onPressed: () {
      onClick?.call();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon.isNotEmpty) ...[
          SvgPicture.asset(icon, height: 25.0, color: defaultColor),
          sizeWidthBox()
        ],
        Text(
          label,
          style: styleIbmPlexSansLite(size: 15, color: white),
        )
      ],
    ),
    color: defaultColor,
  );
}

ButtonThemeLarge({
  required BuildContext context,
  required String label,
  required Color color,
  required String? Function()? onClick,
}) {
  return
  InkWell(
    onTap: () {
      onClick?.call();
    },
    child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(14.0)),
            color: color),
        padding: const EdgeInsets.fromLTRB(17.0, 17.0, 17, 17.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: styleIbmPlexSansBold(size: 15, color: white),
            )
          ],
        )),
  );
}

AddressWidget({
  required BuildContext context,
  required String label,
  required String? Function()? onClick,
}) {
  return InkWell(
      onTap: () {
        onClick?.call();
      },
      child: Row(
        children: [
          SvgPicture.asset(ic_gps, height: 40, width: 40, color: defaultColor),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: styleIbmPlexSansRegular(size: 12, color: grey),
                ),
                const Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ));
}

styleIbmPlexSansRegular({required double size, required Color color}) {
  return TextStyle(
      fontSize: size, color: color, fontFamily: ibmPlexSansRegular);
}

styleIbmPlexSansBold({required double size, required Color color}) {
  return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.bold,
      fontFamily: ibmPlexSansLight);
}

styleIbmPlexSansLite({required double size, required Color color}) {
  return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.bold,
      fontFamily: ibmPlexSansLight);
}

sizeWidthBox() {
  return const SizedBox(width: 10);
}

sizeHeightBox() {
  return const SizedBox(height: 15);
}

Widget widgetsAddress(Address? address, {required Function(Address?) onClick}) {
  return InkWell(
    onTap: () {
      onClick.call(address);
    },
    child: Card(
        color: white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SvgPicture.asset(ic_gps,
                      height: 40, width: 40, color: defaultColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${address?.locationName}",
                        style: styleIbmPlexSansBold(size: 15, color: grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
  );
}

onLoading(BuildContext context, String msg) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              // ) , child: Image.asset(loadingbar, height: 35, width: 35)),
            ),
            child:
                Image.asset(load, color: Colors.blue, height: 35, width: 35)),
      );
    },
  );
}

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  SizeConfig();
  void initSize(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }
}

sendReceivedMessageBox({
  Icon? flutterIcon,
  String? icon,
  String? name,
  Function? onTap()?,
  String? subTitle,
  String? firstChar,
  String? subject,
  String? date,
  bool? isSeenMessage,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
// so here your custom shadow goes:
            BoxShadow(
              color: Colors.black.withAlpha(4),
              blurRadius: 0.5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: ListTile(
          subtitle: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.60,
                    child: Text(
                        overflow: TextOverflow.ellipsis,
                        subject ?? '',
                        style: isSeenMessage == false
                            ? styleIbmPlexSansBold(
                                size: 14,
                                color: black,
                              )
                            : styleIbmPlexSansRegular(size: 14, color: grey)),
                  ),
                  isSeenMessage == false
                      ? const Icon(
                          Icons.mail_rounded,
                          color: Colors.black,
                          size: 20,
                        )
                      : Container(),
                ],
              ),
              const SizedBox(height: 3,),

Text(
                overflow: TextOverflow.ellipsis,
                subTitle ?? '',
                style: styleIbmPlexSansRegular(size: 16, color: grey),
              ),
            ],
          )),
          leading: icon!.isEmpty
              ? CircleAvatar(
                  backgroundColor: defaultColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        firstChar ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  maxRadius: 20,
                  foregroundImage: NetworkImage("enterImageUrl"),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(icon),
                ),
          title: Container(
            width: SizeConfig.screenWidth * 0.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: isSeenMessage == false
                        ? styleIbmPlexSansBold(
                            size: 17,
                            color: black,
                          )
                        : styleIbmPlexSansRegular(size: 16, color: black),
                  ),
                ),
                Text(
                  '${date}' ?? '',
                  style: styleIbmPlexSansRegular(size: 13, color: grey),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

onLoadingWithMessage(BuildContext context, String msg) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Container(
            height: 60,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(msg),
                ],
              ),
            )),
      );
    },
  );
}

onLoadingCircle(BuildContext context) {
  return Center(
    child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          // ) , child: Image.asset(loadingbar, height: 35, width: 35)),
        ),
        child: Image.asset(load, color: Colors.blue, height: 35, width: 35)),
  );
}

networkImage(String? url, double width, double? height) {
  return CachedNetworkImage(
    key: UniqueKey(),
    width: width,
    height: height,
    fit: BoxFit.cover,
    imageUrl: url!,
    placeholder: (context, url) => SvgPicture.asset(ic_profile,
        width: width, height: height, fit: BoxFit.cover, color: defaultColor),
    errorWidget: (context, url, error) => SvgPicture.asset(ic_profile,
        width: width, height: height, fit: BoxFit.cover, color: defaultColor),
  );
}
