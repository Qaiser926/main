import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:othia/widgets/vertical_discovery/pinned_header.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../modules/models/favourite_event_and_activity/favourite_events_and_activities.dart';
import '../../../widgets/vertical_discovery/favourite_list_item.dart';
import 'empty_favourite_screen.dart';
import 'list_change_notifier.dart';

class FavouriteScrollView extends StatelessWidget {
  final FavouriteEventsAndActivities favouriteEventAndActivity;
  final TabController tabController;

  const FavouriteScrollView(
      {super.key,
      required this.tabController,
      required this.favouriteEventAndActivity});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: FavouriteNotifier(
              openActivities: favouriteEventAndActivity.openActivities,
              closedActivities: favouriteEventAndActivity.closedActivities,
              pastEvents: favouriteEventAndActivity.pastEvents,
              upcomingEvents: favouriteEventAndActivity.futureEvents),
        )
      ],
      child: TabBarView(
          controller: tabController,
          children: [getFavouriteEventPart(), getFavouriteActivityPart()]),
    );
  }

  Widget getFavouriteActivityPart() {
    return Consumer<FavouriteNotifier>(builder: (context, model, child) {
      if (model.openActivities.isEmpty && model.closedActivities.isEmpty) {
        return EmptyFavourite(
          noElementsText: AppLocalizations.of(context)!.noLikedActivities,
        );
      } else {
        return CustomScrollView(slivers: [
          getSliverSection(
              headerText: AppLocalizations.of(context)!.openActivities,
              favouriteList: model.openActivities),
          getSliverSection(
              headerText: AppLocalizations.of(context)!.closedActivities,
              favouriteList: model.closedActivities)
        ]);
      }
    });
  }

  Widget getFavouriteEventPart() {
    return Consumer<FavouriteNotifier>(builder: (context, model, child) {
      if (model.pastEvents.isEmpty && model.upcomingEvents.isEmpty) {
        return EmptyFavourite(
          noElementsText: AppLocalizations.of(context)!.noLikedEvents,
        );
      } else {
        return CustomScrollView(slivers: [
          Consumer<FavouriteNotifier>(
              builder: (context, model, child) => getSliverSection(
                  headerText: AppLocalizations.of(context)!.futureEvents,
                  favouriteList: model.upcomingEvents)),
          Consumer<FavouriteNotifier>(
              builder: (context, model, child) => getSliverSection(
                  headerText: AppLocalizations.of(context)!.pastEvents,
                  favouriteList: model.pastEvents))
        ]);
      }
    });
  }

  Widget getSliverSection(
      {required final String headerText, required Map favouriteList}) {
    if (favouriteList.isEmpty) {
      return const SliverToBoxAdapter();
    } else {
      return MultiSliver(
        pushPinnedChildren: true,
        children: [
          SliverPinnedHeader(
            child: getHeader(text: headerText),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              while (index < favouriteList.length) {
                return getVerticalSummary(
                    context: context,
                    eASummary: favouriteList.values.elementAt(index),
                    actionButton: getFavouriteLikeButton(
                        context: context,
                        eASummary: favouriteList.values.elementAt(index)));
              }
              return null;
            }),
          )
        ],
      );
    }
  }
}
