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

Widget getMultilineCustomFontRestricted({
  required BuildContext context,
  required String text,
  Color fontColor = Colors.black,
  required int maxLines,
  String fontFamily = 'Gilroy',
  TextDecoration decoration = TextDecoration.none,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.start,
}) {
  return ReadMoreText(
    text,


    trimLines: maxLines,
    trimMode: TrimMode.Line,
    trimCollapsedText: ' Read more',
    trimExpandedText: ' Show less',
    textAlign: textAlign,
    style: Theme.of(context).textTheme.headline2,
    lessStyle: Theme.of(context).textTheme.headline2,
    moreStyle: Theme.of(context).textTheme.headline2,
  );
}

Widget getCustomFont(
    {required String text,
    required double fontSize,
    int maxLine = 1,
    Color color = Colors.black,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        color: color,
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
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

Widget getRichText(
    {required String firstText,
    required Color firstColor,
    required FontWeight firstWeight,
    required double firstSize,
    required String secondText,
    required Color secondColor,
    required FontWeight secondWeight,
    required double secondSize,
    TextAlign textAlign = TextAlign.center,
    double? txtHeight}) {
  return RichText(
    textAlign: textAlign,
    text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: firstColor,
          fontWeight: firstWeight,
          fontSize: firstSize,
          height: txtHeight,
        ),
        children: [
          TextSpan(
              text: secondText,
              style: TextStyle(
                  color: secondColor,
                  fontWeight: secondWeight,
                  fontSize: secondSize,
                  height: txtHeight))
        ]),
  );
}

double getFontSize({required String fontSizeType}) {
  final Map fontSizeDict = { "headerFontSize": 18.0,
                              "textFontSize": 12.0};
  return fontSizeDict[fontSizeType];
}