import 'package:flutter/material.dart';

import '../../../config/themes/color_data.dart';
import '../../../utils/ui/ui_utils.dart';

Widget getHeader({required final String text}) {
  return Container(
    color: lightGrey.withOpacity(0.8),
    child: Column(
      children: [
        getVerSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getCustomFont(
              text: text,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
        getVerSpace(8),
      ],
    ),
  );
}
