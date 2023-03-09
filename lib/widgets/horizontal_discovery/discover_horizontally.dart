import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';
import 'package:othia/widgets/horizontal_discovery/discovery_card.dart';
import 'package:othia/widgets/info_snackbar.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../utils/services/rest-api/rest_api_service.dart';
import '../../modules/models/eA_summary/eA_summary.dart';
import '../../utils/services/events/example_event.dart';
import '../../utils/ui/ui_utils.dart';
import '../keep_alive_future_builder.dart';

class BaseDiscoveryClass extends StatelessWidget {
  final List<String?> Ids;
  final String caption;

  bool showDivider;
  bool showMore;
  bool isInfoButtonActivated;

  BaseDiscoveryClass(
      {super.key,
      required this.Ids,
      required this.caption,
      this.showDivider = true,
      this.showMore = true,
      this.isInfoButtonActivated = false});

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                Divider(thickness: 3.h),
                getVerSpace(15),
              ],
            ),
          ),
        if (!showDivider) getVerSpace(5.h),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    isInfoButtonActivated
                        ? launchInfoSnackBarButton(context)
                        : () => {};
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TODO clear (extern) this text causes an overflow -> make sure the text is shown in multiple lines, e.g. for other Culture and performing art
                      Text(
                        caption,
                        softWrap: true,
                        style: Theme.of(context).textTheme.headlineLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      getHorSpace(5.h),
                      isInfoButtonActivated
                          ? Icon(
                              Icons.info_outline,
                              size: 15.h,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                if (showMore & Ids.isNotEmpty)
                  TextButton(
                      onPressed: () {
                        Provider.of<SearchNotifier>(context, listen: false)
                            .goToShowMorePage(
                          showMoreCaption: caption,
                          showMoreIds: Ids,
                          showMoreCategoryTitle: caption,
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.showMore))
              ],
            )),
        getVerSpace(15),
        if (!Ids.isEmpty) HorizontalEADiscovery(Ids: Ids),
        if (Ids.isEmpty) getNoResultsMessage(context),
      ],
    );
  
  
  
  }
}

Widget getNoResultsMessage(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.noResultsFound,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            getVerSpace(55),
          ],
        )
      ],
    ),
  );
}

class HorizontalEADiscovery extends StatelessWidget {
  final List<String?> Ids;

  const HorizontalEADiscovery({super.key, required this.Ids});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 155.h,
        child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: Ids.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              late Future<Object> response =
                  RestService().getEASummary(id: Ids[index]);
              return KeepAliveFutureBuilder(
                  future: response,
                  builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: defaultStillLoadingWidget,);
                    }
                    if(snapshot.hasData){
                    return snapshotHandler(context, snapshot,
                        getFutureFulfilledContent, [index, context]);
                         }else{
                    return Center(child: Text("No Data Exit"),);
                  }
                  });
            }));
  }

  Widget getFutureFulfilledContent(
    int index,
    BuildContext context,
    Map<String, dynamic> decodedJson,
  ) {
    SummaryEventOrActivity eASummary =
        SummaryEventOrActivity.fromJson(decodedJson);
    return VisibilityDetector(
        key: Key(eASummary.id),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction >= 0.85) {
            recordCustomEvent(
                eventName: "summaryShown",
                eventParams: {"eAId": eASummary.id},
                userId: Provider.of<GlobalNavigationNotifier>(context,
                        listen: false)
                    .userId);
          }
        },
        child: EASummaryCard(
          eASummary: eASummary,
          index: index,
        ));
  }
}
