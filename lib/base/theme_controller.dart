import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData light() {
    return ThemeData(
      // primaryColor: blueJNE,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: blueJNE,
        secondary: greyLightColor2,
        background: whiteColor,
        onPrimary: blueJNE,
        onBackground: whiteColor,
      ),
      useMaterial3: true,
      fontFamily: 'Ubuntu',
      // backgroundColor: baseColor,
      appBarTheme: AppBarTheme(
        backgroundColor: whiteColor,
        elevation: 0,
        titleTextStyle: appTitleTextStyle,
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      textTheme: TextTheme(
        titleSmall: sublistTitleTextStyle.copyWith(
          color: greyDarkColor1,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: whiteColor,
        labelStyle: hintTextStyle.copyWith(color: greyDarkColor1),
        hintStyle: hintTextStyle,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: neutralColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: greyDarkColor1,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8,
          ),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            minimumSize: const Size(100, 40),
            // side: const BorderSide(color: infoColor),
            // foregroundColor: infoColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(const Size(100, 40)),
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return 0;
                }
                return 0; // Defer to the widget's default.
              },
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
      ),
    );
  }

  ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
          primary: primaryDarkColor,
          secondary: greyDarkColor2,
          background: bgDarkColor,
          brightness: Brightness.dark,
          onPrimary: infoColor,
          onBackground: greyColor),
      useMaterial3: true,
      textTheme: TextTheme(
        labelLarge: const TextStyle(
          color: greyColor,
        ),
        titleSmall: sublistTitleTextStyle.copyWith(
          color: greyLightColor1,
        ),
      ),

      fontFamily: 'Ubuntu',
      // backgroundColor: greyColor,
      appBarTheme: AppBarTheme(
        // backgroundColor: const Color(0xff171717),
        elevation: 0,
        titleTextStyle: appTitleTextStyle,
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // filled: true,
        // fillColor: Colors.transparent,
        labelStyle: hintTextStyle.copyWith(color: greyLightColor1),
        hintStyle: hintTextStyle.copyWith(color: whiteColor),
        counterStyle: hintTextStyle.copyWith(color: whiteColor),
        prefixIconColor: greyLightColor1,
        suffixIconColor: greyLightColor1,
        errorMaxLines: 3,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: whiteColor,
            width: 1,
            // style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: whiteColor,
            width: 1,
            // style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: whiteColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: greyColor,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            8,
          ),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            minimumSize: const Size(100, 40),
            // side: const BorderSide(color: infoColor),
            // foregroundColor: infoColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(const Size(100, 40)),
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return 0;
                }
                return 0; // Defer to the widget's default.
              },
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
      ),
    );
  }

  Color activeColor(BuildContext context) {
    return AppConst.isLightTheme(context) ? blueJNE : infoColor;
  }

  Color? logoColor(BuildContext context) {
    return AppConst.isDarkTheme(context) ? whiteColor : null;
  }

  Color? textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : whiteColor;
  }
}
