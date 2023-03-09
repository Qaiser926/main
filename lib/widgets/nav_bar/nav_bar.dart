// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'nav_bar_notifier.dart';

// class CustomNavigationBar extends StatelessWidget {
//   const CustomNavigationBar({super.key});

//   @override
//   build(BuildContext context) {
//     return Consumer<NavigationBarNotifier>(builder: (context, model, child) {
//       return NavigationBar(
//           destinations: getCustomNavigationDestinations(),
          
//           // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//           selectedIndex: model.getIndex,
//           onDestinationSelected: (index) {
//             Provider.of<NavigationBarNotifier>(context, listen: false,)
//                 .setIndex(context: context, index: index);
//           });
//     });
//   }

//   List<Widget> getCustomNavigationDestinations() {
//     List<Widget> result = [];

//     result.add(CustomNavigationDestination(
//       selectedIcon: Icon(Icons.home_outlined, color: Colors.orange),
//       icon: const Icon(Icons.home_outlined),
//       // label: "",
//     ));

//     result.add(CustomNavigationDestination(
//       selectedIcon: Icon(Icons.search, color: Colors.orange),
//       icon: const Icon(Icons.search),
//       // label: "",
//     ));

//     result.add(CustomNavigationDestination(
//       selectedIcon: Icon(Icons.add, color: Colors.orange),
//       icon: const Icon(Icons.add),
//       // label: "",
//     ));

//     result.add(CustomNavigationDestination(
//       selectedIcon: Icon(Icons.favorite_outline, color: Colors.orange),
//       icon: const Icon(Icons.favorite_outline),
//       // label: "",
//     ));

//     result.add(CustomNavigationDestination(
//       selectedIcon: Icon(Icons.perm_identity, color: Colors.orange),
//       icon: const Icon(Icons.perm_identity),
//       // label: "",
//     ));
//     return result;
//   }
// }

// class CustomNavigationDestination extends NavigationDestination {
//   CustomNavigationDestination(
//       {required icon,String?  label, Widget? selectedIcon})
//       : super(
//           icon: icon,
//           label: label.toString(),

//           selectedIcon: selectedIcon,
//         );
// }

import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';

class CustomNavigationBar extends StatefulWidget {
  final int? index;
  final ValueChanged<int>? onChangedTab;

  CustomNavigationBar({ this.index,  this.onChangedTab});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final placeHolder = Opacity(
    opacity: 0,
    child: IconButton(onPressed: () {}, icon: Icon(Icons.no_cell)),
  );

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
              buildTabItem(index: 0, icon:OthiaConstants.homeIcon,hight: 19.h,width: 19.w),
              buildTabItem(index: 1, icon:OthiaConstants.searchIcon,hight: 19.h,width: 19.w),
              buildTabItem(index: 2, icon:OthiaConstants.addIcon,hight: 19.h,width: 19.w),
              buildTabItem(index: 3, icon:OthiaConstants.favIcon,hight: 16.h,width: 16.w),
              buildTabItem(index: 4, icon:OthiaConstants.profileIcon,hight: 14.h,width: 14.w),   
      ],
    ),
    
          ],
        ));
  }

  Widget buildTabItem({
    required int index,
    required String icon,
    // required String title,
    double? width,
    double? hight,
    Color? color,
    // required Widget title,
  }) {
    final isSelect = index == widget.index;
    return IconTheme(
      data: IconThemeData(color: isSelect ? Colors.red : Colors.black),
      child: Padding(
        padding:  REdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onTap: () => widget.onChangedTab!(index),
          child:   IconButton(
               icon: SvgPicture.asset (
                 icon,
                 color: isSelect ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary,
                 width:width,
                 height: hight,
               ),
               onPressed:null ,
             ),
        ),
      ),
    );
  }
}
