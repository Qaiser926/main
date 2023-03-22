import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/add/add.dart';

class CustomNavigationBar extends StatefulWidget {
  final int? index;
  final ValueChanged<int>? onChangedTab;

  CustomNavigationBar({ this.index,  this.onChangedTab});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final placeHolder = Opacity(
    opacity: 0,
    child: IconButton(onPressed: () {}, icon: Icon(Icons.no_cell)),
  );

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xff26343f),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          buildTabItem(index: 0, icon:OthiaConstants.homeIcon,hight: 19.h,width: 19.w),
          buildTabItem(index: 1, icon:OthiaConstants.searchIcon,hight: 19.h,width: 19.w),
        Container(
          height: 50.h,
          margin: EdgeInsets.only(bottom: 6),
          // width: 30.w,
          child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            Get.to(Add(),transition: Transition.fadeIn);
          },
          child: CircleAvatar(
            // minRadius: 20.r,
            child: Icon(Icons.add_outlined,color: Colors.white,size: 25.sp,),
            backgroundColor: Colors.transparent,

          ),
        );
          }),
        ),
          // buildTabItem(index: 2, icon:OthiaConstants.addIcon,hight: 19.h,width: 19.w),
          buildTabItem(index: 3, icon:OthiaConstants.favIcon,hight: 16.h,width: 16.w),
          buildTabItem(index: 4, icon:OthiaConstants.profileIcon,hight: 14.h,width: 14.w),

      ],
    ));
  }

  Widget buildTabItem({
    required int index,
    required String icon,
    // required String title,
    double? width,
    double? hight,
    Color? color,
    // required Widget title,
  }) {
    final isSelect = index == widget.index;
    return IconTheme(
      data: IconThemeData(color: isSelect ? Colors.red : Colors.black),
      child: Padding(
        padding:  REdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onTap: () => widget.onChangedTab!(index),
          child:   IconButton(
               icon: SvgPicture.asset (
                 icon,
                 color: isSelect ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary,
                 width:width,
                 height: hight,
               ),
               onPressed:null ,
             ),
        ),
      ),
    );
  }
}
