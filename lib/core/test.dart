import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/filter_related/search_notifier.dart';

class TestPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SearchNotifier>(builder: (context, model, child) {
        return Center(
          child: Row(children: [
            ElevatedButton(
                onPressed: () {
                  Provider.of<SearchNotifier>(context, listen: false).setIndex =
                      1;
                },
                child: Text("goNext")),
            ElevatedButton(
                onPressed: () {
                  var rng = Random();
                  int randInt = rng.nextInt(10000);
                  print(randInt);
                  Provider.of<SearchNotifier>(context, listen: false).setInt1 =
                      randInt;
                },
                child: Icon(Icons.dangerous)),
            Container(
              height: 200,
              width: 200,
              color: Colors.red,
              child: Text(model.int1.toString()),
            )
          ]),
        );
      }),
    );
  }
}

class TestPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SearchNotifier>(builder: (context, model, child) {
        return Center(
          child: Row(children: [
            ElevatedButton(
                onPressed: () {
                  Provider.of<SearchNotifier>(context, listen: false).setIndex =
                      0;
                },
                child: Text("go Previous")),
            ElevatedButton(
                onPressed: () {
                  var rng = Random();
                  int randInt = rng.nextInt(10000);
                  print(randInt);
                  Provider.of<SearchNotifier>(context, listen: false).setInt2 =
                      randInt;
                },
                child: Icon(Icons.javascript)),
            Container(
              height: 200,
              width: 200,
              color: Colors.green,
              child: Text(model.int1.toString()),
            )
          ]),
        );
      }),
    );
  }
}


