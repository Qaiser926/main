import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar/nav_bar_notifier.dart';

class TestPageBabo extends StatefulWidget {
  static final List<Widget> _pages = [
    // TODO insert HOME instead of EventDetail
    TestPage1(),
    TestPage2()
  ];

  TestPageBabo({super.key});

  @override
  State<TestPageBabo> createState() => _TestPageBaboState();
}

class _TestPageBaboState extends State<TestPageBabo>
    with AutomaticKeepAliveClientMixin<TestPageBabo> {
  late TestNotifier notifier;
  late PageController _pageController;

  @override
  void initState() {
    notifier = Provider.of<NavigationBarNotifier>(context, listen: false)
        .getTestNotifier;
    _pageController = notifier.getPageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: notifier,
          )
        ],
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: TestPageBabo._pages,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class TestPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TestNotifier>(builder: (context, model, child) {
        return Center(
          child: Row(children: [
            ElevatedButton(
                onPressed: () {
                  Provider.of<TestNotifier>(context, listen: false).setIndex =
                      1;
                },
                child: Text("goNext")),
            ElevatedButton(
                onPressed: () {
                  var rng = Random();
                  int randInt = rng.nextInt(10000);
                  print(randInt);
                  Provider.of<TestNotifier>(context, listen: false).setInt1 =
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
      body: Consumer<TestNotifier>(builder: (context, model, child) {
        return Center(
          child: Row(children: [
            ElevatedButton(
                onPressed: () {
                  Provider.of<TestNotifier>(context, listen: false).setIndex =
                      0;
                },
                child: Text("go Previous")),
            ElevatedButton(
                onPressed: () {
                  var rng = Random();
                  int randInt = rng.nextInt(10000);
                  print(randInt);
                  Provider.of<TestNotifier>(context, listen: false).setInt2 =
                      randInt;
                },
                child: Icon(Icons.javascript)),
            Container(
              height: 200,
              width: 200,
              color: Colors.green,
              child: Text(model.int2.toString()),
            )
          ]),
        );
      }),
    );
  }
}

class TestNotifier extends ChangeNotifier {
  bool isControllerSet = false;

  final PageController _pageController;

  TestNotifier({required PageController pageController})
      : _pageController = pageController;

  PageController getPageController() {
    return _pageController;
  }

  int currentIndex = 0;

  int int1 = 1;
  int int2 = 2;

  set setIndex(int foo) {
    currentIndex = foo;
    _pageController.jumpToPage(currentIndex);
  }

  set setInt1(int foo) {
    int1 = foo;
    notifyListeners();
  }

  set setInt2(int bar) {
    int2 = bar;
    notifyListeners();
  }
}
