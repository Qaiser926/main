import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:othia/constants/app_constants.dart';
import 'package:othia/constants/no_internet.dart';
import 'package:othia/constants/no_internet_controller.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/helpers/diverse.dart';
import 'package:othia/utils/services/global_navigation_notifier.dart';
import 'package:othia/utils/services/rest-api/rest_api_service.dart';
import 'package:othia/utils/ui/future_service.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/keep_alive_future_builder.dart';
import 'package:othia/widgets/not_logged_in.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import 'add_exclusives/add_page_notifier.dart';
import 'add_exclusives/input_notifier.dart';

// TODO clear (extern) include back button only on the first adding page
class Add extends StatefulWidget {
  Add({super.key});

  static const int firstPage = 0;
  static const int lastPage = 2;

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  SwitchAddPageNotifier switchPagesNotifier =
  SwitchAddPageNotifier(Add.firstPage);
  PageController pageController = PageController(initialPage: Add.firstPage);

  AddEANotifier inputNotifier = AddEANotifier();
  late Future<Object> detailedEventOrActivity;
  late SwitchPages switchPages;
 final StudentLocationController studentFindTutorsController=Get.put(StudentLocationController());
  @override
  void initState() {
    switchPages = SwitchPages(
        inputNotifier: inputNotifier,
        pageController: pageController,
        switchPagesNotifier: switchPagesNotifier);
    // ensure that the call is only one time made
    if (!inputNotifier.snackBarShown) {
      try {
        String eAId = Get.arguments[DataConstants.EventActivityId];
        detailedEventOrActivity =
            RestService().fetchEventOrActivityDetails(eventOrActivityId: eAId);
        inputNotifier.isModifyMode = true;
      } on NoSuchMethodError catch (e) {
        // TODO clear (extern) get rid of error, just continue here
        // Do nothing, as this is the case when no eAId was passed (so adding instead of modifying case)
      }
    }
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'addScreen',
    );
    super.initState();
  }

  void backFunction() {
    int targetPage = switchPagesNotifier.currentPage - 1;
    if (targetPage < 0) {
      Get.back();
    } else {
      pageController.jumpToPage(targetPage);
    }
  }
  final connectivity=Connectivity();

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async {
          if (Provider.of<GlobalNavigationNotifier>(context, listen: false)
              .isDialogOpen) {
            return false;
          } else {
            closeSnackBar(context);
            backFunction();
            return false;
          }
        },
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: switchPagesNotifier,
            ),
            ChangeNotifierProvider.value(
              value: inputNotifier,
            )
          ],
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title:     Consumer<SwitchAddPageNotifier>(
                  builder: (context, switchPageModel, child) {
                    // TODO clear (extern) align that this button row is always aligned central for both languages
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildUpperNavigationElement(
                            context: context,
                            index: 0,
                            switchPageModel: switchPageModel),
                        getArrowIcon(context),
                        buildUpperNavigationElement(
                            context: context,
                            index: 1,
                            switchPageModel: switchPageModel),
                        getArrowIcon(context),
                        buildUpperNavigationElement(
                            context: context,
                            index: 2,
                            switchPageModel: switchPageModel),
                        getHorSpace(20.w)
                      ],
                    );
                  })
              ,
              actions: [
              ],),

            persistentFooterButtons: [getFloatingButtons(switchPages)],
            // bottomNavigationBar: getFloatingButtons(),
            // floatingActionButton: ,
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
            body:  Obx(()=>Container(
        child: studentFindTutorsController.connectionStatus.value==1?    getLoggedInSensitiveBody(
                notLoggedInMessages: NotLoggedInMessage.addPage,
                loggedInWidget: getLoggedInBody(switchPages),
                context: context)
      :studentFindTutorsController.connectionStatus.value==2?    getLoggedInSensitiveBody(
                notLoggedInMessages: NotLoggedInMessage.addPage,
                loggedInWidget: getLoggedInBody(switchPages),
                context: context):Container(
        width: Get.size.width,
        height: Get.size.height,
        child: Column(
          children: [
            Lottie.asset('assets/lottiesfile/no_internet.json',fit: BoxFit.cover),
         
          ],
        ),
      )))
            
            
         )));
              
        
      
  }

  Widget getLoggedInBody(SwitchPages switchPages) {
    // it is first tested if an existing event or acitvity is modifier or if a new one is added
    return inputNotifier.isModifyMode
        ? KeepAliveFutureBuilder(
        future: detailedEventOrActivity,
        builder: (context, snapshot) {
           if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: JumpingDotsProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
              fontSize: 20.sp,
            ),);
                    }
                    if(snapshot.hasData){
          return snapshotHandler(
              context,
              snapshot,
              getFutureHandlerPageView,
              [inputNotifier, switchPages, pageController]);
                    }else{
                      return Center(
                        child: Text("No Data Exit"),
                      );
                    }
        })
        : getFutureHandlerPageView(
        inputNotifier, switchPages, pageController, {});
  }

  Widget getFloatingButtons(SwitchPages switchPages) {
    return Consumer<SwitchAddPageNotifier>(
        builder: (context, switchPageConsumer, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              switchPageConsumer.currentPage == Add.firstPage
                  ?  SizedBox(width:88.w,)
              // ? const SizedBox.shrink()
                  : getNavigationButton(
                Icon(Icons.arrow_back),
                switchPages.previousPage,
                context,
              ),
              switchPageConsumer.currentPage == Add.lastPage
                  ? getNavigationButton(Text(AppLocalizations.of(context)!.publish),
                  publishFunction, context, 130.h)
                  : getNavigationButton(
                  Icon(Icons.arrow_forward), switchPages.nextPage, context),
            ],
          );
        });
  }

  Widget buildUpperNavigationElement({required BuildContext context,
    required SwitchAddPageNotifier switchPageModel,
    required int index}) {
    Map<int, String> navigationCaptions = {
      0: AppLocalizations.of(context)!.information,
      1: AppLocalizations.of(context)!.details,
      2: AppLocalizations.of(context)!.publish,
    };

    return Padding(
        padding: EdgeInsets.only(right: 7.w,left: 3.w),
        child: GestureDetector(
          onTap: () =>
          {pageController.jumpToPage(index), closeSnackBar(context)},
          child: Container(
            // height: 30.h,
            decoration: BoxDecoration(
                color: switchPageModel.currentPage == index
                    ? Theme.of(context).colorScheme.primary
                    : null,
                border:
                Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.all(Radius.circular(10.h))),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(4.5.h),
                child: Text(
                  navigationCaptions[index]!,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ),
          ),
        ));
  }

  Icon getArrowIcon(BuildContext context) {
    return Icon(
      Icons.arrow_forward,
      size: 17.h,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  // TODO clear (extern) when switching pages, the left button changes its position. This should be fixed.
  Widget getNavigationButton(Widget child,
      void Function(
          BuildContext context,
          )
      onPressedFunction,
      BuildContext context,
      [double? width]) {
    return SizedBox(
        width: width ?? 100,
        child: ElevatedButton(
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          // splashColor: Colors.transparent,

          onPressed: () => onPressedFunction(context),
          child: child,
        ));
  }
}
