import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'favourite_scroll_view.dart';

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
                child: FavouriteScrollView(
                    informationList: informationList),
              )
            ])),
          ],
        );
}
