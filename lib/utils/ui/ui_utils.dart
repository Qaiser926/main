import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    fit: boxFit,
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
