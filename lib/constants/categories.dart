import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/ui/ui_utils.dart';
import 'app_constants.dart';

final Map<String, List<String>> categoryIdToSubcategoryIds = {
  Categories.entertainment: Subcategories.entertainment,
  Categories.nightlife: Subcategories.nightlife,
  Categories.food: Subcategories.food,
  Categories.sport: Subcategories.sport,
  Categories.wellness: Subcategories.wellness,
  Categories.attraction: Subcategories.attraction,
  Categories.culture: Subcategories.culture,
  Categories.students: Subcategories.students,
  Categories.exhibition: Subcategories.exhibition,
  Categories.diverse: Subcategories.diverse
};

String? mapSubcategoryToCategory({required String subCategoryId}) {
  for (var categoryId in categoryIdToSubcategoryIds.keys) {
    for (var i = 0; i < categoryIdToSubcategoryIds[categoryId]!.length; i++) {
      if (subCategoryId == categoryIdToSubcategoryIds[categoryId]![i]) {
        return categoryId;
      }
    }
  }
}

class Categories {
  static final Categories _singleton = Categories._internal();

  factory Categories() {
    return _singleton;
  }

  Categories._internal();

  static ClipRRect getRoundedImage(Image image) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30),
      child: Image(
        image: image.image,
        fit: BoxFit.cover,
        height: WidgetConstants.categoryGridItemHeight,
      ),
    );
  }

  static final Map<String, ClipRRect> categoryRoundedImagesMap = {
    entertainment: entertainmentRoundedImage,
    nightlife: nightlifeRoundedImage,
    food: foodRoundedImage,
    sport: sportRoundedImage,
    wellness: wellnessRoundedImage,
    attraction: attractionRoundedImage,
    culture: cultureRoundedImage,
    students: studentsRoundedImage,
    exhibition: exhibitionRoundedImage,
    diverse: diverseRoundedImage,
  };

  static final ClipRRect entertainmentRoundedImage =
      getRoundedImage(entertainmentImage);
  static final ClipRRect nightlifeRoundedImage =
      getRoundedImage(nightlifeImage);
  static final ClipRRect foodRoundedImage = getRoundedImage(foodImage);
  static final ClipRRect sportRoundedImage = getRoundedImage(sportImage);
  static final ClipRRect wellnessRoundedImage = getRoundedImage(wellnessImage);
  static final ClipRRect attractionRoundedImage =
      getRoundedImage(attractionImage);
  static final ClipRRect cultureRoundedImage = getRoundedImage(cultureImage);
  static final ClipRRect studentsRoundedImage = getRoundedImage(studentImage);
  static final ClipRRect exhibitionRoundedImage =
      getRoundedImage(exhibitionImage);
  static final ClipRRect diverseRoundedImage = getRoundedImage(diverseImage);

  static final Image entertainmentImage = getAssetImage("$entertainment.jpg");
  static final Image nightlifeImage = getAssetImage("$nightlife.jpg");
  static final Image foodImage = getAssetImage("$food.jpg");
  static final Image sportImage = getAssetImage("$sport.jpg");
  static final Image wellnessImage = getAssetImage("$wellness.jpg");
  static final Image attractionImage = getAssetImage("$attraction.jpg");
  static final Image cultureImage = getAssetImage("$culture.jpg");
  static final Image studentImage = getAssetImage("$students.jpg");
  static final Image exhibitionImage = getAssetImage("$exhibition.jpg");
  static final Image diverseImage = getAssetImage("$diverse.jpg");

  static const String entertainment = "d8b2b112-90ff-4783-b562-bc41837c8153";
  static const String nightlife = "2bc36408-c831-4b4e-ab6d-eb608512862d";
  static const String food = "f5089e0d-8a79-45ea-9047-ce77924f40cf";
  static const String sport = "697c3db2-099d-457a-beca-27c1858a3c03";
  static const String wellness = "afb7291a-197c-403a-b985-979eecbfcafe";
  static const String attraction = "c1fc2f91-1b2a-42d0-8697-b8a7abbbe5be";
  static const String culture = "62580b99-963c-4671-b58e-a2f516832c87";
  static const String students = "88840e73-f0be-41f4-aee2-0cbf23440c33";
  static const String exhibition = "31114724-85c0-49d4-997f-1166e0490452";
  static const String diverse = "ccc61d69-6aa8-4f5e-a0c2-c79072c46dcb";

  static const List<String> categoryIds = [
    entertainment,
    nightlife,
    food,
    sport,
    wellness,
    attraction,
    culture,
    students,
    exhibition,
    diverse
  ];
}

