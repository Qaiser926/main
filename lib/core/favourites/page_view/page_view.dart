import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../constants/asset_constants.dart';
import '../../../utils/ui/event_section.dart';
import '../../../utils/ui/ui_utils.dart';

class PageViewBuilder extends StatefulWidget {
  List<Section> sectionList = [];

  PageViewBuilder({Key? key, required List<TabView> tabViewList}) {
    tabViewList.forEach((TabView element) {
      if (element.informationList.isNotEmpty) {
        this.sectionList.add(Section(
              headerWidget: Container(
                color: Colors.white.withOpacity(0.8),
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
              ),
            ));
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
    // TODO dynamically initialize whether there are future events or not
    return CustomScrollView(slivers: sectionList
    );
  }
}

class TabView {
  List informationList;
  String tabName;
  TabView({required final String this.tabName, required final List this.informationList});

}
