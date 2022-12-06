import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:othia/utils/ui/future_service.dart';
import '../../utils/services/rest-api/rest_api_service.dart';
import '../modules/models/eA_summary/eA_summary.dart';
import '../modules/models/id_list/id_list.dart';
import 'discovery_card.dart';

class HorizontalEADiscovery extends StatelessWidget {
  final String functionParameter;

  const HorizontalEADiscovery({super.key, required this.functionParameter});

  // TODO make dynamic such that every function can be applied

  @override
  Widget build(BuildContext context) {
    late Future<Object> eAIds = RestService().getEAIdsForCategory(
        categoryId: functionParameter);
    return FutureBuilder(
        future: eAIds,
        builder: (context, snapshot)
    {
      try {
        Map<String, dynamic> jsonData = snapshotHandler(snapshot);
        IdList eAIds = IdList.fromJson(jsonData);
        return SizedBox(
            height: 289.h,
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: eAIds.eaIdList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // TODO preload also future data that is not yet visible for the user
                  late Future<Object> response = RestService()
                      .fetchEventOrActivityDetails(
                      eventOrActivityId: eAIds.eaIdList[index]);

                  return FutureBuilder(
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
        return Text("fk");
      }}
    );
  }
  }
