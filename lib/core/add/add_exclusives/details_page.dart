import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/core/add/add_exclusives/image_picker.dart';
import 'package:othia/core/add/add_exclusives/price_picker.dart';
import 'package:othia/core/add/add_exclusives/search_enhancement_slider.dart';
import 'package:othia/modules/models/shared_data_models.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import 'input_notifier.dart';

class DetailsPage extends StatelessWidget {
  AddEANotifier inputNotifier;

  DetailsPage(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            getHeadline(
                showDivider: false,
                context: context,
                caption: Text(
                    "${AppLocalizations.of(context)!.image} (Optional)",
                    style: Theme.of(context).textTheme.headlineLarge)),
            EAImagePicker(inputNotifier),
            getHeadline(
                context: context,
                caption: Text(
                    "${AppLocalizations.of(context)!.descriptionAdd} (Optional)",
                    style: Theme.of(context).textTheme.headlineLarge)),
            buildDescriptionBox(context),
            getHeadline(
                context: context,
                caption: Text(
                    "${AppLocalizations.of(context)!.price} (Optional)",
                    style: Theme.of(context).textTheme.headlineLarge)),
            PricePicker(inputNotifier),
            getVerSpace(10.h),
            getHeadlineWithInfoDialog(
                context: context,
                infoText: AppLocalizations.of(context)!.ticketInfo,
                caption:
                    "${AppLocalizations.of(context)!.ticketingUrl} (Optional)"),
            buildTicketingBox(
              context,
            ),
            getHeadlineWithInfoDialog(
                context: context,
                infoText: AppLocalizations.of(context)!.websiteInfo,
                caption:
                    "${AppLocalizations.of(context)!.websiteUrl} (Optional)"),
            buildWebsiteBox(
              context,
            ),
            if (inputNotifier.times[0]) buildTicketStatusBox(context),
            getHeadlineWithInfoDialog(
                context: context,
                infoText: AppLocalizations.of(context)!.searchEnhancementInfo,
                caption:
                    "${AppLocalizations.of(context)!.searchEnhancement} (Optional)"),
            SearchEnhancementSlider(inputNotifier),
          ])),
    );
    // });
  }

  Consumer buildTextBox(
      {required BuildContext context,
      required TextEditingController? textEditingController,
      int? maxLength,
      required int minLines,
      required Function(String) onChanged,
      required String hintText}) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return TextFormField(
        controller: textEditingController,
        onChanged: onChanged,
        maxLength: maxLength,
        minLines: minLines,
        maxLines: null,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(5.h),
            border: OutlineInputBorder(),
            hintText: hintText),
      );
    });
  }

  Consumer buildDescriptionBox(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return buildTextBox(
        context: context,
        onChanged: (description) {
          inputNotifierConsumer.detailedEA.description = description;
        },
        hintText: AppLocalizations.of(context)!.descriptionHint,
        minLines: 3,
        maxLength: DataConstants.MaxDescriptionLength,
        textEditingController:
            inputNotifierConsumer.detailedEA.description == null
                ? null
                : TextEditingController(
                    text: inputNotifierConsumer.detailedEA.description,
                  ),
      );
    });
  }

  Consumer buildTicketingBox(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return buildTextBox(
        context: context,
        onChanged: (description) {
          inputNotifierConsumer.detailedEA.ticketUrl = description;
        },
        hintText: AppLocalizations.of(context)!.ticketingHint,
        minLines: 3,
        textEditingController:
            inputNotifierConsumer.detailedEA.ticketUrl == null
                ? null
                : TextEditingController(
                    text: inputNotifierConsumer.detailedEA.ticketUrl,
                  ),
      );
    });
  }

  Consumer buildWebsiteBox(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return buildTextBox(
        context: context,
        onChanged: (description) {
          inputNotifierConsumer.detailedEA.websiteUrl = description;
        },
        hintText: AppLocalizations.of(context)!.websiteHint,
        minLines: 3,
        textEditingController:
            inputNotifierConsumer.detailedEA.websiteUrl == null
                ? null
                : TextEditingController(
                    text: inputNotifierConsumer.detailedEA.websiteUrl,
                  ),
      );
    });
  }

  Consumer buildTicketStatusBox(BuildContext context) {
    Map stati = {
      0: {
        "function": () {
          dismissKeyboard();
          inputNotifier.changeStatus = Status.LIVE;
        },
        "caption": AppLocalizations.of(context)!.statusLive,
      },
      1: {
        "function": () {
          dismissKeyboard();
          inputNotifier.changeStatus = Status.SOLDOUT;
        },
        "caption": AppLocalizations.of(context)!.statusSoldOut,
      },
      2: {
        "function": () {
          dismissKeyboard();
          inputNotifier.changeStatus = Status.CANCELED;
        },
        "caption": AppLocalizations.of(context)!.statusCancelled,
      },
    };
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return Column(
        children: [
          getHeadline(
              context: context,
              caption: Text(
                  "${AppLocalizations.of(context)!.eventStatus} (Optional)",
                  style: Theme.of(context).textTheme.headlineLarge)),
          Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getStatusButton(
                      context: context,
                      activated: inputNotifierConsumer.status == Status.LIVE,
                      caption: stati[0]["caption"],
                      index: 0,
                      onPressed: stati[0]["function"]),
                  getStatusButton(
                      context: context,
                      activated: inputNotifierConsumer.status == Status.SOLDOUT,
                      caption: stati[1]["caption"],
                      index: 1,
                      onPressed: stati[1]["function"]),
                  getStatusButton(
                      context: context,
                      activated:
                          inputNotifierConsumer.status == Status.CANCELED,
                      caption: stati[2]["caption"],
                      index: 2,
                      onPressed: stati[2]["function"]),
                ],
              ))
        ],
      );
    });
  }

  Padding getStatusButton(
      {required int index,
      required Function onPressed,
      required String caption,
      required BuildContext context,
      required bool activated}) {
    return Padding(
        padding: index == 0 ? EdgeInsets.all(0) : EdgeInsets.only(left: 10.h),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(activated
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.background),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.h),
                // TODO clear (extern) apply different border color, same as the text form border
                side: BorderSide(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)),
              ))),
          onPressed: () => onPressed(),
          child: Text(caption),
        ));
  }
}
