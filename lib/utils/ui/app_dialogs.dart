import 'package:flutter/material.dart';
import '../../config/themes/color_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class getDialog extends StatefulWidget {
  final String objectTitle;

  getDialog({Key? key, required String this.objectTitle}) : super(key: key);

  @override
  _getDialogState createState() => _getDialogState();
}

class _getDialogState extends State<getDialog> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final String dialogText =
        AppLocalizations.of(context)!.removeFavoriteDialog(widget.objectTitle);
    return AlertDialog(
      title:
// TODO language alignment
          Text(dialogText),

// To display the title it is optional
// Message which will be pop up on the screen
// Action widget which will provide the user to acknowledge the choice
      actions: [
        TextButton(
// FlatButton widget is used to make a text to work like a button
          onPressed: () => Navigator.pop(context, false),
// function used to perform after pressing the button
          child: Text('CANCEL', style: TextStyle(color: accentColor)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('ACCEPT', style: TextStyle(color: accentColor)),
        ),
      ],
    );
  }
// .then((value) => print(value));
}
