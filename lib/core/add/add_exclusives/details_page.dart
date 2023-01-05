import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:othia/core/add/add.dart';
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
                    style: Theme.of(context).textTheme.headline4)),
            // TODO wait for Mattis to recycle code
            SizedBox(
              width: 200,
              height: 200,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  Image? temp = await _getFromGallery();
                  if (temp != null) {
                    inputNotifier.addImage = temp;
                  }
                },
                child: Stack(
                  children: [
                    Consumer<AddEANotifier>(builder: (context, model, child) {
                      return model.loadedImages.isEmpty
                          ? SizedBox.shrink()
                          : model.loadedImages[0];
                    }),
                    // TODO dynamic text, after uploading  "change image"
                    Center(child: Text("Hier klicken")),
                  ],
                ),
              ),
            ),
            getHeadline(
                context: context,
                caption: Text("Description",
                    style: Theme.of(context).textTheme.headline4)),
            buildDescriptionBox(context),
            getHeadline(
                context: context,
                caption: Text("Price",
                    style: Theme.of(context).textTheme.headline4)),
            buildPricePicker(context),
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
                    "Add Price",
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

  Widget buildPriceRow(
      {required int index,
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
                        hintText: 'Label'),
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
}

class InputPrice {
  String? label;
  double? price;

  InputPrice({this.price, this.label});
}
