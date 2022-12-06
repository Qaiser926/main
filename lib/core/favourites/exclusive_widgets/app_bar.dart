import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/theme_config.dart';
import '../../../constants/colors.dart';
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
          title: Text(AppLocalizations.of(context)!.favourites),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 70),
            child: Container(
              // space between blue and and white
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 12.h, vertical: 15.h),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(41.h),
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor,
                        offset: const Offset(0, 8),
                        blurRadius: 27)
                  ]),
              child: TabBar(padding: EdgeInsets.all(5.h),
                  controller: tabController,
                  onTap: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  tabs: [
                    Tab(
                      text: AppLocalizations.of(context)!.events,
                    ),
                    Tab(
                      text: AppLocalizations.of(context)!.activities,
                    ),
                  ]),
            ),
          ),
        );
}
