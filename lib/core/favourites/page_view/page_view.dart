import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:othia/config/themes/color_data.dart';
import '../../../constants/asset_constants.dart';
import '../../../utils/ui/event_section.dart';
import '../../../utils/ui/ui_utils.dart';

class PageViewBuilder extends StatefulWidget {
  List<Section> sectionList = [];

  PageViewBuilder({Key? key, required List<TabView> tabViewList}) {
    // initialize sectionList
    tabViewList.forEach((TabView element) {
      if (element.informationList.isNotEmpty) {
        this.sectionList.add(Section(
          informationList: element.informationList,
              headerWidget: Container(
                color: lightGrey.withOpacity(0.8),
                child: Column(
                  children: [
                    getVerSpace(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getCustomFont(
                          element.tabName,
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
    return CustomScrollView(slivers: sectionList
    );
  }
}

class TabView {
  List informationList;
  String tabName;
  TabView({required final String this.tabName, required final List this.informationList});

}
