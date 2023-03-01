import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:othia/core/map/exclusive_widgets/current_position.dart';
import 'package:othia/core/map/map_initialization.dart';
import 'package:othia/core/map/map_results.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/widgets/filter_related/notifiers/map_notifier.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  static final List<Widget> _pages = [
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
        child: WillPopScope(
          onWillPop: () async {
            if (Provider.of<GlobalNavigationNotifier>(context, listen: false)
                .isDialogOpen) {
              return false;
            } else {
              return closeAppDialog(context, mapNotifier);
            }
          },
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: MapPage._pages,
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;

  Future<bool> closeAppDialog(BuildContext context, MapNotifier mapNotifier) {
    if (mapNotifier.currentIndex != 0) {
      mapNotifier.backToDefault();
      mapNotifier.setIndex = 0;
      return Future(() => false);
    } else {
      return Future(() => true);
    }
  }
}
