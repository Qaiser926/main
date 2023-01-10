import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

DropdownButtonFormField buildDropDownFormField(
    {required String hintText,
    required String onInvalidErrorText,
    required List<String> dropDownList,
    required Function(dynamic val) onChangedFunction,
    required String? defaultValue,
    required BuildContext context,
    Function? valueTransformer}) {
  if (valueTransformer == null) {
    valueTransformer = (BuildContext context, String value) {
      return value;
    };
  }
  return DropdownButtonFormField(
    hint: Text(hintText),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return onInvalidErrorText;
      }
      return null;
    },
    value: defaultValue,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5.h),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        border: OutlineInputBorder()),
    onChanged: onChangedFunction,
    items: dropDownList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          valueTransformer!(context, value),
        ),
      );
    }).toList(),
  );
}
