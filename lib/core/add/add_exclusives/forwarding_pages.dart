import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/core/detailed/detailedEA.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/modules/models/detailed_event/detailed_event.dart';
import 'package:othia/utils/helpers/builders.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

Widget buildForwardingBody(
    {required KeepAliveFutureBuilder keepAliveFutureBuilder,
    required String waitingMessage,
    required BuildContext context}) {
  return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TODO show more elaborate error message, e.g., notify user that deletion of event/activity was not successful, most likely this required modification of the snapshot handler, where different pages are shown depending on the error case
          // TODO after error navigation
          keepAliveFutureBuilder,
          getVerSpace(10.h),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Text(waitingMessage, textAlign: TextAlign.center),
          ),
        ],
      )));
}

class SaveForwardingPage extends StatelessWidget {
  DetailedEventOrActivity detailedEA;

  SaveForwardingPage(this.detailedEA);

  @override
  Widget build(BuildContext context) {
    late Future<Object> response =
        RestService().crateEA(detailedEventOrActivity: detailedEA);
    openShare('${eAShareLinkBuilder(detailedEA.id!)}');
    return buildForwardingBody(
        keepAliveFutureBuilder: KeepAliveFutureBuilder(
            future: response,
            builder: (context, snapshot) {
              return snapshotHandler(
                  snapshot, getToDetailPage, [context, detailedEA.id!]);
            }),
        waitingMessage: AppLocalizations.of(context)!.saveEAWaitingMessage,
        context: context);
  }
}

Widget getToDetailPage(
    BuildContext context, String eAId, Map<String, dynamic> decodedJson) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.to(() => detailedEA(), arguments: {
      DataConstants.EventActivityId: eAId,
      DataConstants.notGoBack: true
    });
  });
  return SizedBox();
}

class DeleteForwardingPage extends StatelessWidget {
  AddEANotifier inputNotifier;
  String userId;

  DeleteForwardingPage(this.inputNotifier, this.userId);

  @override
  Widget build(BuildContext context) {
    late Future<Object> response = RestService().deleteEA(
        deleteEA: DeleteEA(eAId: inputNotifier.detailedEA.id!, userId: userId));
    return buildForwardingBody(
        context: context,
        keepAliveFutureBuilder: KeepAliveFutureBuilder(
            future: response,
            builder: (context, snapshot) {
              return snapshotHandler(snapshot, goToProfilePage, [context]);
            }),
        waitingMessage: AppLocalizations.of(context)!.deleteEAWaitingMessage);
  }
}

Widget goToProfilePage(BuildContext context, Map<String, dynamic> decodedJson) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<GlobalNavigationNotifier>(context, listen: false)
        .navigationBarIndex = NavigatorConstants.ProfilePageIndex;
    NavigatorConstants.sendToScreen(MainPage());
  });
  return SizedBox();
}
