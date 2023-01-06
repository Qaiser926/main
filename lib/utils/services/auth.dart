// Do not forget to import the following for StreamSubscription
import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';

StreamSubscription<HubEvent> hubSubscription =
    Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
  switch (hubEvent.eventName) {
    case 'SIGNED_IN':
      print('USER IS SIGNED IN');
      break;
    case 'SIGNED_OUT':
      print('USER IS SIGNED OUT');
      break;
    case 'SESSION_EXPIRED':
      print('SESSION HAS EXPIRED');
      break;
    case 'USER_DELETED':
      print('USER HAS BEEN DELETED');
      break;
  }
});
