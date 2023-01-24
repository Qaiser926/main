import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/utils/services/exceptions.dart';

import '../../../constants/categories.dart';
import '../../../modules/models/id_list/id_list.dart';
import '../../../widgets/keep_alive_future_builder.dart';
import '../../../utils/services/rest-api/rest_api_service.dart';
import '../../../utils/ui/future_service.dart';
import '../../../widgets/horizontal_discovery/discover_horizontally.dart';

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
  if (listFunction.index == 0) {
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
        eAIds: eAIds, heading: AppLocalizations.of(context)!.exploreLocation);
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
    {required Future eAIds, required String heading}) {
  return KeepAliveFutureBuilder(
      future: eAIds,
      builder: (context, snapshot) {
        return snapshotHandler(snapshot, getContent, [heading]);
      });
}

Widget getContent(String heading, Map<String, dynamic> jsonData) {
  try {
    IdList eAIds = IdList.fromJson(jsonData);
    if (eAIds.eaIdList.length == 0) {
      throw EmptyList;
    }
    return BaseDiscoveryClass(
      caption: heading,
      Ids: eAIds.eaIdList,
      showMore: false,
    );
  } on StillLoading {
    return SizedBox();
  } on EmptyList {
    return SizedBox();
  }
}
