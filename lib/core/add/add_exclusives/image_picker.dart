import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/constants/categories.dart';
import 'package:othia/utils/services/data_handling/data_handling.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class EAImagePicker extends StatelessWidget {
  AddEANotifier inputNotifier;

  EAImagePicker(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return Column(
        children: [
          GestureDetector(
            onTap: () async {
              String? path = await getFromGallery();
              if (path != null) {
                final bytes = File(path).readAsBytesSync();
                final userProvidedImage = base64Encode(bytes);
                inputNotifierConsumer.image = userProvidedImage;
                inputNotifierConsumer.copyRightVerified = false;
                inputNotifierConsumer.notifyListeners();
              }
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                    height: 230.h,
                    width: 400.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.h)),
                      image: DecorationImage(
                        image: getPhotoNullSave(
                            categoryId: inputNotifierConsumer
                                        .detailedEA.categoryId ??
                                    Categories.diverse,
                                photo: inputNotifierConsumer.image)
                            .image,
                        fit: BoxFit.cover,
                      ),
                    )),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 150.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(10.h)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            inputNotifierConsumer.image == null
                                ? AppLocalizations.of(context)!.imageDefaultHint
                                : AppLocalizations.of(context)!.changeImageHint,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          if (inputNotifierConsumer.image != null)
            getImagePickerHelpers(inputNotifierConsumer, context),
        ],
      );
    });
  }

  Column getImagePickerHelpers(
      AddEANotifier inputNotifierConsumer, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: GestureDetector(
              onTap: () {
                inputNotifierConsumer.image = null;
                inputNotifierConsumer.notifyListeners();
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.backToDefaultImage,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  getHorSpace(5.h),
                  Icon(Icons.close)
                ],
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.imageRightsText),
            Switch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: inputNotifierConsumer.copyRightVerified,
              onChanged: (hasPermissions) {
                inputNotifierConsumer.copyRightVerified = hasPermissions;
                if (hasPermissions)
                  inputNotifier.showCopyrightErrorMessage = false;
                inputNotifier.notifyListeners();
              },
            ),
          ],
        ),
        if (inputNotifierConsumer.showCopyrightErrorMessage)
          Text(
            AppLocalizations.of(context)!.imageRightsErrorMessage,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          )
      ],
    );
  }
}
