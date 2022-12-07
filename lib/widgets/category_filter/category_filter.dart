import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../constants/catgories.dart';
import 'exclusives/notifier.dart';

class CategoryFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: ExpandedCategoryNotifier(),
          )
        ],
        child: Consumer<ExpandedCategoryNotifier>(
            builder: (context, model, child) {
          return GridView.count(
            children: getAllCategoryWidgets(model.indexOfExpanded),
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.h,
          );
        }));
  }
}

// class CategoryFilter extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return CategoryFilterState();
//   }
// }
//
// class CategoryFilterState extends State<CategoryFilter> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Row(children: [
//         Flexible(child: getExpansionPanel()),
//         Spacer(),
//         Flexible(child: getExpansionPanel())
//       ]),
//       Row(children: [
//         Flexible(child: getExpansionPanel()),
//         Spacer(),
//         Flexible(child: getExpansionPanel())
//       ]),
//     ]);
//
//     // ExpandIcon
//
//     // return ExpansionPanelList(children: [],)
//     // return Column(
//     //   children: [
//     //     getRow(),
//     //     getRow(),
//     //   ],
//     // );
//
//     // TODO: implement build
//     return GridView.count(
//       children: getAllCategoryWidgets(),
//       crossAxisCount: 2,
//       mainAxisSpacing: 10.h,
//       crossAxisSpacing: 10.h,
//     );
//   }
// }

Widget getRow() {
  return Row(
    children: [
      SizedBox(height: 200.h, width: 150.h, child: getExpansionPanel()),
      SizedBox(height: 200.h, width: 150.h, child: getExpansionPanel()),
    ],
  );
}

Widget getExpansionPanel() {
  return SizedBox(
      width: 60,
      child: ExpansionTileTheme(
          data: ExpansionTileThemeData(),
          child: ExpansionTile(
            onExpansionChanged: (value) {},
            controlAffinity: ListTileControlAffinity.platform,
            title: Text(""),
            children: [Text("xddffffffffffffffff")],
          )));
}

//number of childs used in the example
const itemCount = 8;

List<Widget> getAllCategoryWidgets(int? indexOfExpanded) {
  List<Widget> categoryWidgets = [];
  for (int i = 0; i < itemCount; i++) {
    Image image = getAssetImage(categoryIds[i] + ".jpg");

    Widget singleCategoryWidget = SingleWid(
      image: image,
      index: i,
    );
    // getSingleCategoryWidget(image: image, index: );
    categoryWidgets.add(singleCategoryWidget);
  }
  // for (int i = 0; i < itemCount; i++) {
  //   categoryWidgets.add(getAnimated(i));
  // }

  return categoryWidgets;
}

//list of each bloc expandable state, that is changed to trigger the animation of the AnimatedContainer
List<bool> expandableState = List.generate(itemCount, (index) => false);

class SingleWid extends StatefulWidget {
  final int index;
  bool expanded = false;
  final Image image;

  SingleWid({super.key, required this.index, required this.image});

  @override
  State<StatefulWidget> createState() {
    return SingleWidState();
  }
}

class SingleWidState extends State<SingleWid> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.image,
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text("Ich bin eine Kategorie"),
                // ExpansionPanel(headerBuilder: (context, isExpanded) => Text("yes yes"), body: Text("")),
                SizedBox(
                  width: 40.h,
                  height: 40.h,
                  child: IconButton(
                    style: ButtonStyle(
                        animationDuration: Duration(seconds: 1),
                        splashFactory: NoSplash.splashFactory),
                    splashColor: Colors.transparent,
                    onPressed: () {
                      if (widget.expanded) {
                        Provider.of<ExpandedCategoryNotifier>(context,
                                listen: false)
                            .indexOfExpanded = widget.index;
                      }
                      setState(() {
                        widget.expanded = !widget.expanded;
                      });
                    },
                    icon: Icon(Icons.expand_more_outlined),
                  ),
                ),
              ],
            ),
            getAnimated(widget.index, widget.expanded)
          ],
        )
      ],
    );
  }

  Widget getAnimated(int index, bool expanded) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      // margin: const EdgeInsets.all(20.0),
      width: !expanded ? 0: 600 * 1,
      height: !expanded ? 0 : 100 *1,
      color: Colors.red,
      child: Text("edrere"),
    );
  }
}