class Subcategories {
  static final Subcategories _singleton = Subcategories._internal();

  factory Subcategories() {
    return _singleton;
  }

  Subcategories._internal();

  static const List<String> diverse = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e85",
    "8063ce0b-3645-4fcb-8445-f9ea23243e87",
    "8063ce0b-3645-4fcb-8445-f9ea23243e88",
    "8063ce0b-3645-4fcb-8445-f9ea23243e89",
  ];
  static const List<String> entertainment = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e15",
    "8063ce0b-3645-4fcb-8445-f9ea23243e16",
    "8063ce0b-3645-4fcb-8445-f9ea23243e17",
    "8063ce0b-3645-4fcb-8445-f9ea23243e18",
    "8063ce0b-3645-4fcb-8445-f9ea23243e19",
    "8063ce0b-3645-4fcb-8445-f9ea23243e20",
    "8063ce0b-3645-4fcb-8445-f9ea23243e21",
    "8063ce0b-3645-4fcb-8445-f9ea23243e22",
    "8063ce0b-3645-4fcb-8445-f9ea23243e23",
    "8063ce0b-3645-4fcb-8445-f9ea23243e24",
    "8063ce0b-3645-4fcb-8445-f9ea23243e25",
  ];
  static const List<String> nightlife = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e26",
    "8063ce0b-3645-4fcb-8445-f9ea23243e27",
    "8063ce0b-3645-4fcb-8445-f9ea23243e28",
    "8063ce0b-3645-4fcb-8445-f9ea23243e29",
    "8063ce0b-3645-4fcb-8445-f9ea23243e30",
    "8063ce0b-3645-4fcb-8445-f9ea23243e31",
    "8063ce0b-3645-4fcb-8445-f9ea23243e32",
    "8063ce0b-3645-4fcb-8445-f9ea23243e33",
  ];
  static const List<String> sport = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e34",
    "8063ce0b-3645-4fcb-8445-f9ea23243e35",
    "8063ce0b-3645-4fcb-8445-f9ea23243e36",
    "8063ce0b-3645-4fcb-8445-f9ea23243e37",
    "8063ce0b-3645-4fcb-8445-f9ea23243e38",
    "8063ce0b-3645-4fcb-8445-f9ea23243e39",
  ];
  static const List<String> attraction = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e40",
    "8063ce0b-3645-4fcb-8445-f9ea23243e42",
    "8063ce0b-3645-4fcb-8445-f9ea23243e43",
    "8063ce0b-3645-4fcb-8445-f9ea23243e44",
  ];
  static const List<String> wellness = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e45",
    "8063ce0b-3645-4fcb-8445-f9ea23243e46",
    "8063ce0b-3645-4fcb-8445-f9ea23243e47",
    "8063ce0b-3645-4fcb-8445-f9ea23243e48",
    "8063ce0b-3645-4fcb-8445-f9ea23243e49",
    "8063ce0b-3645-4fcb-8445-f9ea23243e50",
    "8063ce0b-3645-4fcb-8445-f9ea23243e51",
  ];
  static const List<String> food = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e52",
    "8063ce0b-3645-4fcb-8445-f9ea23243e53",
    "8063ce0b-3645-4fcb-8445-f9ea23243e54",
    "8063ce0b-3645-4fcb-8445-f9ea23243e55",
    "8063ce0b-3645-4fcb-8445-f9ea23243e56",
    "8063ce0b-3645-4fcb-8445-f9ea23243e57",
    "8063ce0b-3645-4fcb-8445-f9ea23243e58",
  ];
  static const List<String> culture = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e59",
    "8063ce0b-3645-4fcb-8445-f9ea23243e60",
    "8063ce0b-3645-4fcb-8445-f9ea23243e61",
    "8063ce0b-3645-4fcb-8445-f9ea23243e62",
    "8063ce0b-3645-4fcb-8445-f9ea23243e63",
    "8063ce0b-3645-4fcb-8445-f9ea23243e78",
    "8063ce0b-3645-4fcb-8445-f9ea23243e79",
    "8063ce0b-3645-4fcb-8445-f9ea23243e64",
    "8063ce0b-3645-4fcb-8445-f9ea23243e65",
    "8063ce0b-3645-4fcb-8445-f9ea23243e66",
  ];
  static const List<String> students = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e67",
    "8063ce0b-3645-4fcb-8445-f9ea23243e68",
    "8063ce0b-3645-4fcb-8445-f9ea23243e69",
    "8063ce0b-3645-4fcb-8445-f9ea23243e70",
    "8063ce0b-3645-4fcb-8445-f9ea23243e71",
  ];
  static const List<String> exhibition = [
    "8063ce0b-3645-4fcb-8445-f9ea23243e72",
    "8063ce0b-3645-4fcb-8445-f9ea23243e73",
    "8063ce0b-3645-4fcb-8445-f9ea23243e74",
    "8063ce0b-3645-4fcb-8445-f9ea23243e75",
    "8063ce0b-3645-4fcb-8445-f9ea23243e76",
    "8063ce0b-3645-4fcb-8445-f9ea23243e77",
    "8063ce0b-3645-4fcb-8445-f9ea23243e80",
    "8063ce0b-3645-4fcb-8445-f9ea23243e81",
    "8063ce0b-3645-4fcb-8445-f9ea23243e82",
    "8063ce0b-3645-4fcb-8445-f9ea23243e83",
    "8063ce0b-3645-4fcb-8445-f9ea23243e84",
  ];
}

