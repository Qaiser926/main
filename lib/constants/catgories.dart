import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/ui/ui_utils.dart';

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

class Categories {
  static ClipRRect getRoundedImage(Image image) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Image(
        image: image.image,
        fit: BoxFit.cover,
        width: 610.h,
        height: 800.h,
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
