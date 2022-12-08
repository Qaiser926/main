import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../constants/catgories.dart';
import 'exclusives/notifier.dart';

const itemCount = 8;

class CategoryFilter extends StatelessWidget {
  Image image = getAssetImage(categoryIds[1] + ".jpg");
  Image image2 = getAssetImage(categoryIds[2] + ".jpg");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ExpandedCategoryNotifier(),
        )
      ],
      child:
          Consumer<ExpandedCategoryNotifier>(builder: (context, model, child) {
        return CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate(getList(model)),
          )
        ]);
        //   children:
        //   crossAxisCount: 2,
        //   mainAxisSpacing: 10.h,
        //   crossAxisSpacing: 10.h,
        // );
      }),
    );
  }
}

List<Widget> getList(ExpandedCategoryNotifier expandedCategoryNotifier) {
  List<Widget> allMightyList = [];
  for (int index = 0; index < itemCount; index++) {
    if (index != 0 && index % 2 == 1) {
      if (expandedCategoryNotifier.getExpandedIndex == index ||
          expandedCategoryNotifier.getExpandedIndex == index - 1) {
        allMightyList.add(getAnimated(index, true));
      } else {
        allMightyList.add(getAnimated(index, false));
      }
    } else {
      int index2 = index + 1;

      Image image = getAssetImage(categoryIds[index] + ".jpg");
      Image image2 = getAssetImage(categoryIds[index2] + ".jpg");
      Widget firstSingleCategoryWidget;
      if (expandedCategoryNotifier.getExpandedIndex == index) {
        firstSingleCategoryWidget = SingleWid(
          image: image,
          index: index,
          categoryId: "ich bin eine ID",
          isExpanded: true,
        );
      } else {
        firstSingleCategoryWidget = SingleWid(
          image: image,
          index: index,
          categoryId: "ich bin eine ID",
          isExpanded: false,
        );
      }
      Widget secondSingleCategoryWidget;
      if(expandedCategoryNotifier.getExpandedIndex == index2){
        secondSingleCategoryWidget= SingleWid(
          image: image2,
          index: index2,
          categoryId: "ich bin eine ID",isExpanded: true,
        );
      } else {
        secondSingleCategoryWidget= SingleWid(
          image: image2,
          index: index2,
          categoryId: "ich bin eine ID",isExpanded: false,
        );
      }


      allMightyList.add(Row(
        children: [
          Flexible(child: firstSingleCategoryWidget),
          Flexible(child: secondSingleCategoryWidget)
        ],
      ));
    }
  }

  return allMightyList;
}

Widget getAnimated(int index, bool expanded) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    // margin: const EdgeInsets.all(20.0),
    width: !expanded ? 0 : 600,
    height: !expanded ? 0 : 100,
    color: Colors.red,
    child: Text(categoryIds[index]),
  );
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

// List<Widget> getAllCategoryWidgets(int? indexOfExpanded) {
//   List<Widget> categoryWidgets = [];
//   for (int i = 0; i < itemCount; i++) {
//     if (i != 0 && i % 2 == 0) {
//       categoryWidgets.add(
//           Text("ZWischenstopppdddddddddddddddddddddddddddddddddddddddddp0"));
//     }
//     Image image = getAssetImage(categoryIds[i] + ".jpg");
//
//     Widget singleCategoryWidget = SingleWid(
//       image: image,
//       index: i,
//       categoryId: "Ich bin eine ID",
//     );
//     // getSingleCategoryWidget(image: image, index: );
//     categoryWidgets.add(singleCategoryWidget);
//   }
//   // for (int i = 0; i < itemCount; i++) {
//   //   categoryWidgets.add(getAnimated(i));
//   // }
//
//   return categoryWidgets;
// }

//list of each bloc expandable state, that is changed to trigger the animation of the AnimatedContainer
List<bool> expandableState = List.generate(itemCount, (index) => false);

class SingleWid extends StatelessWidget {
  final int index;
  final Image image;
  final String categoryId;
  final bool isExpanded;

  Icon expandIcon = Icon(Icons.expand_more_outlined);

  SingleWid({
    super.key,
    required this.index,
    required this.image,
    required this.categoryId,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 300,
      child: Stack(
        children: [
          image,
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
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
                        var categoryProvider =
                            Provider.of<ExpandedCategoryNotifier>(context,
                                listen: false);
                        if (categoryProvider.getExpandedIndex == index) {
                          categoryProvider.setExpanded(
                              index: null, categoryId: null);
                        } else {
                          categoryProvider.setExpanded(
                              index: index, categoryId: categoryId);
                        }
                      },
                      icon: isExpanded
                          ? Icon(Icons.expand_more_outlined)
                          : Icon(Icons.expand_less_outlined),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class SingleWidState extends State<SingleWid> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       width: 300,
//       child: Stack(
//         children: [
//           widget.image,
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Spacer(),
//               Row(
//                 children: [
//                   Text("Ich bin eine Kategorie"),
//                   // ExpansionPanel(headerBuilder: (context, isExpanded) => Text("yes yes"), body: Text("")),
//                   SizedBox(
//                     width: 40.h,
//                     height: 40.h,
//                     child: IconButton(
//                       style: ButtonStyle(
//                           animationDuration: Duration(seconds: 1),
//                           splashFactory: NoSplash.splashFactory),
//                       splashColor: Colors.transparent,
//                       onPressed: () {
//                         var categoryProvider =
//                             Provider.of<ExpandedCategoryNotifier>(context,
//                                 listen: false);
//
//                         categoryProvider.setExpanded(
//                             index: widget.index, categoryId: widget.categoryId);
//
//                         setState(() {
//                           widget.expanded = !widget.expanded;
//                         });
//                       },
//                       icon: widget.expanded
//                           ? Icon(Icons.expand_more_outlined)
//                           : Icon(Icons.expand_less_outlined),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
