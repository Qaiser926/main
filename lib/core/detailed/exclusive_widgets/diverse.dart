import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/utils/helpers/diverse.dart';
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
          getVerSpace(15),
          Text(
            caption,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          getVerSpace(15),
          contentWidget,
          getVerSpace(15.h),
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
  String eAId;

  IconRow({super.key, required this.eAId}) {}

  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
              onTap: () {
                final String shareLink = eAShareLinkBuilder(eAId);
                openShare(
                    '${AppLocalizations.of(context)!.shareMessage} $shareLink',
                    context);
                    },
              child: const Icon(
                Icons.share,
              ),
            ),
            getHorSpace(20.h),
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
    if (pictures != null ? pictures!.isNotEmpty : false) {
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
