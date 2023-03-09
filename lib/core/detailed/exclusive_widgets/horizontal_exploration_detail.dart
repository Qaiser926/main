import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/services/exceptions.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../../constants/categories.dart';
import '../../../modules/models/id_list/id_list.dart';
import '../../../utils/services/rest-api/rest_api_service.dart';
import '../../../utils/ui/future_service.dart';
import '../../../widgets/horizontal_discovery/discover_horizontally.dart';
import '../../../widgets/keep_alive_future_builder.dart';

enum ListFunction {
  getEAIdsForCategory,
  getEAIdsForEventSeries,
  getEAIdsForLocation,
}

Future<Object> getFutureList(
    {required ListFunction listFunction, required String functionParameter}) {
  if (listFunction.index == 0) {
    return RestService().getEAIdsForCategory(categoryId: functionParameter);
  }
  if (listFunction.index == 1) {
    return RestService()
        .getEAIdsForEventSeries(eventSeriesId: functionParameter);
  } else {
    return RestService().getEAIdsForLocation(locationId: functionParameter);
  }
}

class ExploreLocation extends StatelessWidget {
  final String locationId;

  const ExploreLocation({super.key, required this.locationId});

  @override
  Widget build(BuildContext context) {
    late Future<Object> eAIds = getFutureList(
        functionParameter: locationId,
        listFunction: ListFunction.getEAIdsForLocation);
    return getHorizontalDiscovery(
        eAIds: eAIds,
        heading: AppLocalizations.of(context)!.exploreLocation,
        isMoreLocation: true);
  }
}

class ExploreCategory extends StatelessWidget {
  final String categoryId;
  late String categoryName;

  ExploreCategory({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    categoryName =
        CategoryIdToI18nMapper.getCategorySubcategoryName(context, categoryId);
    late Future<Object> eAIds = getFutureList(
        functionParameter: categoryId,
        listFunction: ListFunction.getEAIdsForCategory);
    return getHorizontalDiscovery(
        eAIds: eAIds,
        heading: AppLocalizations.of(context)!.exploreCategory(categoryName));
  }
}

class ExploreEventSeries extends StatelessWidget {
  final String eventSeriesId;

  const ExploreEventSeries({super.key, required this.eventSeriesId});

  @override
  Widget build(BuildContext context) {
    late Future<Object> eAIds = getFutureList(
        functionParameter: eventSeriesId,
        listFunction: ListFunction.getEAIdsForEventSeries);
    return getHorizontalDiscovery(
        eAIds: eAIds,
        heading: AppLocalizations.of(context)!.exploreEventSeries);
  }
}

Widget getHorizontalDiscovery(
    {required Future eAIds, required String heading, isMoreLocation = false}) {
  return KeepAliveFutureBuilder(
      future: eAIds,
      builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child:defaultStillLoadingWidget);
                    }
        if(snapshot.hasData){
        return snapshotHandler(
            context, snapshot, getContent, [heading, isMoreLocation]);
             }else{
                    return Center(child: Text("No Data Exit"),);
                  }
      });
}

Widget getContent(
    String heading, bool isMoreLocation, Map<String, dynamic> jsonData) {
  try {
    IdList eAIds = IdList.fromJson(jsonData);
    if (((eAIds.eaIdList.length == 1) & isMoreLocation) |
        (eAIds.eaIdList.length == 0)) {
      throw EmptyList();
    }
    return BaseDiscoveryClass(
      caption: heading,
      Ids: eAIds.eaIdList,
      showMore: false,
    );
  } on StillLoading catch (e) {
    return SizedBox();
  } on EmptyList catch (e) {
    return SizedBox();
  }
}
