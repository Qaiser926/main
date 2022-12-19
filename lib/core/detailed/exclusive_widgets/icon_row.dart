import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/ui/ui_utils.dart';

class IconRow extends StatelessWidget {
  String? userId;
  String eAId;
  bool? isLiked;
  var appDocDir;
  String objectUrl = 'https://example.com';

  // TODO define if URL is built or directly sent & initial status of liked button + update of button & share Image as Othia image
  String shareImage = '8063ce0b-3645-4fcb-8445-f9ea23243e16.jpg';

  IconRow({super.key, this.userId, required this.eAId, this.isLiked}) {}

  @override
  Widget build(BuildContext context) {
    Image image = getAssetImage(shareImage) as Image;
    // define if Like button exists
    List<Widget> buttonsOnRightSide = [
      TextButton(
        child: const Icon(
          Icons.share,
        ),
        onPressed: () {
          Share.share(
              '${AppLocalizations.of(context)!.shareMessage} $objectUrl');
        },
      ),
    ];
    if (userId != null) {
      buttonsOnRightSide.add(getHorSpace(15.h));
      buttonsOnRightSide.add(
        AddLikeButton(context: context, eAId: eAId),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO include share button and make heart coloured
        GestureDetector(
          onTap: () {
            // should bring back to previous screen
            Navigator.of(context).pop();
          },
          child: const BackButton(),
        ),
        // when clicking of favourite, business logic must define to add that event
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttonsOnRightSide,
        )
      ],
    );
  }
}
