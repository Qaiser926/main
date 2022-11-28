import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/models/detailed_event.dart';
import '../../widgets/splash_screen.dart';

class FeaturedEventDetail extends StatelessWidget {
  final Future<DetailedEvent> _event;

  const FeaturedEventDetail({
    super.key,
    required Future<DetailedEvent> event,
  }) : _event = event;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _event,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              throw Exception();
            } else {
              return Scaffold(
                body: Row(children: [Text(snapshot.data.toString())]),
              );
            }
          } else {
            return SplashScreen();
          }
        });
  }
}
