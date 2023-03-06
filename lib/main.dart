import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'amplifyconfiguration.dart';
import 'config/routes/pages.dart';
import 'config/routes/routes.dart';
import 'config/themes/dark_theme.dart';
import 'constants/locales_settings.dart';
import 'firebase_options.dart';
import 'utils/services/global_navigation_notifier.dart';

late final GlobalNavigationNotifier _globalNavigationNotifier;

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  _globalNavigationNotifier = GlobalNavigationNotifier();
  await _globalNavigationNotifier.initializeUserLoggedIn();
  await _globalNavigationNotifier.initializeUserId();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: LocaleProvider(),
            ),
            ChangeNotifierProvider.value(
              value: _globalNavigationNotifier,
            ),
          ],
          child: Consumer<LocaleProvider>(
              builder: (context, localeProvider, child) {
            return GetMaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              locale: localeProvider.locale,
              supportedLocales: supportedLocales,
              // builder: Authenticator.builder(),
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.homeRoute,
              // getPages: ,
              routes: Pages.routes,
              theme: getDarkThemeData(),
              onGenerateRoute: (settings) {
                if (settings.name == Routes.homeRoute) {
                  return MaterialPageRoute(
                      builder: Pages.routes[Routes.homeRoute]!);
                }
              },
            );
          }),
        );
      },
    );
  }
}

Future<void> _configureAmplify() async {
  // Add any Amplify plugins you want to use
  // Add the following line to add API plugin to your app.
  // Auth plugin needed for IAM authorization mode, which is default for REST API.
  // final auth = AmplifyAuthCognito();
  final api = AmplifyAPI();
  final auth = AmplifyAuthCognito();
  final analyticsPlugin = AmplifyAnalyticsPinpoint();
  await Amplify.addPlugins([api, auth, analyticsPlugin]);

  // You can use addPlugins if you are going to be adding multiple plugins
  // await Amplify.addPlugins([authPlugin, analyticsPlugin]);

  // Once Plugins are added, configure Amplify
  // Note: Amplify can only be configured once.
  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    safePrint(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  } on Exception catch (e) {
    safePrint("unexpected Amplify Error");
    safePrint(e);
  }
}
