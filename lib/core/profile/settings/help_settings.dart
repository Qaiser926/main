import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  void backClick() {
    Get.back();
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
          elevation: 0,
          toolbarHeight: 53.h,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )),
          title: Text(AppLocalizations.of(context)!.help),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 0, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // getVerSpace(25.h),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text.rich(TextSpan(
                            text:
                                'If you need help or you want to give us feeback ',
                            children: <InlineSpan>[])),
                      ),
                      Row(
                        children: [
                          Center(
                            child: Text.rich(TextSpan(
                                text:
                                    '                feel free to contact us:',
                                children: <InlineSpan>[
                                  TextSpan(
                                      text: ' othia@outlook.de',
                                      style: TextStyle(
                                          color: Colors.orange.shade900,
                                          fontSize: 16)),
                                ])),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
