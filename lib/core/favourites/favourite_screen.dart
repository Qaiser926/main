import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/asset_constants.dart';

import '../../config/themes/color_data.dart';
import '../../utils/services/from_bought_ui/widget_utils.dart';
import '../../utils/ui/event_section.dart';
import '../../utils/ui/upcoming_past_eventlist.dart';
import '../../widgets/event_activity_list.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);


  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _scrollController;
  final String activityDescription = "Aktivität";
  final String eventDescription = "Event";
  final String appBarName = "Favoriten";
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      primary: true,
      appBar: AppBar(
        flexibleSpace: Container(
          height: 50,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getCustomFont(appBarName, 24.sp, Colors.black, 1,
                  fontWeight: FontWeight.w700, textAlign: TextAlign.center)
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 70),
            child: Container(
              // space between blue and and white
              height: 50,
              padding: EdgeInsets.all(5.h),
              margin: EdgeInsets.symmetric(horizontal: 12.h, vertical: 15.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(41.h),
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        offset: const Offset(0, 8),
                        blurRadius: 27)
                  ]),
              child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: greyColor,
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(44.h),
                      color: accentColor),
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
                        child: Text(eventDescription,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: AssetConstants.fontsFamily,
                                fontSize: 18.sp)),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(activityDescription,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: AssetConstants.fontsFamily,
                                fontSize: 18.sp)),
                      ),
                    ),
                  ]),
            )),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // TODO align for different languages
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _pageView(),
            _pageView(),
          ],
        ),
      ),
    ));
  }

  _pageView() {
    // TODO dynamically initialize whether there are future events or not
    return CustomScrollView(slivers: [
      Section(
        headerWidget: Container(
            color: Colors.white.withOpacity(0.5),
            child: ClipRRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Column(
                children: [
                  getVerSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      getCustomFont(
                        "Bevorstehende Events",
                        18,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w600,
                        fontFamily: AssetConstants.fontsFamily,
                      )
                    ],
                  ),
                  getVerSpace(8),

                ],
              ),
            ))),
      ),
      Section(
        headerWidget: Container(
            color: Colors.white.withOpacity(0.8),
            child: Column(
                children: [ getVerSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      getCustomFont(
                        "Zurückliegende Events",
                        18,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w600,
                        fontFamily: AssetConstants.fontsFamily,
                      )
                    ],
                  ),
                  getVerSpace(8)
                ],
              ),
            ),
      ),
    ]);
  }

  AppBar buildAppBar() {
    return getToolBar(
      () {},
      // TODO align for different languages
      title: getCustomFont("Favoriten", 24.sp, Colors.black, 1,
          fontWeight: FontWeight.w700, textAlign: TextAlign.center),

      leading: false,
    );
  }
}

//   Container buildTabBar() {
//     return Container(
//       // space between blue and and white
//       height: 50,
//       padding: EdgeInsets.all(5.h),
//       margin: EdgeInsets.symmetric(horizontal: 12.h),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(41.h),
//           boxShadow: [
//             BoxShadow(
//                 color: shadowColor, offset: const Offset(0, 8), blurRadius: 27)
//           ]),
//       child: TabBar(
//           controller: _tabController,
//           unselectedLabelColor: greyColor,
//           labelColor: Colors.white,
//           indicatorSize: TabBarIndicatorSize.tab,
//           indicator: BoxDecoration(
//               borderRadius: BorderRadius.circular(44.h), color: accentColor),
//           onTap: (index) {
//             pageController.animateToPage(
//               index,
//               duration: const Duration(milliseconds: 400),
//               curve: Curves.easeInOut,
//             );
//           },
//           tabs: [
//             Tab(
//               child: Align(
//                 alignment: Alignment.center,
//                 // todo language setting
//                 child: Text("Events",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontFamily: AssetConstants.fontsFamily,
//                         fontSize: 18.sp)),
//               ),
//             ),
//             Tab(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text("Aktivitäten",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontFamily: AssetConstants.fontsFamily,
//                         fontSize: 18.sp)),
//               ),
//             ),
//           ]),
//     );
//   }
//
//   AppBar buildAppBar() {
//     return getToolBar(() {},
//         // TODO align for different languages
//         title: getCustomFont("Favoriten", 24.sp, Colors.black, 1,
//             fontWeight: FontWeight.w700, textAlign: TextAlign.center),
//         leading: false);
//   }
//
//
// }
