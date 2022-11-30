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
      appBar: buildAppBar(),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[

        // TODO align for different languages


            SliverAppBar(
              toolbarHeight: 50.h,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,



              title: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, children: [getCustomFont("Favoriten", 24.sp, Colors.black, 1,
                    fontWeight: FontWeight.w700, textAlign: TextAlign.center),],),
                automaticallyImplyLeading: false,
              pinned: true,
              floating: false,
              snap: false,

              forceElevated: innerBoxIsScrolled,
              bottom: AppBar(
                toolbarHeight: 100.h,

                elevation: 0,
                backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
          // TODO try container in container approach but first try to implement that headings are really exchanged
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
      child: TabBar(


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
          ])
              ,
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
    return CustomScrollView(
      slivers: [
        Section(
          title: 'Category #1',
          headerColor: Colors.blue,
          items: List.generate(10, (index) => ListTile(
            title: Text('Item #${index + 1}'),
          )),
        ),
        Section(
          title: 'Category #2',
          headerColor: Colors.red,
          items: List.generate(10, (index) => ListTile(
            title: Text('Item #${index + 11}'),
          )),
        ),
      ]
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
