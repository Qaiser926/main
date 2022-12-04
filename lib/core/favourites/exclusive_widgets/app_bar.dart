import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/color_data.dart';
import '../../../constants/asset_constants.dart';
import '../../../utils/ui/ui_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteAppBar extends AppBar {
  final TabController tabController;
  final PageController pageController;
  final BuildContext context;

  FavouriteAppBar(
      {required this.tabController,
      required this.pageController,
      required this.context,
      super.key})
      : super(
          flexibleSpace: Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCustomFont(
                    text: AppLocalizations.of(context)!.favourites,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center)
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 70),
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
                  controller: tabController,
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
                        child: Text(AppLocalizations.of(context)!.events,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: AssetConstants.fontsFamily,
                                fontSize: 18.sp)),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(AppLocalizations.of(context)!.activities,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: AssetConstants.fontsFamily,
                                fontSize: 18.sp)),
                      ),
                    ),
                  ]),
            ),
          ),
        );
}
