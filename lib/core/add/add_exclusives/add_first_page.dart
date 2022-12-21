import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
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
        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
                key: test,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(),
                    TextField(),
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
                autovalidateMode: AutovalidateMode.always),
          ),
        ),
      ]),
    );
  }
}
