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
  late TabController _tabController;
  var _scrollController;
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
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[

        // TODO align for different languages


            SliverAppBar(
              backgroundColor: Colors.white,

              title: getCustomFont("Favoriten", 24.sp, Colors.black, 1,
                  fontWeight: FontWeight.w700, textAlign: TextAlign.center),
                automaticallyImplyLeading: false,
              pinned: true,
              floating: false,
              snap: false,

              forceElevated: innerBoxIsScrolled,
              bottom: AppBar(
                backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
          title: Container(
      // space between blue and and white
      height: 50,
      padding: EdgeInsets.all(5.h),
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(41.h),
          boxShadow: [
            BoxShadow(
                color: shadowColor, offset: const Offset(0, 8), blurRadius: 27)
          ]),
      child:
              TabBar(


                  controller: _tabController,
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
            ))),
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
    );
  }

  _pageView() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Text('List Item $index'),
          ),
        );
      },
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
