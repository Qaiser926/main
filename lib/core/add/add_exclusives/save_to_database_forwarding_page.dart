import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/modules/models/detailed_event/detailed_event.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

class SaveForwardingPage extends StatelessWidget {
  DetailedEventOrActivity detailedEventOrActivity;

  SaveForwardingPage(this.detailedEventOrActivity);

  @override
  Widget build(BuildContext context) {
    late Future<Object> response =
        RestService().crateEA(detailedEventOrActivity: detailedEventOrActivity);
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
            KeepAliveFutureBuilder(
                future: response,
                builder: (context, snapshot) {
                  return snapshotHandler(snapshot, getToDetailPage, [context]);
                }),
            getVerSpace(10.h),
            Text(AppLocalizations.of(context)!.deleteEAWaitingMessage),
          ],
        )));
  }
}

Widget getToDetailPage(
    // TODO
    BuildContext context,
    Map<String, dynamic> decodedJson) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<GlobalNavigationNotifier>(context, listen: false)
        .navigationBarIndex = NavigatorConstants.ProfilePageIndex;
    NavigatorConstants.sendToScreen(MainPage());
  });
  return SizedBox();
}
