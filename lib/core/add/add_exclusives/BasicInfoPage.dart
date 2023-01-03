import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'input_notifier.dart';

// TODO give user hints if information are missing when going to next page
// TODO categorization, price, ticket link, description, optional: slider for activity lvl
// TODO show must be logged in if user is not logged in

class BasicInfoPage extends StatelessWidget {
  TextEditingController _textController = TextEditingController();
  AddEANotifier inputNotifier;

  BasicInfoPage(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                controller: _textController,
                onChanged: (title) {
                  inputNotifier.title = title;
                },
                maxLength: 100,
                maxLines: null,
                decoration: new InputDecoration(
                    contentPadding: EdgeInsets.all(5.h),
                    border: OutlineInputBorder(),
                    hintText: 'Enter the title '),
              )
            ])));
  }
}
