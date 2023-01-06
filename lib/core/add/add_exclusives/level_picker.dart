import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:othia/core/add/add_exclusives/help_functions.dart';
import 'package:othia/utils/ui/ui_utils.dart';
import 'package:provider/provider.dart';

import 'input_notifier.dart';

class LevelPicker extends StatelessWidget {
  AddEANotifier inputNotifier;

  LevelPicker(this.inputNotifier);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEANotifier>(
        builder: (context, inputNotifierConsumer, child) {
      return Column(children: [
        // TODO transform code such that it is less repetitive
        // TODO align distances such that it becomes clearer to which slider the reset belongs
        buildSlider(
            sliderValue: transformIntToSlider(
                inputNotifierConsumer.socialLevel, LevelType.socialLevel),
            caption: AppLocalizations.of(context)!.socialLevel,
            onChanged: (double sliderInput) {
              inputNotifier.socialLevel =
                  transformSliderValueToInt(sliderInput, LevelType.socialLevel);
              inputNotifier.socialLevelActivated = true;
              inputNotifier.notifyListeners();
            },
            context: context,
            levelType: LevelType.socialLevel,
            infoText: AppLocalizations.of(context)!.socialLevelInfo,
            resetFunction: () {
              inputNotifier.socialLevelActivated = false;
              inputNotifier.socialLevel = 0;
              inputNotifier.notifyListeners();
            },
            sliderActivated: inputNotifierConsumer.socialLevelActivated),
        buildSlider(
            sliderValue: transformIntToSlider(
                inputNotifierConsumer.physicalLevel, LevelType.physicalLevel),
            caption: AppLocalizations.of(context)!.socialLevel,
            onChanged: (double sliderInput) {
              inputNotifier.physicalLevel = transformSliderValueToInt(
                  sliderInput, LevelType.physicalLevel);
              inputNotifier.physicalLevelActivated = true;
              inputNotifier.notifyListeners();
            },
            context: context,
            levelType: LevelType.physicalLevel,
            infoText: AppLocalizations.of(context)!.physicalLevelInfo,
            resetFunction: () {
              inputNotifier.physicalLevelActivated = false;
              inputNotifier.physicalLevel = 0;
              inputNotifier.notifyListeners();
            },
            sliderActivated: inputNotifierConsumer.physicalLevelActivated),
        buildSlider(
            sliderValue: transformIntToSlider(
                inputNotifierConsumer.cognitiveLevel, LevelType.cognitiveLevel),
            caption: AppLocalizations.of(context)!.cognitiveLevel,
            onChanged: (double sliderInput) {
              inputNotifier.cognitiveLevel = transformSliderValueToInt(
                  sliderInput, LevelType.cognitiveLevel);
              inputNotifier.cognitiveLevelActivated = true;
              inputNotifier.notifyListeners();
            },
            context: context,
            levelType: LevelType.cognitiveLevel,
            infoText: AppLocalizations.of(context)!.cognitiveLevelInfo,
            resetFunction: () {
              inputNotifier.cognitiveLevelActivated = false;
              inputNotifier.cognitiveLevel = 0;
              inputNotifier.notifyListeners();
            },
            sliderActivated: inputNotifierConsumer.cognitiveLevelActivated),
        buildSlider(
            sliderValue: transformIntToSlider(
                inputNotifierConsumer.singlePersonEligibility,
                LevelType.personEligibility),
            caption: AppLocalizations.of(context)!.singlePersonEligibility,
            onChanged: (double sliderInput) {
              inputNotifier.singlePersonEligibility = transformSliderValueToInt(
                  sliderInput, LevelType.personEligibility);
              inputNotifier.singlePersonEligibilityActivated = true;
              inputNotifier.notifyListeners();
            },
            context: context,
            levelType: LevelType.personEligibility,
            infoText: AppLocalizations.of(context)!.singlePersonEligibilityInfo,
            resetFunction: () {
              inputNotifier.singlePersonEligibilityActivated = false;
              inputNotifier.singlePersonEligibility = 0;
              inputNotifier.notifyListeners();
            },
            sliderActivated:
                inputNotifierConsumer.singlePersonEligibilityActivated),
        buildSlider(
            sliderValue: transformIntToSlider(
                inputNotifierConsumer.coupleEligibility,
                LevelType.personEligibility),
            caption: AppLocalizations.of(context)!.coupleEligibility,
            onChanged: (double sliderInput) {
              inputNotifier.coupleEligibility = transformSliderValueToInt(
                  sliderInput, LevelType.personEligibility);
              inputNotifier.coupleEligibilityActivated = true;
              inputNotifier.notifyListeners();
            },
            context: context,
            levelType: LevelType.personEligibility,
            infoText: AppLocalizations.of(context)!.coupleEligibilityInfo,
            resetFunction: () {
              inputNotifier.coupleEligibilityActivated = false;
              inputNotifier.coupleEligibility = 0;
              inputNotifier.notifyListeners();
            },
            sliderActivated: inputNotifierConsumer.coupleEligibilityActivated),
        buildSlider(
            sliderValue: transformIntToSlider(
                inputNotifierConsumer.friendGroupEligibility,
                LevelType.personEligibility),
            caption: AppLocalizations.of(context)!.friendGroupEligibility,
            onChanged: (double sliderInput) {
              inputNotifier.friendGroupEligibility = transformSliderValueToInt(
                  sliderInput, LevelType.personEligibility);
              inputNotifier.friendGroupEligibilityActivated = true;
              inputNotifier.notifyListeners();
            },
            context: context,
            levelType: LevelType.personEligibility,
            infoText: AppLocalizations.of(context)!.friendGroupEligibilityInfo,
            resetFunction: () {
              inputNotifier.friendGroupEligibilityActivated = false;
              inputNotifier.friendGroupEligibility = 0;
              inputNotifier.notifyListeners();
            },
            sliderActivated:
                inputNotifierConsumer.friendGroupEligibilityActivated),
        buildSlider(
            sliderValue: transformIntToSlider(
                inputNotifierConsumer.professionalEligibility,
                LevelType.personEligibility),
            caption: AppLocalizations.of(context)!.professionalEligibility,
            onChanged: (double sliderInput) {
              inputNotifier.professionalEligibility = transformSliderValueToInt(
                  sliderInput, LevelType.personEligibility);
              inputNotifier.professionalEligibilityActivated = true;
              inputNotifier.notifyListeners();
            },
            context: context,
            levelType: LevelType.personEligibility,
            infoText: AppLocalizations.of(context)!.professionalEligibilityInfo,
            resetFunction: () {
              inputNotifier.professionalEligibilityActivated = false;
              inputNotifier.professionalEligibility = 0;
              inputNotifier.notifyListeners();
            },
            sliderActivated:
                inputNotifierConsumer.professionalEligibilityActivated),
      ]);
    });
  }

  Widget buildSlider(
      {required double sliderValue,
      required String caption,
      required Function(double) onChanged,
      required BuildContext context,
      required LevelType levelType,
      required String infoText,
      required Function() resetFunction,
      required bool sliderActivated}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              getInfoDialog(info: infoText, context: context);
            },
            child: Row(
              children: [
                Text(caption),
                getHorSpace(5.h),
                Icon(Icons.info_outline)
              ],
            ),
          ),
          Slider(
            thumbColor: sliderActivated ? null : Theme.of(context).cardColor,
            divisions: levelType == LevelType.personEligibility ? 3 : 4,
            value: sliderValue,
            onChanged: onChanged,
            label:
                "${getSliderHint(level: transformSliderValueToInt(sliderValue, levelType), levelType: levelType, context: context)}",
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: resetFunction,
                    child: Row(
                      children: [
                        Text(
                          "Reset Slider",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        getHorSpace(5.h),
                        Icon(Icons.close)
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  int transformSliderValueToInt(double sliderValue, LevelType levelType) {
    if (levelType == LevelType.personEligibility)
      return (sliderValue * 3).toInt();
    return (sliderValue * 4).toInt();
  }

  double transformIntToSlider(int level, LevelType levelType) {
    if (levelType == LevelType.personEligibility) return level / 3;
    return level / 4;
  }
}

enum LevelType { cognitiveLevel, socialLevel, physicalLevel, personEligibility }

String getSliderHint(
    {required int level,
    required LevelType levelType,
    required BuildContext context}) {
  Map<LevelType, Map<int, String>> levelTypeHints = {
    LevelType.cognitiveLevel: {
      0: AppLocalizations.of(context)!.cognitiveLevelZero,
      1: AppLocalizations.of(context)!.cognitiveLevelOne,
      2: AppLocalizations.of(context)!.cognitiveLevelTwo,
      3: AppLocalizations.of(context)!.cognitiveLevelThree,
      4: AppLocalizations.of(context)!.cognitiveLevelFour
    },
    LevelType.socialLevel: {
      0: AppLocalizations.of(context)!.socialLevelZero,
      1: AppLocalizations.of(context)!.socialLevelOne,
      2: AppLocalizations.of(context)!.socialLevelTwo,
      3: AppLocalizations.of(context)!.socialLevelThree,
      4: AppLocalizations.of(context)!.socialLevelFour
    },
    LevelType.physicalLevel: {
      0: AppLocalizations.of(context)!.physicalLevelZero,
      1: AppLocalizations.of(context)!.physicalLevelOne,
      2: AppLocalizations.of(context)!.physicalLevelTwo,
      3: AppLocalizations.of(context)!.physicalLevelThree,
      4: AppLocalizations.of(context)!.physicalLevelFour
    },
    LevelType.personEligibility: {
      0: AppLocalizations.of(context)!.personEligibilityZero,
      1: AppLocalizations.of(context)!.personEligibilityOne,
      2: AppLocalizations.of(context)!.personEligibilityTwo,
      3: AppLocalizations.of(context)!.personEligibilityThree,
    },
  };
  return levelTypeHints[levelType]![level]!;
}
