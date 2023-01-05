import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add.dart';
import 'package:othia/core/add/add_exclusives/image_picker.dart';
import 'package:othia/core/add/add_exclusives/level_picker.dart';
import 'package:othia/core/add/add_exclusives/location_time_page.dart';
import 'package:othia/core/add/add_exclusives/price_picker.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

// TODO categorization, price, ticket link, description, optional: slider for activity lvl

class DetailsPage extends StatelessWidget {
  AddEANotifier inputNotifier;

  DetailsPage(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            getHeadline(
                context: context,
                caption: Text("Image",
                    style: Theme.of(context).textTheme.headlineLarge)),
            EAImagePicker(inputNotifier),
            getHeadline(
                context: context,
                caption: Text("Description (optional)",
                    style: Theme.of(context).textTheme.headlineLarge)),
            buildDescriptionBox(context),
            getHeadline(
                context: context,
                caption: Text("Price",
                    style: Theme.of(context).textTheme.headlineLarge)),
            PricePicker(inputNotifier),
            getVerSpace(10.h),
            getHeadlineWithInfoDialog(
                context: context,
                infoText:
                    "Here you have the opportunity to insert your ticket-url or website-url. User will be forwarded from the Othia app to the corresponding url.",
                caption: "Ticketing or Website (optional)"),
            buildTicketLink(context),
            getHeadlineWithInfoDialog(
                context: context,
                infoText:
                    "By stating the different levels, our algorithms can target user preferences better which in return helps promoting your event or activity",
                caption: "Search Enhancement"),
            LevelPicker(inputNotifier),
          ])),
    );
    // });
  }

  Consumer buildDescriptionBox(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return TextFormField(
        controller: inputNotifierConsumer.title == null
            ? null
            : TextEditingController(
                text: inputNotifierConsumer.title,
              ),

        onChanged: (description) {
          inputNotifierConsumer.title = description;
        },
        // TODO as constant
        maxLength: 400,
        maxLines: null,
        minLines: 3,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(5.h),
            border: OutlineInputBorder(),
            hintText: 'Enter the description '),
      );
    });
  }

  Consumer buildTicketLink(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return TextFormField(
        controller: inputNotifierConsumer.title == null
            ? null
            : TextEditingController(
                text: inputNotifierConsumer.title,
              ),
        onChanged: (description) {
          inputNotifierConsumer.title = description;
        },
        maxLines: null,
        minLines: 3,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(5.h),
            border: OutlineInputBorder(),
            hintText: 'Provide a ticket link'),
      );
    });
  }
}

Widget getHeadlineWithInfoDialog(
    {required BuildContext context,
    required String infoText,
    required String caption}) {
  return getHeadline(
    context: context,
    caption: GestureDetector(
      onTap: () => {getInfoDialog(info: infoText, context: context)},
      child: Row(children: [
        Text(caption, style: Theme.of(context).textTheme.headlineLarge),
        Padding(
          padding: EdgeInsets.only(left: 5.h),
          child: Icon(Icons.info_outline, size: 14),
        )
      ]),
    ),
  );
}
