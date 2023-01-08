import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/detailed/detailed_event.dart';
import 'package:othia/modules/models/detailed_event/detailed_event.dart';
import 'package:othia/utils/helpers/builders.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:share_plus/share_plus.dart';

class SaveForwardingPage extends StatelessWidget {
  DetailedEventOrActivity detailedEA;
  SaveForwardingPage(this.detailedEA);

  @override
  Widget build(BuildContext context) {
    late Future<Object> response =
        RestService().crateEA(detailedEventOrActivity: detailedEA);
    Share.share('${eAShareLinkBuilder(detailedEA.id!)}');
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
                  return snapshotHandler(
                      snapshot, getToDetailPage, [context, detailedEA.id!]);
                }),
            getVerSpace(10.h),
            Padding(
              padding: EdgeInsets.all(10.h),
              child: Text(AppLocalizations.of(context)!.saveEAWaitingMessage),
            ),
          ],
        )));
  }
}

Widget getToDetailPage(
    BuildContext context, String eAId, Map<String, dynamic> decodedJson) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.to(detailedEA(), arguments: {DataConstants.EventActivityId: eAId});
  });
  return SizedBox();
}
