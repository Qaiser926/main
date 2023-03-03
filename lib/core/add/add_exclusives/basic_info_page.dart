import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/core/add/add_exclusives/action_box.dart';
import 'package:othia/core/add/add_exclusives/address_form.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/core/add/add_exclusives/opening_hours_selector.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/form_fields.dart';
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
      final snackBar = 
      SnackBar(
        backgroundColor: Colors.grey.shade300,
        // TODO clear (extern) improve design of snackbar
        content: inputNotifier.isModifyMode
            ? Text(AppLocalizations.of(context)!.snackBarMessageModifying,textAlign: TextAlign.justify,)
            : Text(AppLocalizations.of(context)!.snackBarMessageAdding,style: TextStyle(fontSize: 14.sp,),textAlign: TextAlign.justify,),
        duration: Duration(seconds: 7, milliseconds: 500),
      );
      if (!Provider.of<AddEANotifier>(context, listen: false).snackBarShown) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Get.snackbar(snackBar.toString(), "",snackPosition: SnackPosition.BOTTOM);
        Provider.of<AddEANotifier>(context, listen: false).snackBarShown = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    //  Scaffold(
    //   backgroundColor: Colors.red,
    // );
    Form(
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
                  // As in detailed event or activity only the subcategory is stored, for the main category the notifier holds a variable
                  Padding(
                      padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                      child: getDropDownFormField(
                          defaultValue: widget.inputNotifier.mainCategoryId,
                          hintText:
                              AppLocalizations.of(context)!.categorizationHint,
                          onInvalidErrorText: AppLocalizations.of(context)!
                              .categorizationErrorMessage,
                          dropDownList: Categories.categoryIds,
                          onChangedFunction: (mainCategoryId) {
                            widget.inputNotifier.mainCategoryId =
                                mainCategoryId;
                            widget.inputNotifier.detailedEA.categoryId = null;
                            //
                            setState(() => {
                                  this.mainCategoryId = mainCategoryId,
                                  this.categoryId = null
                                });
                          },
                          context: context,
                          valueTransformer: CategoryIdToI18nMapper
                              .getCategorySubcategoryName)),
                  if (widget.inputNotifier.mainCategoryId != null)
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                        child: getDropDownFormField(
                            defaultValue:
                                widget.inputNotifier.detailedEA.categoryId,
                            hintText: AppLocalizations.of(context)!
                                .subcategorizationHint,
                            onInvalidErrorText: AppLocalizations.of(context)!
                                .subcategorizationErrorMessage,
                            dropDownList: categoryIdToSubcategoryIds[
                                widget.inputNotifier.mainCategoryId]!,
                            onChangedFunction: (categoryId) {
                              setState(() => {this.categoryId = categoryId});
                              widget.inputNotifier.detailedEA.categoryId =
                                  categoryId;
                            },
                            context: context,
                            valueTransformer: CategoryIdToI18nMapper
                                .getCategorySubcategoryName)),
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
                          : OpeningHoursSelector(
                              context: context,
                              inputNotifier: widget.inputNotifier)),
                ]);
          }),
        ),
      ),
    );
   
  }

  Column buildTitleSection() {
    return Column(children: <Widget>[
      CustomTextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.titleErrorMessage;
          }
          return null;
        },
        initialValue:
            Provider.of<AddEANotifier>(context, listen: false).detailedEA.title,
        controller: Provider.of<AddEANotifier>(context, listen: false)
                    .detailedEA
                    .title ==
                null
            ? _textController
            : null,
        onChanged: (title) {
          setState(() => {this.title = title});

          widget.inputNotifier.detailedEA.title = title;
        },
        maxLength: DataConstants.MaxTitleLength,
      ),
    ]);
  }
}
