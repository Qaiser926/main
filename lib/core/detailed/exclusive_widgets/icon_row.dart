import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:othia/widgets/action_buttons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/helpers/builders.dart';

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
