import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/core/add/add_exclusives/action_box.dart';
import 'package:othia/core/add/add_exclusives/address_form.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/core/add/add_exclusives/opening_times_selector.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';
import 'time_selector.dart';

class BasicInfoPage extends StatefulWidget {
  AddEANotifier inputNotifier;

  BasicInfoPage(this.inputNotifier);

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState(inputNotifier);
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  TextEditingController _textController = TextEditingController();

  AddEANotifier inputNotifier;
  String? mainCategoryId;
  String? categoryId;
  String? title;

  _BasicInfoPageState(this.inputNotifier);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        // TODO improve design
        content: inputNotifier.isModifyMode
            ? Text(AppLocalizations.of(context)!.snackBarMessageAdding)
            : Text(AppLocalizations.of(context)!.snackBarMessageModifying),
        duration: Duration(seconds: 7, milliseconds: 500),
      );
      if (!Provider.of<AddEANotifier>(context, listen: false).snackBarShown) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Provider.of<AddEANotifier>(context, listen: false).snackBarShown = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.inputNotifier.basicInformationFormKey,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Consumer<AddEANotifier>(
              builder: (context, inputNotifierConsumer, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (inputNotifier.isModifyMode) ActionBox(inputNotifier),
                  getHeadline(
                      showDivider: inputNotifier.isModifyMode,
                      context: context,
                      caption: Text(AppLocalizations.of(context)!.title,
                          style: Theme.of(context).textTheme.headlineLarge)),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                    child: buildTitleSection(),
                  ),
                  getHeadline(
                      context: context,
                      caption: Text(
                          AppLocalizations.of(context)!.categorization,
                          style: Theme.of(context).textTheme.headlineLarge)),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                      child: buildDropDown(
                          defaultValue: widget.inputNotifier.mainCategoryId,
                          hintText:
                              AppLocalizations.of(context)!.categorizationHint,
                          onValidErrorText: AppLocalizations.of(context)!
                              .categorizationErrorMessage,
                          dropDownList: Categories.categoryIds,
                          notifierFunction: (mainCategoryId) {
                            widget.inputNotifier.mainCategoryId =
                                mainCategoryId;
                            widget.inputNotifier.categoryId = null;
                            //
                            setState(() => {
                                  this.mainCategoryId = mainCategoryId,
                                  this.categoryId = null
                                });
                          })),
                  if (widget.inputNotifier.mainCategoryId != null)
                    new Padding(
                        padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                        child: buildDropDown(
                            defaultValue: widget.inputNotifier.categoryId,
                            hintText: AppLocalizations.of(context)!
                                .subcategorizationHint,
                            onValidErrorText: AppLocalizations.of(context)!
                                .subcategorizationErrorMessage,
                            dropDownList: categoryIdToSubcategoryIds[
                                widget.inputNotifier.mainCategoryId]!,
                            notifierFunction: (categoryId) {
                              setState(() => {this.categoryId = categoryId});
                              widget.inputNotifier.categoryId = categoryId;
                            })),
                  getHeadline(
                      context: context,
                      caption: Text(AppLocalizations.of(context)!.location,
                          style: Theme.of(context).textTheme.headlineLarge)),
                  getSwitch(
                      context: context,
                      onPressed: inputNotifierConsumer.changeLocationType,
                      isSelected: inputNotifierConsumer.locationType,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text(
                            AppLocalizations.of(context)!.address,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text(
                            AppLocalizations.of(context)!.online,
                          ),
                        ),
                      ]),
                  if (inputNotifierConsumer.locationType[0])
                    Form(
                        key: widget.inputNotifier.addressFormKey,
                        child: AddressForm(
                            context: context,
                            inputNotifier: inputNotifierConsumer)),
                  getVerSpace(10.h),
                  getHeadlineWithInfoDialog(
                    context: context,
                    infoText: AppLocalizations.of(context)!.timeInfo,
                    caption: AppLocalizations.of(context)!.time,
                  ),
                  getSwitch(
                      context: context,
                      onPressed: inputNotifierConsumer.changeTimeType,
                      isSelected: inputNotifierConsumer.times,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text(
                            AppLocalizations.of(context)!.startEndTime,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.h),
                          child: Text(
                            AppLocalizations.of(context)!.openingHours,
                          ),
                        ),
                      ]),
                  Form(
                      key: widget.inputNotifier.timeFormKey,
                      child: Provider.of<AddEANotifier>(context, listen: true)
                              .times[0]
                          ? TimeSelector(
                              context: context,
                              inputNotifier: widget.inputNotifier)
                          : OpeningTimesSelector(
                              context: context,
                              inputNotifier: widget.inputNotifier)),
                ]);
          }),
        ),
      ),
    );
    // });
  }

  Column buildTitleSection() {
    return Column(children: <Widget>[
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.titleErrorMessage;
          }
          return null;
        },
        initialValue: Provider.of<AddEANotifier>(context, listen: false)
            .detailedEventOrActivity
            .title,
        controller: Provider.of<AddEANotifier>(context, listen: false)
                    .detailedEventOrActivity
                    .title ==
                null
            ? _textController
            : null,
        onChanged: (title) {
          setState(() => {this.title = title});

          widget.inputNotifier.detailedEventOrActivity.title = title;
        },
        maxLength: DataConstants.MaxTitleLength,
        maxLines: null,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(5.h),
          border: OutlineInputBorder(),
          hintText: AppLocalizations.of(context)!.titleHint,
        ),
      ),
    ]);
  }

  DropdownButtonFormField buildDropDown({
    required String hintText,
    required String onValidErrorText,
    required List<String> dropDownList,
    required Function(dynamic val) notifierFunction,
    required String? defaultValue,
  }) {
    return DropdownButtonFormField(
      hint: Text(hintText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return onValidErrorText;
        }
        return null;
      },
      value: defaultValue,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.h),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          border: OutlineInputBorder()),
      onChanged: notifierFunction,
      items: dropDownList.map<DropdownMenuItem<String>>((String categoryId) {
        return DropdownMenuItem<String>(
          value: categoryId,
          child: Text(
            CategoryIdToI18nMapper.getCategorySubcategoryName(
                context, categoryId),
          ),
        );
      }).toList(),
    );
  }



}
