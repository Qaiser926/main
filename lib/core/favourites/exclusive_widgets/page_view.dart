import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:othia/core/favourites/exclusive_widgets/section_builder.dart';
import 'event_section.dart';


class PageViewBuilder extends StatefulWidget {
  List<Section> sectionList = [];

  PageViewBuilder({Key? key, required List<TabView> tabViewList}) {
    // initialize sectionList
    tabViewList.forEach((TabView element) {
      if (element.informationList.isNotEmpty) {
        this.sectionList.add(buildSection(element: element));
      }
    });
  }

  @override
  State<PageViewBuilder> createState() => _PageViewBuilderState(sectionList);
}

class _PageViewBuilderState extends State<PageViewBuilder> {
  final List<Section> sectionList;

  void backClick() {
    Get.back();
  }
  _PageViewBuilderState(this.sectionList);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: sectionList
    );
  }
}

class TabView {
  List informationList;
  String tabName;
  TabView({required final String this.tabName, required final List this.informationList});

}
