import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/category_filter/category_filter.dart';
import 'package:othia/widgets/filter_related/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/search_filter.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';
import 'package:provider/provider.dart';


class InitialSearchPage extends StatelessWidget {
  const InitialSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            Provider.of<SearchNotifier>(context, listen: false)).buildDropdownBar();
              }),
              context: context,
              appBarTitle: AppLocalizations.of(context)!.discover,
              automaticallyImplyLeading: false),
          body: CategoryFilter(
            context: context,
            isModalBottomSheetMode: false,
            dynamicProvider:
                Provider.of<SearchNotifier>(context, listen: false),
          ),
        );
      }),
    );
  }
}
