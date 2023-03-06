import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:othia/constants/asset_constants.dart';
import 'package:othia/utils/ui/ui_utils.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
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
        // TODO clear (extern)  align colors
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
              )),
          elevation: 0,
          toolbarHeight: 53.h,
          title: Text(AppLocalizations.of(context)!.privacy),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              getVerSpace(25.h),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Html(
                  data: AssetConstants.dataProtectionDisclaimer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
