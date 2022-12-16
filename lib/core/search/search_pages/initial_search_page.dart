import 'package:flutter/material.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/widgets/filter_related/dropdown_appbar.dart';
import 'package:othia/widgets/filter_related/search_notifier.dart';
import 'package:provider/provider.dart';

import '../../../widgets/category_filter/category_filter.dart';

class InitialSearchPage extends StatelessWidget {
  const InitialSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> defaultSelectedCategoryIds =
        categoryIdToSubcategoryIds.keys.toList();
    return SafeArea(
        child: Consumer<SearchNotifier>(builder: (context, model, child) {
      return Scaffold(
          primary: true,
          appBar: DropDownAppBar(context: context, appBarTitle: "Search"),
          // here the category pictures
          body: CategoryFilter(
            context: context,
            isModalBottomSheetMode: false,
          ));
    }));
  }
}
