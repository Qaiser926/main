import 'package:flutter/material.dart';
import '../../config/themes/color_data.dart';


//TODO build dialog flexible
Future<void> getShowDialog(context, objectTitle) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
// TODO language alignment
          Text(
              'Möchtest du "${objectTitle}" von deinen Favoriten entfernen?'),
// To display the title it is optional
// Message which will be pop up on the screen
// Action widget which will provide the user to acknowledge the choice
          actions: [
            TextButton(
// FlatButton widget is used to make a text to work like a button
              onPressed: () =>
                  Navigator.pop(context, false),
// function used to perform after pressing the button
              child: Text('CANCEL',
                  style: TextStyle(
                      color: accentColor)),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, true),
              child: Text('ACCEPT',
                  style: TextStyle(
                      color: accentColor)),
            ),
          ],
        );
// ToDO somehow set state such that corresponding event/ activity is deleted
      }).then((value) => print(value));
}