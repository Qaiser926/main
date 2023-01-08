import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/utils/ui/ui_utils.dart';
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
    return WillPopScope(onWillPop: () async {
      return false;
    }, child: Consumer<NavigationBarNotifier>(
        builder: (context, navigationBarNotifier, child) {
      return Scaffold(
          body: Row(
        children: [
          getVerSpace(150.h),
          Text("loading"),
          KeepAliveFutureBuilder(
              future: response,
              builder: (context, snapshot) {
                return snapshotHandler(snapshot, goToProfilePage,
                    [context, navigationBarNotifier]);
              })
        ],
      ));
    }));

    // TODO loading screen
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: defaultStillLoadingWidget);
  }
}

Widget goToProfilePage(
    BuildContext context,
    NavigationBarNotifier navigationBarNotifier,
    Map<String, dynamic> decodedJson) {
  // unteres beeinfluttst nur die Bar
  WidgetsBinding.instance.addPostFrameCallback((_) {
    navigationBarNotifier.setIndex(index: 2, context: context);
  });
  return SizedBox();
}
