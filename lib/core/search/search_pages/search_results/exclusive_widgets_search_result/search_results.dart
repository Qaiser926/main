import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../../modules/models/get_search_results_ids/get_search_result_ids.dart';
import '../../../../../utils/ui/future_service.dart';
import 'search_result_scroll_view.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SearchResults> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<SearchNotifier>(context, listen: false)
            .getSearchQueryResult(),
        builder: (context, snapshot) {
          //  if(snapshot.connectionState==ConnectionState.waiting){
          //             return Center(child:defaultStillLoadingWidget);
          //           }
          //           if(snapshot.hasData){
        try {
            return snapshotHandler(
              context, snapshot, getFutureFulfilledContent, []);
        } catch (e) {
       return   Container(
        child: Center(child: Text("No Data Exit")),
       );
        }
              
              // }else{
              //   return Center(
              //     child: Text("No Data Exit"),
              //   );
              // }
        });
  }

  Widget getFutureFulfilledContent(Map<String, dynamic> json) {
    SearchResultIds searchResultIds = SearchResultIds.fromJson(json);
    return SearchScrollView(
      searchResultIds: searchResultIds,
    );
  }
}
