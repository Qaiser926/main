import 'package:flutter/widgets.dart';

import '../../constants/asset_constants.dart';

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


Widget getRoundImage(Image image) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    clipBehavior: Clip.hardEdge,
    child: Container(child:image),
  );
}