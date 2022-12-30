import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:othia/core/add/add_exclusives/TimeSelector.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

// TODO give user hints if information are missing
// TODO categorization, price, ticket link, description, optional: slider for activity lvl

enum DateType {
  StartDate,
  EndDate,
}

class FirstAddPage extends StatefulWidget {
  InputNotifier inputNotifier;

  FirstAddPage(this.inputNotifier);

  @override
  State<FirstAddPage> createState() => _FirstAddPageState(inputNotifier);
}

class _FirstAddPageState extends State<FirstAddPage> {
  GlobalKey<FormState> test2 = GlobalKey();
  InputNotifier inputNotifier;

  _FirstAddPageState(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  Consumer<InputNotifier>(builder: (context, model, child) {
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

          Consumer<InputNotifier>(builder: (context, model, child) {
            return getSwitch(
                headline:
                    "Do you want to add a start and end date or opening times?",
                onPressed: onPressedOne,
                isSelected: model.selectedFruits,
                children: [
                  GestureDetector(
                    onTap: () {
                      model.selectedFruits = 0;
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      child: Text("Start/ End time"),
                    ),
                  ),
                  Text('Öffnungszeiten'),
                ]);
          }),

          if (Provider.of<InputNotifier>(context, listen: true)
              .selectedFruits[0])
            TimeSelector(context: context, inputNotifier: inputNotifier),
          // TODO informiere user über Unterschied
          getSwitch(
              headline: "Privat oder Öffentlich?",
              onPressed: onPressedTwo,
              isSelected: Provider.of<InputNotifier>(context, listen: true)
                  .privateOrPublic,
              children: [
                Text('Öffentlich'),
                Text('Privat'),
              ]),
          Form(
            key: test2,
            autovalidateMode: AutovalidateMode.always,
            child: Column(children: [
              getPadding(),
            ]),
          )
        ]),
      ),
    );
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

  void onPressedOne(int index) {
    inputNotifier.selectedFruits = index;
  }

  void onPressedTwo(int index) {
    inputNotifier.privateOrPublic = index;
  }

  Widget getSwitch(
      {required String headline,
      required Function onPressed,
      required isSelected,
      required children}) {
    return Column(children: [
      Text(headline),
      ToggleButtons(
          direction: Axis.horizontal,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: isSelected,
          renderBorder: true,
          onPressed: (index) => onPressed(index),
          children: children),
    ]);
  }

  Widget getPadding() {
    // TODO introduce online option
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(hintText: "Titel / Name"),
          Row(
            children: [
              SizedBox(
                height: 60,
                width: 250,
                child: CustomTextFormField(
                  hintText: "Straße",
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 60,
                width: 50,
                child: CustomTextFormField(
                  hintText: "Nr",
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 60,
                width: 200,
                child: CustomTextFormField(
                  hintText: "Stadt",
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 60,
                width: 100,
                child: CustomTextFormField(
                  hintText: "Plz",
                ),
              ),
            ],
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     if (test2.currentState!.validate()) {
          //       print("valid");
          //     }
          //   },
          //   child: Text("dfsd"),
          // )
        ],
      ),
    );
  }
}

class SecondAddPage extends StatelessWidget {
  GlobalKey<FormState> test = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Form(
          key: test,
          autovalidateMode: AutovalidateMode.always,
          child: Column(children: [getCard(), getCard()]),
        )
      ]),
    );
  }

  Widget getCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(hintText: "gig"),
            Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 150,
                  child: TextFormField(
                    maxLength: 30,
                    maxLines: 12,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 60,
                  width: 150,
                  child: TextFormField(
                    maxLength: 30,
                    maxLines: 12,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (test.currentState!.validate()) {
                  print("valid");
                }
              },
              child: Text("dfsd"),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends TextFormField {
  CustomTextFormField({super.key, String? hintText})
      : super(decoration: InputDecoration(hintText: hintText));
}
