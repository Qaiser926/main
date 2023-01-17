import 'package:flutter/material.dart';

import '../../constants/colors.dart';

Widget getSome(
    String hintText, IconData iconData, TextEditingController controller) {
  return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: primaryColor),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(iconData),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: controller,
                maxLines: 1,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: hintText,
                  label: Text(hintText),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ));
}
