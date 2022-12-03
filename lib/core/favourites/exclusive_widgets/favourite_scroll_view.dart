import 'package:flutter/material.dart';
import 'package:othia/core/favourites/exclusive_widgets/pinned_header.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';
import 'favourite_list_item.dart';
import 'list_change_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteSrollView extends StatelessWidget {
  FavouriteEventsAndActivities favouriteEventAndActivity;
  TabController tabController;
  var scrollController;

  FavouriteSrollView(
      {required TabController this.tabController,
      required this.scrollController,
      required this.favouriteEventAndActivity});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
              value: FavouritePastEventNotifier(
                  favouriteType: FavouriteType.pastEvent,
                  listenedFavourite: favouriteEventAndActivity.pastEvents)),
          ChangeNotifierProvider.value(
              value: FavouriteUpcomingEventNotifier(
                  favouriteType: FavouriteType.upcomingEvent,
                  listenedFavourite: favouriteEventAndActivity.futureEvents))
        ],
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: TabBarView(controller: tabController, children: [
            getFavouriteEventPart(context),
            getFavouriteActivityPart()
          ]),
        ));
  }

  Widget getFavouriteActivityPart() {
    //TODO
    return CustomScrollView(slivers: []);
  }

  Widget getFavouriteEventPart(BuildContext context) {
    return CustomScrollView(slivers: [
      Consumer<FavouriteUpcomingEventNotifier>(
          builder: (context, model, child) => getSliverSection(
              headerText: AppLocalizations.of(context)!.futureEvents,
              model: model)),
      Consumer<FavouritePastEventNotifier>(
          builder: (context, model, child) => getSliverSection(
              headerText: AppLocalizations.of(context)!.pastEvents,
              model: model))
    ]);
  }

  Widget getSliverSection({required final String headerText, required model}) {
    if (model.updatedList.isEmpty) {
      return SliverToBoxAdapter();
    } else {
      return MultiSliver(pushPinnedChildren: true, children: [
        SliverPinnedHeader(
          child: getHeader(text: headerText),
        ),
        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          while (index < model.updatedList.length) {
            return getFavouriteListItem(
                context, model.updatedList.values.elementAt(index));
          }
        }))
      ]);
    }
  }
}
