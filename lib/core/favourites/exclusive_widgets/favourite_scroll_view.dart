import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../config/themes/color_data.dart';
import '../../../modules/models/favourite_event_and_activity/favourite_single_event_or_activity/favourite_event_or_activity.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../utils/ui/app_dialogs.dart';
import '../../../utils/ui/ui_utils.dart';
import 'list_change_notifier.dart';

class FavouriteScrollView extends StatefulWidget {
  List<FavouriteEventOrActivity> informationList = [];

  FavouriteScrollView(
      {super.key,
      required List<dynamic> informationList}) {
    this.informationList = List.from(informationList);
  }

  @override
  State<FavouriteScrollView> createState() => _FavouriteScrollViewState();
}

class _FavouriteScrollViewState extends State<FavouriteScrollView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            itemCount: widget.informationList.length,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var favouriteEventOrActivity =
                  widget.informationList[index];
              // after return should be own widget
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
                    top: 7.h, left: 7.h, bottom: 6.h, right: 10.h),
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          getRoundImage(getPhotoNullSave(
                              categoryId: favouriteEventOrActivity.categoryId,
                              photo: favouriteEventOrActivity.photo,
                              width: 100.h,
                              height: 82.h)),
                          getHorSpace(10.h),
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getCustomFont(
                                  text: favouriteEventOrActivity.title,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  txtHeight: 1.5.h),
                              getVerSpace(4.h),
                              getCustomFont(
                                  text: getTimeInformation(
                                      context: context,
                                      openingTimeCode: favouriteEventOrActivity
                                          .openingTimeCode,
                                      startTimeUtc: favouriteEventOrActivity
                                          .startTimeUtc),
                                  fontSize: 15.sp,
                                  color: greyColor,
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
                            onPressed: () async {
                              bool? removed = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => getDialog(
                                      objectTitle:
                                          favouriteEventOrActivity.title));
                              print(removed);
                              if (removed!) {
                                // setState(() {
                                //
                                // });
                                print('deleted index: $index');
                                // widget.informationList.removeAt(index);
                                // var newList = widget.informationList;
                                Provider.of<ListNotifier>(context,listen:false).removeAt(index);
                                Provider.of<ListNotifier>(context,listen:false).notify();

                                // context.read<ListNotifier>().updatedList =  newList;
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
