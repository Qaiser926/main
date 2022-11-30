import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/asset_constants.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_svg/svg.dart';

Widget getAssetImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return Image.asset(
    AssetConstants.imagePath + image,
    color: color,
    width: width,
    height: height,
    fit: BoxFit.fill,
  );
}

AppBar getToolBar(Function function, {Widget? title, bool leading = true}) {
  return AppBar(
    toolbarHeight: 73.h,
    title: title,
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: leading == true
        ? Padding(
            padding: EdgeInsets.only(top: 26.h, bottom: 23.h),
            child: GestureDetector(
                onTap: () {
                  function();
                },
                child:
                    getSvgImage("arrow_back.svg", height: 24.h, width: 24.h)),
          )
        : null,
  );
}

Widget getRoundImage(Image image) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    clipBehavior: Clip.hardEdge,
    child: Container(child: image),
  );
}

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}

Widget getHorSpace(double verSpace) {
  return SizedBox(
    width: verSpace,
  );
}

Widget getMultilineCustomFontRestricted(
    String text, double fontSize, Color fontColor, int maxLines,
    {String fontFamily = 'Gilroy',
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight = 1.0}) {
  return ReadMoreText(
    text,
    trimLines: maxLines,
    trimMode: TrimMode.Line,
    trimCollapsedText: ' Read more',
    trimExpandedText: ' Show less',
    textAlign: textAlign,
    style: TextStyle(
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: fontColor,
      fontFamily: fontFamily,
      height: txtHeight,
      fontWeight: fontWeight,
    ),
    lessStyle: TextStyle(
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: Colors.green,
      fontFamily: fontFamily,
      height: txtHeight,
      fontWeight: fontWeight,
    ),
    moreStyle: TextStyle(
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      color: Colors.green,
      fontFamily: fontFamily,
      height: txtHeight,
      fontWeight: fontWeight,
    ),
  );
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = AssetConstants.fontsFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}

Widget getSvgImage(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return SvgPicture.asset(
    AssetConstants.imagePath + image,
    color: color,
    width: width,
    height: height,
    fit: boxFit,
  );
}

BoxDecoration getButtonDecoration(Color bgColor,
    {BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow> shadow = const [],
    DecorationImage? image}) {
  return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
      border: border,
      boxShadow: shadow,
      image: image);
}
