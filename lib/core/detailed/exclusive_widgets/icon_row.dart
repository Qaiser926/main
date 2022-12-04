import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../utils/ui/ui_utils.dart';
import '../../../widgets/carousel_widget.dart';
import '../../../widgets/filtered_image_stack.dart';


class getIconRow extends StatelessWidget {

  getIconRow({super.key, });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // should bring back to previous screen
            Navigator.of(context).pop();
          },
          child: getSvgImage("arrow_back.svg",
              width: 24.h, height: 24.h, color: Colors.white),
        ),
        // when clicking of favourite, business logic must define to add that event
        GestureDetector(
            onTap: () {
              //TODO on click, add event to account favourites
              print("bobo");
              // backClick();
            },
            child: getSvgImage(
              "favourite_white.svg",
              width: 24.h,
              height: 24.h,
            ))
      ],
    );
  }}