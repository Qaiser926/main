import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/favourites/exclusive_widgets/pinned_header.dart';
import 'package:othia/utils/ui/ui_utils.dart';

class EmptyFavourite extends StatelessWidget {
  final String noElementsText;

  const EmptyFavourite({super.key, required this.noElementsText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [getVerSpace(20.h), getHeader(text: noElementsText)],
    );
  }
}
