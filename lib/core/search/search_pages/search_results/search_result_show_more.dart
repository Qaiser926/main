import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/filter_frameworks/search_filter.dart';
import 'package:othia/widgets/filter_related/notifiers/search_notifier.dart';
import 'package:othia/widgets/vertical_discovery/vertical_discovery_framework.dart';
import 'package:provider/provider.dart';

class SearchResultShowMore extends StatefulWidget {
  @override
  State<SearchResultShowMore> createState() => _SearchResultShowMore();
}

class _SearchResultShowMore extends State<SearchResultShowMore> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            primary: true,
            body: Consumer<SearchNotifier>(builder: (context, model, child) {
              return Scaffold(
                  primary: true,
                  appBar: DropDownAppBar(
                      filter: Consumer<SearchNotifier>(
                          builder: (context, model, child) {
                            return SearchFilter(
                          context: context,
                                dynamicProvider: Provider.of<SearchNotifier>(
                                    context,
                                    listen: false)).buildDropdownBar();
                      }),
                      context: context,
                      appBarTitle: AppLocalizations.of(context)!.results),
                  body: CustomScrollView(slivers: [
                    buildVerticalDiscovery(
                      actionButtonType: ActionButtonType.addLikeButton,
                      Ids: model.showMoreIds,
                    )
                  ]));
            })));
  }
}
