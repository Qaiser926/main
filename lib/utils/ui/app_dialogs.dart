import 'package:flutter/material.dart';

class getDialog extends StatefulWidget {
  final List<Widget> actions;
  final String dialogText;

  getDialog({Key? key, required this.actions, required this.dialogText})
      : super(key: key);

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
    final String dialogText = widget.dialogText;
    return AlertDialog(
      title: Text(dialogText),

// To display the title it is optional
// Message which will be pop up on the screen
// Action widget which will provide the user to acknowledge the choice
      actions: widget.actions,
    );
  }
// .then((value) => print(value));
}
