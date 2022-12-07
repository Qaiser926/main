import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/price_filter.dart';
import '../utils/ui/ui_utils.dart';
import 'categorization_filter.dart';


// TODO on selected items include counter and give Box colored border, make a class
SizedBox buildDropdownBar({required BuildContext context}) {
  final List<Widget> filters = getFilters(context: context);
  return SizedBox(
    height: 35.h,
    // disable color scheme
    child: ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: filters.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return filters[index];
      },
    ),
  );
}


Widget getFilter({required BuildContext context, required int index, required String heading, required Function onTapFunction}){
  return GestureDetector(
    onTap: () => onTapFunction(),
    child: Container(

      margin:
      EdgeInsets.only(right: 12.h, left: index == 0 ? 20.h : 0),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        color: Theme.of(context).colorScheme.tertiary,),
      alignment: Alignment.center,
      child:  Padding(padding: EdgeInsets.all(7.h), child: Row(
        children: [
          getCustomFont(
            text: heading,fontSize:  16.sp, maxLine:
          1,
            fontWeight: FontWeight.w600,
          ),
          Icon(Icons.arrow_drop_down, size: 20.h,),
        ],
      ),),
    ),
  );
}

List <Widget> getFilters({required BuildContext context}) {

  return [getFilter(context: context, index: 0, heading: AppLocalizations.of(context)!.category, onTapFunction: () {return showModal(context: context);}),
    getFilter(context: context, index: 1, heading: AppLocalizations.of(context)!.time, onTapFunction: () => print("time")),
    getFilter(context: context, index: 2, heading: AppLocalizations.of(context)!.price, onTapFunction: () => print("price")),
    getFilter(context: context, index: 3, heading: AppLocalizations.of(context)!.location, onTapFunction: () => print("location")),
    getFilter(context: context, index: 5, heading: AppLocalizations.of(context)!.sort, onTapFunction: () => print("sort")),
    getFilter(context: context, index: 4, heading: AppLocalizations.of(context)!.type, onTapFunction: () => print("type")),
    getFilter(context: context, index: 5, heading: AppLocalizations.of(context)!.additionalFilters, onTapFunction: () => print("addFilter")),
  ];
}

Future<dynamic> showModal ({required BuildContext context}){
  return showModalBottomSheet(
    elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (context) {
        return PriceFilter(endValue: 100, startValue: 0,);
      }
  );
}