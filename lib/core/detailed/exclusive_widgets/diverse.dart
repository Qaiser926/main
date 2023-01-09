import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:othia/widgets/openingtimes.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/helpers/builders.dart';
import '../../../utils/services/data_handling/data_handling.dart';
import '../../../widgets/carousel_widget.dart';
import '../../../widgets/filtered_image_stack.dart';

Widget getSection(
    {required BuildContext context,
    required String caption,
    required Widget contentWidget}) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 3.h),
          getVerSpace(25),
          Text(
            caption,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          getVerSpace(25),
          contentWidget,
          getVerSpace(25.h),
        ],
      ));
}

class OpeningTimesSection extends StatelessWidget {
  final Map openingTime;

  const OpeningTimesSection({super.key, required this.openingTime});

  @override
  Widget build(BuildContext context) {
    return getSection(
      context: context,
      caption: AppLocalizations.of(context)!.openingHours,
      contentWidget: OpeningTimes(openingTime: openingTime),
    );
  }
}

class IconRow extends StatelessWidget {
  String? userId;
  String eAId;
  bool? isLiked;

  // TODO include share image to share, change share Image to Othia logo
  String shareImage = '8063ce0b-3645-4fcb-8445-f9ea23243e16.jpg';

  IconRow({super.key, this.userId, required this.eAId, this.isLiked}) {}

  @override
  Widget build(BuildContext context) {
    // Image image = getAssetImage(shareImage);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const BackButton(),
        ),
        // when clicking of favourite, business logic must define to add that event
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Icon(
                Icons.share,
              ),
              onPressed: () {
                final String shareLink = eAShareLinkBuilder(eAId);

                Share.share(
                    '${AppLocalizations.of(context)!.shareMessage} $shareLink');
              },
            ),
            AddLikeButton(context: context, eAId: eAId),
          ],
        )
      ],
    );
  }
}

class ImageCarousel extends StatelessWidget {
  final List<String>? pictures;
  final String categoryId;

  const ImageCarousel(
      {super.key, required this.pictures, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    List images = [];
    if (pictures != null) {
      pictures!.forEach((element) {
        images.add(getPhotoNullSave(categoryId: categoryId, photo: element));
      });
    } else {
      images.add(getPhotoNullSave(categoryId: categoryId));
    }
    return Container(
      // height of picture
      height: 245.h,
      width: double.infinity,
      //decoration: BoxDecoration(
      //borderRadius:
      // radius of the picture
      //BorderRadius.vertical(bottom: Radius.circular(22.h)),
      //image: DecorationImage(
      // image: AssetImage(
      //    "${Constant.assetImagePath}white.jpg"),
      //fit: BoxFit.fill)),
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        child: PictureCarousel(
            images: getFilteredImages(unfilteredImages: images)),
      ),
    );
  }
}

class HTMLAttributions extends StatelessWidget {
  final String htmlAttributions;

  const HTMLAttributions({super.key, required this.htmlAttributions});

  @override
  Widget build(BuildContext context) {
    return getSection(
        context: context,
        caption: AppLocalizations.of(context)!.attributions,
        contentWidget: Html(
          data: htmlAttributions,
        ));
  }
}

class DescriptionWidget extends StatelessWidget {
  String description;

  DescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return getSection(
        context: context,
        caption: AppLocalizations.of(context)!.description,
        contentWidget: getMultilineCustomFontRestricted(
            textTheme: Theme.of(context).textTheme.headlineSmall,
            text: description,
            maxLines: 3));
  }
}