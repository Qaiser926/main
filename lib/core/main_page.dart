import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class MainPage extends StatelessWidget {
  static final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    Add(),
    const FavouritePage(),
    const ProfilePage(),
  ];

  MainPage({Key? key}) : super(key: key);

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
      child: Consumer<NavigationBarNotifier>(
          builder: (context, navigationBarNotifier, child) {
        return WillPopScope(
          onWillPop: () {
            return closeAppDialog(context, navigationBarNotifier);
          },
          child: Scaffold(
            bottomNavigationBar: const CustomNavigationBar(),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
          ),
        );
      }),
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
