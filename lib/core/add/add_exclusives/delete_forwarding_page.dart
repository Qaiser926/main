import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/nav_bar/nav_bar_notifier.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class DeleteForwardingPage extends StatelessWidget {
  AddEANotifier inputNotifier;
  String userId = "sfsf";

  DeleteForwardingPage(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    late Future<Object> response = RestService().deleteEA(
        deleteEA: DeleteEA(eAId: inputNotifier.eAId!, userId: userId));
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Row(
          children: [
            KeepAliveFutureBuilder(
                future: response,
                builder: (context, snapshot) {
                  return snapshotHandler(snapshot, goToProfilePage, [context]);
                })
          ],
        )));
  }
}

Widget goToProfilePage(
    BuildContext context,
    Map<String, dynamic> decodedJson) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    NavigationBarNotifier navigationBarNotifier =
        Provider.of<NavigationBarNotifier>(context, listen: false);
    navigationBarNotifier.pageController =
        PageController(initialPage: NavigatorConstants.FavouritePageIndex);
    navigationBarNotifier.index = NavigatorConstants.FavouritePageIndex;

    NavigatorConstants.sendToScreen(MainPage());
  });
  return SizedBox();
}
