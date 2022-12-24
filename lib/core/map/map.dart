import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/map/current_position.dart';
import 'package:othia/core/map/map_initialization.dart';
import 'package:othia/core/map/map_results.dart';
import 'package:othia/widgets/filter_related/notifiers/map_notifier.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  static final List<Widget> _pages = [
    // TODO , might be to have one page "activate category filter", maybe another that filter have to be applied
    MapInit(),
    MapResultsInit(),
  ];

  MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with AutomaticKeepAliveClientMixin<MapPage> {
  late MapNotifier mapNotifier;
  late PageController _pageController;
  late UserPositionNotifier userPositionNotifier;

  @override
  void initState() {
    mapNotifier = MapNotifier(
      pageController: PageController(initialPage: 0),
    );
    _pageController = mapNotifier.getPageController();
    userPositionNotifier = UserPositionNotifier(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: mapNotifier,
        ),
        ChangeNotifierProvider.value(value: userPositionNotifier)
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
