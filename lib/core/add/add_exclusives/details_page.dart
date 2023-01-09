import 'dart:convert';
import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:othia/constants/colors.dart';
import 'package:othia/core/add/add.dart';
import 'package:othia/core/add/add_exclusives/location_time_page.dart';
import 'package:othia/utils/services/data_handling/data_handling.dart';
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
            buildImagePicker(context),
            getHeadline(
                context: context,
                caption: Text("Description (optional)",
                    style: Theme.of(context).textTheme.headlineLarge)),
            buildDescriptionBox(context),
            getHeadline(
                context: context,
                caption: Text("Price",
                    style: Theme.of(context).textTheme.headlineLarge)),
            buildPricePicker(context),
            getVerSpace(10.h),
            getHeadline(
              context: context,
              caption: GestureDetector(
                onTap: () => {
                  getInfoDialog(
                      info:
                          "Here you have the opportunity to insert your ticket-url or website-url. User will be forwarded from the Othia app to the corresponding url.",
                      context: context)
                },
                child: Row(children: [
                  Text("Ticketing or Website (optional)",
                      style: Theme.of(context).textTheme.headlineLarge),
                  Padding(
                    padding: EdgeInsets.only(left: 5.h),
                    child: Icon(Icons.info_outline, size: 14),
                  )
                ]),
              ),
            ),
            buildTicketLink(context),
          ])),
    );
    // });
  }

  Future<Image?> _getFromGallery() async {
    // TODO enable that image can be changed
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      Image imageFile = Image.file(File(pickedFile.path));
      return imageFile;
    }
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

  Consumer buildPricePicker(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
          return Column(
            // TODO make each price row containing of label, price and cross scorllable
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: inputNotifierConsumer.prices.length,
                  itemBuilder: (context, index) {
                    return buildPriceRow(
                        index: index,
                        inputPrice: inputNotifierConsumer.prices[index],
                        inputNotifierConsumer: inputNotifierConsumer);
                  }),
              getVerSpace(5.h),
              GestureDetector(
                onTap: () {
                  inputNotifierConsumer.prices.add(InputPrice());
                  inputNotifier.notifyListeners();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5.h),
                      child: Text(
                        "Add Price Group",
                        style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    Icon(Icons.add)
                  ],
                ),
              )
            ],
          );
        });
  }

  Widget buildPriceRow({required int index,
    required InputPrice inputPrice,
    required AddEANotifier inputNotifierConsumer}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.only(right: 5.h, bottom: 5.h),
                  child: TextFormField(
                    controller: inputPrice.label == null
                        ? null
                        : TextEditingController(
                      text: inputPrice.label,
                    ),
                    onChanged: (label) {
                      // TODO, define variable globally on how many characters to include
                      inputNotifierConsumer.prices[index].label =
                          label.substring(0, 20);
                      inputNotifierConsumer.notifyListeners();
                    },
                    maxLines: 1,
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(5.h),
                        border: OutlineInputBorder(),
                        hintText: 'Label, e.g. "Student", "Children"'),
                  ))),
          Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.only(right: 8.h, bottom: 5.h),
                child: TextFormField(
                  controller: inputPrice.price == null
                      ? null
                      : TextEditingController(
                    text: inputPrice.price.toString(),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    CurrencyTextInputFormatter(
                      locale: 'de',
                      decimalDigits: 2,
                      symbol: '€ ',
                    ),
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (price) {
                    inputNotifierConsumer.prices[index].price = price as double;
                    inputNotifierConsumer.notifyListeners();
                  },
                  maxLines: 1,
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(5.h),
                      border: OutlineInputBorder(),
                      hintText: 'Price'),
                )),
          ),
          GestureDetector(
            onTap: () {
              inputNotifierConsumer.prices.removeAt(index);
              inputNotifierConsumer.notifyListeners();
            },
            child: Icon(Icons.close),
          )
        ],
      ),
    );
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

  Widget buildImagePicker(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 90,
        ),
        Positioned(
          child: Container(
            height: 30.h,
            width: 30.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.h),
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      offset: const Offset(0, 8),
                      blurRadius: 27)
                ]),
            padding: EdgeInsets.all(5.h),
            child: GestureDetector(
              onTap: () async {
                String? path = await getFromGallery();
                if (path != null) {
                  final bytes = File(path).readAsBytesSync();
                  final img64 = base64Encode(bytes);
                  // userInfoNotifier.updateUserInfo(image: img64);
                }
              },
              child: Icon(
                Icons.edit,
                size: 20.h,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class InputPrice {
  String? label;
  double? price;

  InputPrice({this.price, this.label});
}