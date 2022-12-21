import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class FirstAddPage extends StatelessWidget {
  GlobalKey<FormState> test2 = GlobalKey();
  InputNotifier not;

  FirstAddPage(this.not);

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
                  not.addImage = temp;
                }
              },
              child: Stack(
                children: [
                  Consumer<InputNotifier>(builder: (context, model, child) {
                    return model.loadedImages.isEmpty
                        ? SizedBox.shrink()
                        : model.loadedImages[0];
                  }),
                  Center(child: Text("Hier klicken")),
                ],
              ),
            ),
          ),
          getSwitch(
              headline: "Was möchtest du hinzufügen?",
              onPressed: onPressedOne,
              isSelected: Provider.of<InputNotifier>(context, listen: true)
                  .selectedFruits,
              children: [
                Text('Event'),
                Text('Activity'),
              ]),
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
    not.selectedFruits = index;
  }

  void onPressedTwo(int index) {
    not.privateOrPublic = index;
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
