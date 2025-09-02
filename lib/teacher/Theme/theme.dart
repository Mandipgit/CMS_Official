import 'package:flutter/material.dart';
import 'package:official_cms/teacher/Dashhboard/dashboard.dart';


ThemeData lightmode=ThemeData(
colorScheme: ColorScheme.light(
surface: greyColor,
primary: BlueColor,
secondary:  secBlueColor,
tertiary: floatingActionButtonlight,
outline: dividerLight,

),
);
ThemeData darkMode=ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: backgroundgrey,
    primary: primarygrey,
    secondary: secgrey,
    tertiary: floatingActionButtondark,
    outline: dividerDark,
  ),
);