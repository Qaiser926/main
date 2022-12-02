import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:othia/core/favourites/exclusive_widgets/page_view.dart';
import '../../../config/themes/color_data.dart';
import 'event_section.dart';
import '../../../utils/ui/ui_utils.dart';

Section buildSection({required TabView element}) {
  return Section(
    informationList: element.informationList,
    headerWidget: Container(
      color: lightGrey.withOpacity(0.8),
      child: Column(
        children: [
          getVerSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getCustomFont(text:
              element.tabName,fontSize:
              18,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
          getVerSpace(8),
        ],
      ),
    ),
  );
}