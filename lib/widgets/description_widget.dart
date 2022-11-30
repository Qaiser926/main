import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class DescriptionWidget extends StatelessWidget {
  String description;

  DescriptionWidget({super.key, required this.description});

  // idea is to state the price information if exists and return a clickable Button in case a ticket link exists as well

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            // edgeInsets define the borders of the padding, here no vertical margins are defined
            // the second element (here: ReadMoreText) is the child of the padding, the element that gets the space
            EdgeInsets.symmetric(horizontal: 20.h),
        child:
            // ReadMore is a widget that allows to expand and collapse text
            // mit predata text and post data text, könnte man später die summary abfragen, falls vorhanden
            ReadMoreText(
          description,
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Read more...',
          trimExpandedText: 'Show less',
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              height: 1.5.h),
          lessStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
          moreStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ));
  }
}
