import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:othia/constants/locales_settings.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isGermanSelected = false;
  bool isEnglishSelected = false;

  void backClick() {
    Get.back();
  }

  @override
  void initState() {
    // TODO clear (extern) currently not working to get the currently set locale
    if (context.read<LocaleProvider>().getLocale == Locale('en', ''))
      isEnglishSelected = true;
    if (context.read<LocaleProvider>().getLocale == Locale('de', ''))
      isGermanSelected = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        // TODO clear (extern) align colors
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 53.h,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )),
          title: Text(AppLocalizations.of(context)!.language),
        ),
        body: SafeArea(
          child: Column(
            children: [
              getVerSpace(25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 35.h),
                            backgroundColor: isGermanSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.tertiary),
                        onPressed: () => {
                              setState(() {
                                context
                                    .read<LocaleProvider>()
                                    .setLocale(Locale('de', ''));
                                isGermanSelected = true;
                                isEnglishSelected = false;
                              })
                            },
                        child: Text(AppLocalizations.of(context)!.german))),
              ),
              getVerSpace(25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 35.h),
                            backgroundColor: isEnglishSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.tertiary),
                        onPressed: () => {
                              setState(() {
                                context
                                    .read<LocaleProvider>()
                                    .setLocale(Locale('en', ''));
                                isGermanSelected = false;
                                isEnglishSelected = true;
                              })
                            },
                        child: Text(AppLocalizations.of(context)!.english))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
