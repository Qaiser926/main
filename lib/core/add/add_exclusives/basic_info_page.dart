import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/core/add/add.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

// TODO categorization, price, ticket link, description, optional: slider for activity lvl

class BasicInfoPage extends StatefulWidget {
  AddEANotifier inputNotifier;

  BasicInfoPage(this.inputNotifier);

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  TextEditingController _textController = TextEditingController();

  String? mainCategoryId;
  String? categoryId;
  String? title;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        content: const Text(
            'You can add private and public events and activities, also if you are not the official organizer'),
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            getHeadline(
                context: context,
                caption: Text("Title",
                    style: Theme.of(context).textTheme.headlineLarge)),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
              child: buildTitleSection(),
            ),
            getHeadline(
                context: context,
                caption: Text("Categorization",
                    style: Theme.of(context).textTheme.headlineLarge)),
            Padding(
                padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                child: buildDropDown(
                    defaultValue: widget.inputNotifier.mainCategoryId,
                    hintText: "Select the main category",
                    onValidErrorText: 'Please state a category',
                    dropDownList: Categories.categoryIds,
                    notifierFunction: (mainCategoryId) {
                      widget.inputNotifier.mainCategoryId = mainCategoryId;
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
                      hintText: "Select a sub-category",
                      onValidErrorText: 'Please state a sub-category',
                      dropDownList: categoryIdToSubcategoryIds[
                          widget.inputNotifier.mainCategoryId]!,
                      notifierFunction: (categoryId) {
                        setState(() => {this.categoryId = categoryId});
                        widget.inputNotifier.categoryId = categoryId;
                      })),
          ]),
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
            return 'Please enter some text';
          }
          return null;
        },
        initialValue: Provider.of<AddEANotifier>(context, listen: false).title,
        controller:
        Provider.of<AddEANotifier>(context, listen: false).title == null
                ? _textController
                : null,
        onChanged: (title) {
          setState(() => {this.title = title});

          widget.inputNotifier.title = title;
        },
        maxLength: 100,
        maxLines: null,
        decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(5.h),
            border: OutlineInputBorder(),
            hintText: 'Enter the title '),
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
