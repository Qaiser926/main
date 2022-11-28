import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/asset_constants.dart';

import '../../config/themes/color_data.dart';
import '../../utils/services/from_bought_ui/widget_utils.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> with SingleTickerProviderStateMixin {
  late TabController controller;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAppBar(),
        Divider(color: dividerColor, thickness: 1.h, height: 1.h),
        getVerSpace(20.h),
        buildTabBar(),
        Expanded(
          flex: 1,
          child: PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            // TODO define cases here
            children: const [Text("test"), Text("test")],
            onPageChanged: (value) {
              controller.animateTo(value);
            },
          ),
        )
      ],
    );
  }
  Container buildTabBar() {
    return Container(
      padding: EdgeInsets.all(5.h),
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(41.h),
          boxShadow: [
            BoxShadow(
                color: shadowColor, offset: const Offset(0, 8), blurRadius: 27)
          ]),
      child: TabBar(
          controller: controller,
          unselectedLabelColor: greyColor,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(44.h), color: accentColor),
          onTap: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          tabs: [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text("Upcoming",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: AssetConstants.fontsFamily,
                        fontSize: 18.sp)),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text("Past",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: AssetConstants.fontsFamily,
                        fontSize: 18.sp)),
              ),
            ),
          ]),
    );
  }

  AppBar buildAppBar() {
    return getToolBar(() {},
        title: getCustomFont("My Ticket", 24.sp, Colors.black, 1,
            fontWeight: FontWeight.w700, textAlign: TextAlign.center),
        leading: false);
  }
}
