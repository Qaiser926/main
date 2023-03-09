import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/home/home_page.dart';
import 'package:othia/core/profile/profile.dart';
import 'package:othia/core/search/search.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar/nav_bar.dart';
import '../widgets/nav_bar/nav_bar_notifier.dart';
import 'add/add.dart';
import 'favourites/favourite_screen.dart';

// class MainPage extends StatelessWidget {
//   static final List<Widget> _pages = [
//     HomePage(),
//     SearchPage(),
//     Add(),
//     const FavouritePage(),
//     ProfilePage(),
//   ];

//   MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     int initialPage =
//         Provider.of<GlobalNavigationNotifier>(context, listen: false)
//             .navigationBarIndex;
//     final PageController _pageController =
//         PageController(initialPage: initialPage);
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(
//           value: NavigationBarNotifier(
//               pageController: _pageController, index: initialPage),
//         ),
//       ],
//       child: Consumer<NavigationBarNotifier>(
//           builder: (context, navigationBarNotifier, child) {
//         return WillPopScope(
//           onWillPop: () {
//             return closeAppDialog(context, navigationBarNotifier);
//           },
//           child: Scaffold(
//             bottomNavigationBar:  CustomNavigationBar(),
//             body: PageView(
//               controller: _pageController,
//               physics: const NeverScrollableScrollPhysics(),
//               children: _pages,
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// Future<bool> closeAppDialog(
//     BuildContext context, NavigationBarNotifier notifier) async {
//   int currentSearchIndex = notifier.getSearchNotifier.currentIndex;
//   bool? shouldPop;
//   if (currentSearchIndex != NavigatorConstants.SearchPageIndex) {
//     if (currentSearchIndex - 1 == NavigatorConstants.SearchPageIndex) {
//       notifier.getSearchNotifier.backToDefault();
//     }
//     notifier.getSearchNotifier.setIndex = currentSearchIndex - 1;
//     shouldPop = false;
//   } else if (Provider.of<GlobalNavigationNotifier>(context, listen: false)
//       .isDialogOpen) {
//     shouldPop = false;
//   } else {
//     shouldPop = await showDialog<bool>(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(AppLocalizations.of(context)!.closeAppDialog),
//             actionsAlignment: MainAxisAlignment.spaceBetween,
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context, false);
//                 },
//                 child: Text(AppLocalizations.of(context)!.cancel),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context, true);
//                 },
//                 child: Text(AppLocalizations.of(context)!.confirm),
//               ),
//             ],
//           );
//         });
//   }
//   return shouldPop!;
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first


class MainPage extends StatefulWidget {
 
  @override
  State<MainPage> createState() =>
      _MainPageState();
}
class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  String text = '0';
  bool select = true;
  final _bottomnavigationGlobalkey = GlobalKey();
  static List<Widget> pages = <Widget>[
    HomePage(),
    SearchPage(),
    Add(),
     FavouritePage(),
    ProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currenScreen = HomePage();

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    int initialPage =
        Provider.of<GlobalNavigationNotifier>(context, listen: false)
            .navigationBarIndex;
    final PageController _pageController =
        PageController(initialPage: initialPage);
    return MultiProvider(
         providers: [
        ChangeNotifierProvider.value(
          value: NavigationBarNotifier(
              pageController: _pageController, index: initialPage),
        ),
      ],
      child:Consumer<NavigationBarNotifier>(
          builder: (context, navigationBarNotifier, child){
            return WillPopScope(
              onWillPop: () {
            return closeAppDialog(context, navigationBarNotifier);
          },
              child:  Scaffold(
        extendBody: true,
        key: scaffoldKey,
        bottomNavigationBar: CustomNavigationBar(
          
      
          index: currentIndex,
          onChangedTab: onChangeTab,
    
        ),
        body: pages[currentIndex],
      ),
);
          }
      
    ));
  }
  void onChangeTab(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }
  MaterialButton _bottomNavButton(String name, IconData icon,
      Function() onpress, int colorindex, int textindex) {
    return MaterialButton(
      onPressed: onpress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color:
                currentIndex == colorindex ? Theme.of(context).colorScheme.inversePrimary : Colors.grey,
          ),
       
         Text(  
             name,style: TextStyle(  fontSize: 12.sp,
            color: currentIndex == textindex ? Theme.of(context).colorScheme.inversePrimary: Colors.grey,),
           )
        ],
      ),
    );
  }
 
}

 Future<bool> closeAppDialog(
    BuildContext context, NavigationBarNotifier notifier) async {
  int currentSearchIndex = notifier.getSearchNotifier.currentIndex;
  bool? shouldPop;
  if (currentSearchIndex != NavigatorConstants.SearchPageIndex) {
    if (currentSearchIndex - 1 == NavigatorConstants.SearchPageIndex) {
      notifier.getSearchNotifier.backToDefault();
    }
    notifier.getSearchNotifier.setIndex = currentSearchIndex - 1;
    shouldPop = false;
  } else if (Provider.of<GlobalNavigationNotifier>(context, listen: false)
      .isDialogOpen) {
    shouldPop = false;
  } else {
    shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.closeAppDialog),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(AppLocalizations.of(context)!.confirm),
              ),
            ],
          );
        });
  }
  return shouldPop!;
}