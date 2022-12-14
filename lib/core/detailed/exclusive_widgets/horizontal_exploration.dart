import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/services/exceptions.dart';

import '../../../constants/categories.dart';
import '../../../utils/ui/ui_utils.dart';
import '../../../widgets/disccover_events_horizontally.dart';

class ExploreCategory extends StatelessWidget {
  final String categoryId;
  late String categoryName;

  ExploreCategory({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    categoryName = CategoryIdToI18nMapper.fckMethod(context, categoryId);
    return BaseDiscoveryClass(
      listFunction: ListFunction.getEAIdsForCategory,
      heading: AppLocalizations.of(context)!.exploreCategory(categoryName),
      id: categoryId,
    );
  }
}

class ExploreEventSeries extends StatelessWidget {
  final String eventSeriesId;

  const ExploreEventSeries({super.key, required this.eventSeriesId});
  @override
  Widget build(BuildContext context) {
    return BaseDiscoveryClass(
      listFunction: ListFunction.getEAIdsForEventSeries,
      heading: AppLocalizations.of(context)!.exploreEventSeries, id: eventSeriesId,);
  }
}

class ExploreLocation extends StatelessWidget {
  final String locationId;

  const ExploreLocation({super.key, required this.locationId});
  @override
  Widget build(BuildContext context) {
    return BaseDiscoveryClass(
      listFunction: ListFunction.getEAIdsForLocation,
      heading: AppLocalizations.of(context)!.exploreLocation, id: locationId,);
  }
}

class BaseDiscoveryClass extends StatelessWidget {
  final String id;
  final String heading;

  // states the type of discovery as Enum
  final ListFunction listFunction;

  const BaseDiscoveryClass(
      {super.key, required this.id, required this.heading, required this.listFunction});

  @override
  Widget build(BuildContext context) {
    try {
      return Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(thickness: 3.h),
                  getVerSpace(25),
                  Text(
                    heading,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline2,
                  ),
                  getVerSpace(25),
                ],
              )),
          HorizontalEADiscovery(
            listFunction: listFunction,
            functionParameter: id,
          ),
        ],
      );
    } on EmptyList {
      return SizedBox();
    }
  }
}