class CategoryIdToI18nMapper {
  static String getCategorySubcategoryName(BuildContext context, String id) {
    switch (id) {
      case "d8b2b112-90ff-4783-b562-bc41837c8153":
        {
          return AppLocalizations.of(context)!.entertainment;
        }
        break;
      case "2bc36408-c831-4b4e-ab6d-eb608512862d":
        {
          return AppLocalizations.of(context)!.nightlife;
        }
        break;
      case "f5089e0d-8a79-45ea-9047-ce77924f40cf":
        {
          return AppLocalizations.of(context)!.food;
        }
        break;
      case "697c3db2-099d-457a-beca-27c1858a3c03":
        {
          return AppLocalizations.of(context)!.sport;
        }
        break;
      case "afb7291a-197c-403a-b985-979eecbfcafe":
        {
          return AppLocalizations.of(context)!.wellness;
        }
        break;
      case "c1fc2f91-1b2a-42d0-8697-b8a7abbbe5be":
        {
          return AppLocalizations.of(context)!.attractionTours;
        }
        break;
      case "62580b99-963c-4671-b58e-a2f516832c87":
        {
          return AppLocalizations.of(context)!.culture;
        }
        break;
      case "88840e73-f0be-41f4-aee2-0cbf23440c33":
        {
          return AppLocalizations.of(context)!.studentsFamily;
        }
        break;
      case "31114724-85c0-49d4-997f-1166e0490452":
        {
          return AppLocalizations.of(context)!.exhibition;
        }
        break;
      case "ccc61d69-6aa8-4f5e-a0c2-c79072c46dcb":
        {
          return AppLocalizations.of(context)!.diverse;
        }
        break;

      case "8063ce0b-3645-4fcb-8445-f9ea23243e15":
        {
          return AppLocalizations.of(context)!.comedyCabaret;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e16":
        {
          return AppLocalizations.of(context)!.musicConcert;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e17":
        {
          return AppLocalizations.of(context)!.moviePlanetarium;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e18":
        {
          return AppLocalizations.of(context)!.musicFestival;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e19":
        {
          return AppLocalizations.of(context)!.musical;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e20":
        {
          return AppLocalizations.of(context)!.entertainmentShow;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e21":
        {
          return AppLocalizations.of(context)!.circus;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e22":
        {
          return AppLocalizations.of(context)!.fairAmusementPark;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e23":
        {
          return AppLocalizations.of(context)!.gaming;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e24":
        {
          return AppLocalizations.of(context)!.carnival;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e25":
        {
          return AppLocalizations.of(context)!.otherEntertainment;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e26":
        {
          return AppLocalizations.of(context)!.rave;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e27":
        {
          return AppLocalizations.of(context)!.chartsParty;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e28":
        {
          return AppLocalizations.of(context)!.hipHopParty;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e29":
        {
          return AppLocalizations.of(context)!.party;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e30":
        {
          return AppLocalizations.of(context)!.lgbtq;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e31":
        {
          return AppLocalizations.of(context)!.karaoke;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e32":
        {
          return AppLocalizations.of(context)!.cocktailsDrinks;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e33":
        {
          return AppLocalizations.of(context)!.otherNightlifeClubs;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e34":
        {
          return AppLocalizations.of(context)!.fitness;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e35":
        {
          return AppLocalizations.of(context)!.outdoor;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e36":
        {
          return AppLocalizations.of(context)!.sportEvent;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e37":
        {
          return AppLocalizations.of(context)!.funActivities;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e38":
        {
          return AppLocalizations.of(context)!.dancing;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e39":
        {
          return AppLocalizations.of(context)!.otherSportFun;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e40":
        {
          return AppLocalizations.of(context)!.tripSightseeing;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e42":
        {
          return AppLocalizations.of(context)!.aquariumZoo;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e43":
        {
          return AppLocalizations.of(context)!.attraction;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e44":
        {
          return AppLocalizations.of(context)!.otherAttractionToursTrips;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e45":
        {
          return AppLocalizations.of(context)!.health;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e46":
        {
          return AppLocalizations.of(context)!.spiruality;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e47":
        {
          return AppLocalizations.of(context)!.beauty;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e48":
        {
          return AppLocalizations.of(context)!.fashion;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e49":
        {
          return AppLocalizations.of(context)!.yoga;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e50":
        {
          return AppLocalizations.of(context)!.wellnessSpa;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e51":
        {
          return AppLocalizations.of(context)!.otherRetreatWellness;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e52":
        {
          return AppLocalizations.of(context)!.streetFood;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e53":
        {
          return AppLocalizations.of(context)!.popUpRestaurant;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e54":
        {
          return AppLocalizations.of(context)!.cafe;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e55":
        {
          return AppLocalizations.of(context)!.restaurant;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e56":
        {
          return AppLocalizations.of(context)!.tasting;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e57":
        {
          return AppLocalizations.of(context)!.foodFestival;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e58":
        {
          return AppLocalizations.of(context)!.otherFoodTasting;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e59":
        {
          return AppLocalizations.of(context)!.operaOperetta;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e60":
        {
          return AppLocalizations.of(context)!.classicConcert;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e61":
        {
          return AppLocalizations.of(context)!.theatre;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e62":
        {
          return AppLocalizations.of(context)!.reading;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e63":
        {
          return AppLocalizations.of(context)!.poetrySlam;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e78":
        {
          return AppLocalizations.of(context)!.artExhibitionGallery;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e79":
        {
          return AppLocalizations.of(context)!.museum;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e64":
        {
          return AppLocalizations.of(context)!.danceBallet;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e65":
        {
          return AppLocalizations.of(context)!.cultureFestival;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e66":
        {
          return AppLocalizations.of(context)!.otherCulturePerformingArt;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e67":
        {
          return AppLocalizations.of(context)!.students;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e68":
        {
          return AppLocalizations.of(context)!.family;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e69":
        {
          return AppLocalizations.of(context)!.kids;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e70":
        {
          return AppLocalizations.of(context)!.couples;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e71":
        {
          return AppLocalizations.of(context)!.otherStudentsFamilyCouples;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e72":
        {
          return AppLocalizations.of(context)!.massReligiousHappenings;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e73":
        {
          return AppLocalizations.of(context)!.politics;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e74":
        {
          return AppLocalizations.of(context)!.communityEvent;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e75":
        {
          return AppLocalizations.of(context)!.workshop;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e76":
        {
          return AppLocalizations.of(context)!.weeklyMarket;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e77":
        {
          return AppLocalizations.of(context)!.fleaMarket;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e80":
        {
          return AppLocalizations.of(context)!.talk;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e81":
        {
          return AppLocalizations.of(context)!.conferencesCareerEvents;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e82":
        {
          return AppLocalizations.of(context)!.charity;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e83":
        {
          return AppLocalizations.of(context)!.garden;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e84":
        {
          return AppLocalizations.of(context)!.otherCommunityWorkshops;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e85":
        {
          return AppLocalizations.of(context)!.dating;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e87":
        {
          return AppLocalizations.of(context)!.shopping;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e88":
        {
          return AppLocalizations.of(context)!.home;
        }
        break;
      case "8063ce0b-3645-4fcb-8445-f9ea23243e89":
        {
          return AppLocalizations.of(context)!.otherDiverse;
        }
        break;
      default:
        {
          return "error";
        }
        break;
    }
  }

  static const Map<String, String> map = {
    "d8b2b112-90ff-4783-b562-bc41837c8153": "entertainment",
    "2bc36408-c831-4b4e-ab6d-eb608512862d": "nightlife",
    "f5089e0d-8a79-45ea-9047-ce77924f40cf": "food",
    "697c3db2-099d-457a-beca-27c1858a3c03": "sport",
    "afb7291a-197c-403a-b985-979eecbfcafe": "wellness",
    "c1fc2f91-1b2a-42d0-8697-b8a7abbbe5be": "attractionTours",
    "62580b99-963c-4671-b58e-a2f516832c87": "culture",
    "88840e73-f0be-41f4-aee2-0cbf23440c33": "studentsFamily",
    "31114724-85c0-49d4-997f-1166e0490452": "exhibition",
    "ccc61d69-6aa8-4f5e-a0c2-c79072c46dcb": "diverse",
    "8063ce0b-3645-4fcb-8445-f9ea23243e85": "comedyCabaret",
    "8063ce0b-3645-4fcb-8445-f9ea23243e87": "musicConcert",
    "8063ce0b-3645-4fcb-8445-f9ea23243e88": "moviePlanetarium",
    "8063ce0b-3645-4fcb-8445-f9ea23243e89": "musicFestival",
    "8063ce0b-3645-4fcb-8445-f9ea23243e15": "musical",
    "8063ce0b-3645-4fcb-8445-f9ea23243e16": "entertainmentShow",
    "8063ce0b-3645-4fcb-8445-f9ea23243e17": "circus",
    "8063ce0b-3645-4fcb-8445-f9ea23243e18": "fairAmusementPark",
    "8063ce0b-3645-4fcb-8445-f9ea23243e19": "gaming",
    "8063ce0b-3645-4fcb-8445-f9ea23243e20": "carnival",
    "8063ce0b-3645-4fcb-8445-f9ea23243e21": "otherEntertainment",
    "8063ce0b-3645-4fcb-8445-f9ea23243e22": "rave",
    "8063ce0b-3645-4fcb-8445-f9ea23243e23": "chartsParty",
    "8063ce0b-3645-4fcb-8445-f9ea23243e24": "hipHopParty",
    "8063ce0b-3645-4fcb-8445-f9ea23243e25": "party",
    "8063ce0b-3645-4fcb-8445-f9ea23243e26": "lgbtq",
    "8063ce0b-3645-4fcb-8445-f9ea23243e27": "karaoke",
    "8063ce0b-3645-4fcb-8445-f9ea23243e28": "cocktailsDrinks",
    "8063ce0b-3645-4fcb-8445-f9ea23243e29": "otherNightlifeClubs",
    "8063ce0b-3645-4fcb-8445-f9ea23243e30": "fitness",
    "8063ce0b-3645-4fcb-8445-f9ea23243e31": "outdoor",
    "8063ce0b-3645-4fcb-8445-f9ea23243e32": "sportEvent",
    "8063ce0b-3645-4fcb-8445-f9ea23243e33": "funActivities",
    "8063ce0b-3645-4fcb-8445-f9ea23243e34": "dancing",
    "8063ce0b-3645-4fcb-8445-f9ea23243e35": "otherSportFun",
    "8063ce0b-3645-4fcb-8445-f9ea23243e36": "tripSightseeing",
    "8063ce0b-3645-4fcb-8445-f9ea23243e37": "aquariumZoo",
    "8063ce0b-3645-4fcb-8445-f9ea23243e38": "attraction",
    "8063ce0b-3645-4fcb-8445-f9ea23243e39": "otherAttractionToursTrips",
    "8063ce0b-3645-4fcb-8445-f9ea23243e40": "health",
    "8063ce0b-3645-4fcb-8445-f9ea23243e42": "spiruality",
    "8063ce0b-3645-4fcb-8445-f9ea23243e43": "beauty",
    "8063ce0b-3645-4fcb-8445-f9ea23243e44": "fashion",
    "8063ce0b-3645-4fcb-8445-f9ea23243e45": "yoga",
    "8063ce0b-3645-4fcb-8445-f9ea23243e46": "wellnessSpa",
    "8063ce0b-3645-4fcb-8445-f9ea23243e47": "otherRetreatWellness",
    "8063ce0b-3645-4fcb-8445-f9ea23243e48": "streetFood",
    "8063ce0b-3645-4fcb-8445-f9ea23243e49": "popUpRestaurant",
    "8063ce0b-3645-4fcb-8445-f9ea23243e50": "cafe",
    "8063ce0b-3645-4fcb-8445-f9ea23243e51": "restaurant",
    "8063ce0b-3645-4fcb-8445-f9ea23243e52": "tasting",
    "8063ce0b-3645-4fcb-8445-f9ea23243e53": "foodFestival",
    "8063ce0b-3645-4fcb-8445-f9ea23243e54": "otherFoodTasting",
    "8063ce0b-3645-4fcb-8445-f9ea23243e55": "operaOperetta",
    "8063ce0b-3645-4fcb-8445-f9ea23243e56": "classicConcert",
    "8063ce0b-3645-4fcb-8445-f9ea23243e57": "theatre",
    "8063ce0b-3645-4fcb-8445-f9ea23243e58": "reading",
    "8063ce0b-3645-4fcb-8445-f9ea23243e59": "poetrySlam",
    "8063ce0b-3645-4fcb-8445-f9ea23243e60": "artExhibitionGallery",
    "8063ce0b-3645-4fcb-8445-f9ea23243e61": "museum",
    "8063ce0b-3645-4fcb-8445-f9ea23243e62": "danceBallet",
    "8063ce0b-3645-4fcb-8445-f9ea23243e63": "cultureFestival",
    "8063ce0b-3645-4fcb-8445-f9ea23243e78": "otherCulturePerformingArt",
    "8063ce0b-3645-4fcb-8445-f9ea23243e79": "students",
    "8063ce0b-3645-4fcb-8445-f9ea23243e64": "family",
    "8063ce0b-3645-4fcb-8445-f9ea23243e65": "kids",
    "8063ce0b-3645-4fcb-8445-f9ea23243e66": "couples",
    "8063ce0b-3645-4fcb-8445-f9ea23243e67": "otherStudentsFamilyCouples",
    "8063ce0b-3645-4fcb-8445-f9ea23243e68": "massReligiousHappenings",
    "8063ce0b-3645-4fcb-8445-f9ea23243e69": "politics",
    "8063ce0b-3645-4fcb-8445-f9ea23243e70": "communityEvent",
    "8063ce0b-3645-4fcb-8445-f9ea23243e71": "workshop",
    "8063ce0b-3645-4fcb-8445-f9ea23243e72": "weeklyMarket",
    "8063ce0b-3645-4fcb-8445-f9ea23243e73": "fleaMarket",
    "8063ce0b-3645-4fcb-8445-f9ea23243e74": "talk",
    "8063ce0b-3645-4fcb-8445-f9ea23243e75": "conferencesCareerEvents",
    "8063ce0b-3645-4fcb-8445-f9ea23243e76": "charity",
    "8063ce0b-3645-4fcb-8445-f9ea23243e77": "garden",
    "8063ce0b-3645-4fcb-8445-f9ea23243e80": "otherCommunityWorkshops",
    "8063ce0b-3645-4fcb-8445-f9ea23243e81": "dating",
    "8063ce0b-3645-4fcb-8445-f9ea23243e82": "shopping",
    "8063ce0b-3645-4fcb-8445-f9ea23243e83": "home",
    "8063ce0b-3645-4fcb-8445-f9ea23243e84": "otherDiverse",
  };
}
