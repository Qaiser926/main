import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:othia/constants/no_internet_controller.dart';
import 'package:othia/widgets/filter_related/category_filter/category_filter.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/search_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';
import 'package:provider/provider.dart';

class InitialSearchPage extends StatelessWidget {
   InitialSearchPage({Key? key}) : super(key: key);
  final StudentLocationController studentFindTutorsController=Get.put(StudentLocationController());
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'searchInitScreen',
    );
    return SafeArea(
      child: Consumer<SearchNotifier>(builder: (context, model, child) {
        return Scaffold(
          primary: true,
          appBar: DropDownAppBar(
              filter:
                  Consumer<SearchNotifier>(builder: (context, model, child) {
                return SearchFilter(
                        context: context,
                        dynamicProvider:
                            Provider.of<SearchNotifier>(context, listen: false))
                    .buildDropdownBar();
              }),
              context: context,
              appBarTitle: AppLocalizations.of(context)!.discover,
              automaticallyImplyLeading: false,
              onBackPressed: () => {}),
          body: Obx(()=>Container(
        child: studentFindTutorsController.connectionStatus.value==1?  CategoryFilter(
            isModalBottomSheetMode: false,
            dynamicProvider:
            Provider.of<SearchNotifier>(context, listen: false),
          )
      :studentFindTutorsController.connectionStatus.value==2?  CategoryFilter(
            isModalBottomSheetMode: false,
            dynamicProvider:
            Provider.of<SearchNotifier>(context, listen: false),
          ):Container(
        width: Get.size.width,
        height: Get.size.height,
        child: Column(
          children: [
            Lottie.asset('assets/lottiesfile/no_internet.json',fit: BoxFit.cover),
         
          ],
        ),
      )))


        
        );
      }),
    );
  }
}
