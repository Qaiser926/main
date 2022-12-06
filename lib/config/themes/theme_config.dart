import 'package:flutter/material.dart';
import 'package:othia/config/themes/dark_theme.dart';

ThemeData getCurrentDefaultTheme(){
  //TODO determine whether the user curerently selected light or dark mode
  return getDarkThemeData();
}