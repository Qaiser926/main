import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../config/themes/color_data.dart';
import '../utils/services/from_bought_ui/controllers.dart';
import '../utils/services/from_bought_ui/widget_utils.dart';
import '../utils/ui/app_dialogs.dart';
import '../utils/ui/ui_utils.dart';

class EventActivityList extends StatefulWidget {
  const EventActivityList({Key? key}) : super(key: key);

  @override
  State<EventActivityList> createState() => _EventActivityListState();
}

class _EventActivityListState extends State<EventActivityList> {
  void backClick() {
    Get.back();
  }

  PopularEventController controller = Get.put(PopularEventController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          color: dividerColor,
          thickness: 1.h,
        ),
        Flexible(
            child: GetBuilder<PopularEventController>(
          init: PopularEventController(),
          // TODO introduce sold out style
          builder: (controller) => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            itemCount: controller.newPopularEventLists.length,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              ModalEvent modalEvent = controller.newPopularEventLists[index];
              // in theory the individual widget could be put in a class from here on with modalEvent as parameter
              // TODO make events clickable and forward to their detail page
              return Container(
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: shadowColor,
                          blurRadius: 27,
                          offset: const Offset(0, 8))
                    ],
                    borderRadius: BorderRadius.circular(22.h)),
                padding: EdgeInsets.only(
                    top: 7.h, left: 7.h, bottom: 6.h, right: 20.h),
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          // currently the images are received via their path
                          getRoundImage(getAssetImage(modalEvent.image ?? "",
                              width: 100.h, height: 82.h) as Image),
                          getHorSpace(10.h),
                          Flexible(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCustomFont(
                                  modalEvent.name ?? "", 18.sp, Colors.black, 1,
                                  fontWeight: FontWeight.w600,
                                  txtHeight: 1.5.h),
                              getVerSpace(4.h),
                              // TODO change for activities
                              getCustomFont(
                                  modalEvent.date ?? '', 15.sp, greyColor, 1,
                                  fontWeight: FontWeight.w500,
                                  txtHeight: 1.46.h)
                            ],
                          ))

                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            // on pressed open dialog window
                            onPressed: () {
                              getShowDialog(context, modalEvent);
                            }),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )),
      ],
    );
  }
}
