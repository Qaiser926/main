import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/map/map_body.dart';
import 'package:provider/provider.dart';

import '../../widgets/filter_related/search_notifier.dart';

class MapPage extends StatefulWidget {
  static final List<Widget> _pages = [
    // TODO , might be to have one page "activate category filter", maybe another that filter have to be applied
    MapBodyInit(),
  ];

  MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with AutomaticKeepAliveClientMixin<MapPage> {
  late SearchNotifier notifier;
  late PageController _pageController;

  @override
  void initState() {
    notifier = SearchNotifier(
      pageController: PageController(initialPage: 0),
    );
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
        children: MapPage._pages,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
