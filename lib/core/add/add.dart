import 'package:flutter/material.dart';

import 'add_exclusives/add_first_page.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  // static const Widget test = Test();

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(initialPage: 0);

    // NavigatorConstants.sendToScreen(test);

    return Scaffold(
      body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [FirstAddPage(), SecondAddPage()]),
      bottomNavigationBar: Row(children: [
        IconButton(
            onPressed: () {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.decelerate);
            },
            icon: Icon(Icons.arrow_back)),
        Spacer(),
        IconButton(
            onPressed: () {
              _pageController.nextPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.decelerate);
            },
            icon: Icon(Icons.arrow_forward))
      ]),
    );
  }
}
