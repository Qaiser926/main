import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';

import '../../constants/asset_constants.dart';

Image getAssetImage(String image,
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

ImageProvider getAssetImageProvider(String image,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain}) {
  return getAssetImage(image, height: height, width: width, boxFit: boxFit)
      .image;
}


Widget getRoundedImage(Image image) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(31),
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
  required TextStyle? textTheme,
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
    style: textTheme,
    lessStyle: textTheme,
    moreStyle: textTheme,
  );
}
