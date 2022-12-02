import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:othia/config/themes/color_data.dart';
import 'package:othia/core/favourites/exclusive_widgets/section_builder.dart';
import 'package:othia/modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';
import '../../../utils/ui/ui_utils.dart';
import 'event_section.dart';


class PageViewBuilder extends StatefulWidget {
  // TODO: implement empty screen message
  List<Section> sectionList = [];
  final String nothingToShowMessage;

  PageViewBuilder({Key? key, required List<TabView> tabViewList, required String this.nothingToShowMessage}) {
    // initialize sectionList
    tabViewList.forEach((TabView element) {
      if (element.informationList2.isNotEmpty) {
        this
            .sectionList
            .add(buildSection(element: element));
      }
    });
  }

  @override
  State<PageViewBuilder> createState() => _PageViewBuilderState(sectionList);
}

class _PageViewBuilderState extends State<PageViewBuilder> {
  List<Section> sectionList;

  void backClick() {
    Get.back();
  }

  _PageViewBuilderState(this.sectionList);

  @override
  Widget build(BuildContext context) {
    if (sectionList.isEmpty){
      return getCustomFont(fontSize: 18, text: "placeholder", color: greyColor);
    } else {
      return CustomScrollView(slivers: sectionList);
    }
  }



}

class TabView {
  List<FavouriteEventOrActivity> informationList2 = [];
  String tabName;

  TabView({required final String this.tabName, required informationList}){
    this.informationList2 = informationList;
  }
}
