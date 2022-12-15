import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/services/exceptions.dart';
import 'package:othia/utils/ui/future_service.dart';

import '../../utils/services/rest-api/rest_api_service.dart';
import '../modules/models/eA_summary/eA_summary.dart';
import '../modules/models/id_list/id_list.dart';
import '../utils/services/data_handling/keep_alive_future_builder.dart';
import 'discovery_card.dart';

enum ListFunction {
  getEAIdsForCategory,
  getEAIdsForEventSeries,
  getEAIdsForLocation,
}

Future<Object> getFutureList({required ListFunction listFunction, required String functionParameter}) {
  if (listFunction.index == 0) {
    return RestService().getEAIdsForCategory(
        categoryId: functionParameter);
  }
  if (listFunction.index == 0) {
    return RestService().getEAIdsForEventSeries(
        eventSeriesId: functionParameter);
  } else {
    return RestService().getEAIdsForLocation(
        locationId: functionParameter);
  }
}

class HorizontalEADiscovery extends StatelessWidget {
  final String functionParameter;
  final ListFunction listFunction;

  const HorizontalEADiscovery({super.key, required this.functionParameter, required this.listFunction});


  @override
  Widget build(BuildContext context) {
    late Future<Object> eAIds = getFutureList(functionParameter: functionParameter, listFunction: listFunction);
    return KeepAliveFutureBuilder(
        future: eAIds,
        builder: (context, snapshot)
    {
      try {
        Map<String, dynamic> jsonData = snapshotHandler(snapshot);
        IdList eAIds = IdList.fromJson(jsonData);
        if (eAIds.eaIdList.length == 0){
          throw EmptyList;
        }
        return SizedBox(
            height: 183.h,
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: eAIds.eaIdList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      late Future<Object> response = RestService()
                          .fetchEventOrActivityDetails(
                              eventOrActivityId: eAIds.eaIdList[index]);

                      return KeepAliveFutureBuilder(
                      future: response,
                      builder: (context, snapshot) {
                        Map<String, dynamic> decodedJson = snapshotHandler(snapshot);
                        SummaryEventOrActivity eASummary =
                        SummaryEventOrActivity.fromJson(decodedJson);
                        return EASummaryCard(
                          eASummary: eASummary, index: index,);
                      });
                }));
      } on StillLoading {
        return SizedBox();
      }}
    );
  }
  }
