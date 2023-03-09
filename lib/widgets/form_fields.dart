import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

DropdownButtonFormField getDropDownFormField(
    {required String onInvalidErrorText,
    required List<String> dropDownList,
    required BuildContext context,
    String? hintText,
    Function(dynamic val)? onChangedFunction,
    String? defaultValue,
    Function? valueTransformer}) {
  if (valueTransformer == null) {
    valueTransformer = (BuildContext context, String value) {
      return value;
    };
  }
  return DropdownButtonFormField(
    hint: hintText != null ? Text(hintText) : null,
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

class CustomTextFormField extends TextFormField {
  CustomTextFormField(
      {super.key,
      Function(dynamic val)? onChanged,
      String? Function(String?)? validator,
      dynamic initialValue,
      String? hintText,
      List<FilteringTextInputFormatter>? inputFormatters,
      TextEditingController? controller,
      int errorMaxLines = 1,
      IconData? iconData,
      int? maxLines,
      int? maxLength,
      bool numberInput = false,
      bool obscureText = false,
      String? counterText,
      void Function()? onTap,
      bool enabled = true,
      Widget? suffixIcon})
      : super(
            onTap: onTap,
            enabled: enabled,
            obscureText: obscureText,
            maxLines: maxLines,
            maxLength: maxLength,
            controller: controller,
            keyboardType: numberInput ? TextInputType.number : null,
            decoration: InputDecoration(
                errorStyle: TextStyle(),
                errorMaxLines: errorMaxLines,
                suffixIcon: suffixIcon,
                counterText: counterText,
                prefixIcon: iconData != null
                    ? Icon(
                        iconData,
                      )
                    : null,
                contentPadding: EdgeInsets.all(5.h),
                border: const OutlineInputBorder(),
                hintText: hintText),
            validator: validator,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            initialValue: initialValue);
}

Future<DateTime?> pickBirthDate({
  required BuildContext context,
  String? initialDate,
}) async {
  var date = await showDatePicker(
    context: context,
    // TODO  (extern) set locale user specific & align style
    // locale: const getCurrentLocale(),
    initialDate:
        initialDate != null ? DateTime.parse(initialDate) : DateTime.now(),
    firstDate: DateTime.now().subtract(Duration(days: 36500)),
    lastDate: DateTime.now(),
  );
  if (date != null) {
    return date;
  } else {
    return null;
  }
}
