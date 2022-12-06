import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/ui/ui_utils.dart';

// TODO work in progress

SizedBox buildDropdownBar() {
  return SizedBox(
    height: 50.h,
    child: ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print("tapped");
          },
          child: Container(
              margin:
              EdgeInsets.only(right: 12.h, left: index == 0 ? 20.h : 0),
              height: 50.h,
              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.h)),
              alignment: Alignment.center,
              child:  Row(
                children: [
                  getCustomFont(
                    text: "example text",fontSize:  16.sp, maxLine:
                    1,
                    fontWeight: FontWeight.w600,
                  ),
                  Icon(Icons.arrow_drop_down, size: 20.h,),
                  getHorSpace(13.h)
                ],
              ),
            ),
          );
      },
    ),
  );
}