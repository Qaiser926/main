import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/asset_constants.dart';

import '../../config/themes/color_data.dart';
import '../../utils/services/from_bought_ui/widget_utils.dart';
import '../../utils/ui/upcoming_past_eventlist.dart';
import '../../widgets/event_activity_list.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildAppBar(),
          // Divider ist der schmale Strich unter der Appbar
          Divider(color: dividerColor, thickness: 1.h, height: 1.h),
          getVerSpace(17.h),
          buildTabBar(),
          Expanded(
            flex: 1,
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              // TODO define cases here
              children: [UpcomingAndPastEventList(), EventActivityList()],
              onPageChanged: (value) {
                controller.animateTo(value);
              },
            ),
          )
        ],
      ),
    );
  }

  Container buildTabBar() {
    return Container(
      // space between blue and and white
      height: 50,
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
                // todo language setting
                child: Text("Events",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: AssetConstants.fontsFamily,
                        fontSize: 18.sp)),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text("Aktivitäten",
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
        // TODO align for different languages
        title: getCustomFont("Favoriten", 24.sp, Colors.black, 1,
            fontWeight: FontWeight.w700, textAlign: TextAlign.center),
        leading: false);
  }


}
