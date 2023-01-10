import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/core/detailed/detailedEA.dart';
import 'package:othia/core/main_page.dart';
import 'package:othia/modules/models/detailed_event/detailed_event.dart';
import 'package:othia/utils/helpers/builders.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/services/data_handling/keep_alive_future_builder.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'input_notifier.dart';

class SaveForwardingPage extends StatefulWidget {
  DetailedEventOrActivity detailedEA;

  SaveForwardingPage(this.detailedEA);

  @override
  State<SaveForwardingPage> createState() => _SaveForwardingPageState();
}

class _SaveForwardingPageState extends State<SaveForwardingPage> {
  bool showWaitingMessage = true;
  late Future<Object> response;
  late String eAId;
  GlobalKey _globalKey = new GlobalKey();
  ButtonStyle _buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.h),
  )));

  @override
  void initState() {
    if (showWaitingMessage) {
      response =
          RestService().crateEA(detailedEventOrActivity: widget.detailedEA);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getVerSpace(70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.share,
                      style: Theme.of(context).textTheme.headlineLarge)
                ],
              ),
              getVerSpace(30.h),
              RepaintBoundary(
                key: _globalKey,
                child: QrImage(
                  data: '${eAShareLinkBuilder(widget.detailedEA.id!)}',
                  version: QrVersions.auto,
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  size: 200.0,
                ),
              ),
              getVerSpace(30.h),
              buildShareButtons(),
              getVerSpace(10.h),
              Padding(
                padding: EdgeInsets.only(bottom: 15.h, top: 10.h),
                child: Divider(thickness: 2.h),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.navigation,
                      style: Theme.of(context).textTheme.headlineLarge)
                ],
              ),
              getVerSpace(20.h),
              buildNavigationBox(),
            ],
          ),
        )));
  }

  Widget getButton({required Function() onTap, required Widget caption}) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(10.h))),
      child: GestureDetector(
        onTap: onTap,
        child: caption,
      ),
    );
  }

  Widget buildShareButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getButton(
            onTap: () {
              openShare('${eAShareLinkBuilder(widget.detailedEA.id!)}');
            },
            caption: Padding(
              padding: EdgeInsets.all(8.h),
              child: Container(
                width: 110.h,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.shareLink,
                    ),
                    getHorSpace(10.h),
                    Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )),
        getButton(
            onTap: () {
              _captureAndStorePng();
            },
            caption: Padding(
              padding: EdgeInsets.all(8.h),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.storeQRCode,
                  ),
                  getHorSpace(10.h),
                  Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Widget buildNavigationBox() {
    return showWaitingMessage
        ? Column(
            children: [
              // TODO (extern) show more elaborate error message, e.g., notify user that deletion of event/activity was not successful, most likely this required modification of the snapshot handler, where different pages are shown depending on the error case
              // TODO: (extern) routing after error navigation, e.g. to Home page or add page
              KeepAliveFutureBuilder(
                  future: response,
                  builder: (context, snapshot) {
                    return snapshotHandler(snapshot, futureHandler,
                        [context, widget.detailedEA.id!]);
                  }),
              getVerSpace(10.h),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Text(AppLocalizations.of(context)!.saveEAWaitingMessage,
                    textAlign: TextAlign.center),
              ),
            ],
          )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => DetailedEAPage(), arguments: {
                      DataConstants.EventActivityId: eAId,
                      DataConstants.notGoBack: true
                    });
                  },
                  style: _buttonStyle,
                  child: Text(AppLocalizations.of(context)!.goToCreatedEA)),
              ElevatedButton(
                  onPressed: () {
                    Provider.of<GlobalNavigationNotifier>(context,
                            listen: false)
                        .navigationBarIndex = NavigatorConstants.HomePageIndex;
                    NavigatorConstants.sendToScreen(MainPage());
                  },
                  style: _buttonStyle,
                  child: Text(
                    AppLocalizations.of(context)!.gotToHome,
                  ))
            ],
          );
  }

  Widget futureHandler(
      BuildContext context, String eAId, Map<String, dynamic> decodedJson) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        showWaitingMessage = false;
        this.eAId = eAId;
      });
    });
    return SizedBox();
  }

  Future<void> _captureAndStorePng() async {
    try {
      RenderRepaintBoundary? boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary?.toImage();
      ByteData? byteData = await image?.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      await GallerySaver.saveImage('${tempDir.path}/image.png');
      // TODO (extern) design of snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.storedQRCodeMessage),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      print(e.toString());
    }
  }
}

class DeleteForwardingPage extends StatelessWidget {
  AddEANotifier inputNotifier;
  String userId;

  DeleteForwardingPage(this.inputNotifier, this.userId);

  @override
  Widget build(BuildContext context) {
    late Future<Object> response = RestService().deleteEA(
        deleteEA: DeleteEA(eAId: inputNotifier.detailedEA.id!, userId: userId));
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO (extern) show more elaborate error message, e.g., notify user that deletion of event/activity was not successful, most likely this required modification of the snapshot handler, where different pages are shown depending on the error case
            // TODO: (extern) routing after error navigation, e.g. to Home page or add page

            KeepAliveFutureBuilder(
                future: response,
                builder: (context, snapshot) {
                  return snapshotHandler(snapshot, goToProfilePage, [context]);
                }),
            getVerSpace(10.h),
            Padding(
              padding: EdgeInsets.all(10.h),
              child: Text(AppLocalizations.of(context)!.deleteEAWaitingMessage,
                  textAlign: TextAlign.center),
            ),
          ],
        )));
  }
}

Widget goToProfilePage(BuildContext context, Map<String, dynamic> decodedJson) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<GlobalNavigationNotifier>(context, listen: false)
        .navigationBarIndex = NavigatorConstants.ProfilePageIndex;
    NavigatorConstants.sendToScreen(MainPage());
  });
  return SizedBox();
}