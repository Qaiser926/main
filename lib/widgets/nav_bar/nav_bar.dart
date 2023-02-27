import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nav_bar_notifier.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  build(BuildContext context) {
    return Consumer<NavigationBarNotifier>(builder: (context, model, child) {
      return NavigationBar(
          height: MediaQuery.of(context).size.height / 10,
          destinations: getCustomNavigationDestinations(),
          // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: model.getIndex,
          onDestinationSelected: (index) {
            Provider.of<NavigationBarNotifier>(context, listen: false)
                .setIndex(context: context, index: index);
          });
    });
  }

  List<Widget> getCustomNavigationDestinations() {
    List<Widget> result = [];

    result.add(CustomNavigationDestination(
      selectedIcon: Icon(Icons.home_outlined, color: Colors.orange),
      icon: const Icon(Icons.home_outlined),
      label: "",
    ));

    result.add(CustomNavigationDestination(
      selectedIcon: Icon(Icons.search, color: Colors.orange),
      icon: const Icon(Icons.search),
      label: "",
    ));

    result.add(CustomNavigationDestination(
      selectedIcon: Icon(Icons.add, color: Colors.orange),
      icon: const Icon(Icons.add),
      label: "",
    ));

    result.add(CustomNavigationDestination(
      selectedIcon: Icon(Icons.favorite_outline, color: Colors.orange),
      icon: const Icon(Icons.favorite_outline),
      label: "",
    ));

    result.add(CustomNavigationDestination(
      selectedIcon: Icon(Icons.perm_identity, color: Colors.orange),
      icon: const Icon(Icons.perm_identity),
      label: "",
    ));
    return result;
  }
}

class CustomNavigationDestination extends NavigationDestination {
  CustomNavigationDestination(
      {required icon, required label, Widget? selectedIcon})
      : super(
          icon: icon,
          label: label,
          selectedIcon: selectedIcon,
        );
}
