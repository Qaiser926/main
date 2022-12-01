import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/ui/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(_url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class PriceWidget extends StatelessWidget {
  final int type;
  final double price;

  const PriceWidget({super.key, required this.type, required this.price});

  // idea is to state the price information if exists and return a clickable Button in case a ticket link exists as well

  @override
  Widget build(BuildContext context) {
    if (this.type == 1) {
      // change uri in functionsArgument if needed
      //TODO
      return
          // need to round prices if range
          // also include "ab" if only one price --> lowerText has to be dynamically given
          // if clicked on ticket link, add event to favourites
          PriceButton(
              textUpper: "Tickets",
              textLower: "102€-200€",
              function: _launchUrl,
              fontsize: 14.sp,
              weight: FontWeight.w700,
              buttonHeight: 45.h,
              buttonWidth: 76.h,
              functionArguments: Uri.parse('https://flutter.dev'));
    } else {
      return Row(
        children: [
          Icon(
            Icons.euro_symbol,
            size: 20.h,
            color: Colors.grey,
          ),
          getHorSpace(5.h),
          getCustomFont(
            text: "ab $price€",
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          )
        ],
      );
    }
  }
}

class PriceButton extends StatelessWidget {
  String textUpper;
  String textLower;
  Function function;
  double fontsize;
  EdgeInsetsGeometry? insetsGeometry;
  FontWeight weight;
  var functionArguments;
  double? buttonHeight;
  double? buttonWidth;
  EdgeInsetsGeometry? insetsGeometrypadding;

  PriceButton(
      {required this.textUpper,
      required this.textLower,
      required this.function,
      required this.fontsize,
      super.key,
      this.insetsGeometry,
      this.weight = FontWeight.bold,
      this.buttonHeight,
      this.buttonWidth,
      this.insetsGeometrypadding,
      var this.functionArguments});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // TODO add to favourites
          function(functionArguments);
        },
        child: Container(
          margin: insetsGeometry,
          padding: insetsGeometrypadding,
          width: buttonWidth,
          height: buttonHeight,
          // decoration: getButtonDecoration(
          //   bgColor,
          //   borderRadius: borderRadius,
          //   shadow: boxShadow,
          //   border: (isBorder)
          //       ? Border.all(color: borderColor, width: borderWidth!)
          //       : null,
          // ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      textUpper,
                      style: TextStyle(fontSize: fontsize, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      textLower,
                      style: TextStyle(fontSize: fontsize, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ))
                  ],
                )
              ]),
        ));
  }
}
