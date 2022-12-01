import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../widgets/event_or_activity_key_data.dart';


class Section extends MultiSliver {
  Section({
    Key? key,
    required Widget headerWidget,
    required List informationList,
  }) : super(
          key: key,
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: headerWidget,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      itemCount: informationList.length,
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var favouriteEventOrActivity = informationList[index];
                        // in theory the individual widget could be put in a class from here on with modalEvent as parameter

                        return EventOrActivityContainer(favouriteEventOrActivity: favouriteEventOrActivity,);
                      },
                    ),
                  )
                ],
              ))
            ])),
          ],
        );
}
