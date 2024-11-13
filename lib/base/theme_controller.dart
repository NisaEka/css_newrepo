import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static final light = ThemeData(
    primaryColor: blueJNE,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: blueJNE,
      secondary: greyLightColor2,
      surface: whiteColor,
      onPrimary: blueJNE,
      onSurface: whiteColor,
      outline: greyColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: whiteColor,
    ),
    dialogBackgroundColor: Colors.white,
    useMaterial3: true,
    fontFamily: 'Ubuntu',
    // backgroundColor: baseColor,
    appBarTheme: AppBarTheme(
      backgroundColor: whiteColor,
      shadowColor: greyColor,
      elevation: 0,
      titleTextStyle: appTitleTextStyle.copyWith(color: blueJNE),
      iconTheme: const IconThemeData(color: whiteColor),
    ),
    iconTheme: const IconThemeData(
      color: greyDarkColor1,
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: greyDarkColor1,
    )),
    textTheme: GoogleFonts.ubuntuTextTheme().copyWith(
        titleSmall: sublistTitleTextStyle.copyWith(
          color: greyDarkColor1,
        ),
        labelLarge: const TextStyle(
          color: greyDarkColor1,
        ),
        titleMedium: listTitleTextStyle.copyWith(
          color: greyDarkColor1,
        ),
        titleLarge: appTitleTextStyle.copyWith(
          color: greyDarkColor1,
        ),
        bodySmall: itemTextStyle.copyWith(
          color: greyDarkColor1,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: greyDarkColor1,
          // fontWeight: FontWeight.w600,
        ),
        headlineLarge: const TextStyle(
          fontSize: 24,
          color: greyDarkColor1,
          fontWeight: FontWeight.bold,
        )),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.resolveWith(
          (states) => blueJNE,
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: redJNE, // button text color
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: redJNE, // button text color
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateColor.resolveWith((states) => greyColor),
      thumbColor: WidgetStateColor.resolveWith((states) => blueJNE),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateColor.resolveWith((states) => blueJNE),
    ),
    checkboxTheme: CheckboxThemeData(
      // fillColor: WidgetStateColor.resolveWith((states) => greyColo),
      side: const BorderSide(color: blueJNE),
      checkColor: WidgetStateColor.resolveWith((states) => whiteColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: whiteColor,
      labelStyle: hintTextStyle.copyWith(color: greyDarkColor1),
      hintStyle: hintTextStyle,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      outlineBorder: const BorderSide(color: blueJNE),
      activeIndicatorBorder: const BorderSide(color: blueJNE),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: blueJNE,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: blueJNE,
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
          textStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          minimumSize: WidgetStateProperty.all<Size>(const Size(100, 40)),
          shape: WidgetStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          elevation: WidgetStateProperty.resolveWith<double>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return 0;
              }
              return 0; // Defer to the widget's default.
            },
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(blueJNE))),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: greyLightColor1,
    colorScheme: const ColorScheme.dark(
      primary: primaryDarkColor,
      secondary: greyDarkColor2,
      surface: bgDarkColor,
      brightness: Brightness.dark,
      onPrimary: infoColor,
      onSurface: Colors.transparent,
      outline: whiteColor,
    ),
    useMaterial3: true,
    iconTheme: const IconThemeData(
      color: greyLightColor1,
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: greyLightColor1,
    )),
    textTheme: GoogleFonts.ubuntuTextTheme().copyWith(
        labelLarge: const TextStyle(
          color: greyLightColor1,
        ),
        titleSmall: sublistTitleTextStyle.copyWith(
          color: greyLightColor1,
        ),
        titleMedium: listTitleTextStyle.copyWith(
          color: greyLightColor1,
        ),
        titleLarge: appTitleTextStyle.copyWith(color: greyLightColor1),
        bodySmall: itemTextStyle.copyWith(
          color: greyLightColor1,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: greyLightColor1,
          // fontWeight: FontWeight.w600,
        ),
        headlineLarge: const TextStyle(
          fontSize: 24,
          color: greyLightColor1,
          fontWeight: FontWeight.bold,
        )),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: redJNE, // button text color
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: redJNE, // button text color
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.resolveWith(
          (states) => whiteColor,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      // fillColor: WidgetStateColor.resolveWith((states) => greyColor),
      side: const BorderSide(color: whiteColor),
      checkColor: WidgetStateColor.resolveWith((states) => whiteColor),
    ),
    dialogBackgroundColor: greyColor,
    fontFamily: 'Ubuntu',
    // backgroundColor: greyColor,
    appBarTheme: AppBarTheme(
      // backgroundColor: const Color(0xff171717),
      elevation: 0,
      titleTextStyle: appTitleTextStyle.copyWith(color: whiteColor),
      iconTheme: const IconThemeData(color: whiteColor),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateColor.resolveWith((states) => redJNE),
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
      activeIndicatorBorder: const BorderSide(color: redJNE),
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
          textStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(const Size(100, 40)),
        shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        elevation: WidgetStateProperty.resolveWith<double>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return 0;
            }
            return 0; // Defer to the widget's default.
          },
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(blueJNE),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateColor.resolveWith((states) => redJNE),
    ),
  );

  Color activeColor(BuildContext context) {
    return AppConst.isLightTheme(context) ? blueJNE : infoColor;
  }

  Color? logoColor(BuildContext context) {
    return AppConst.isDarkTheme(context) ? whiteColor : null;
  }

  Color? textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? greyDarkColor1
        : whiteColor;
  }

  Color? cursorColor(BuildContext context) {
    return AppConst.isLightTheme(context) ? blueJNE : whiteColor;
  }

  ThemeData dateTimePickerTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      colorScheme: AppConst.isLightTheme(context)
          ? const ColorScheme.light().copyWith(primary: blueJNE)
          : const ColorScheme.dark().copyWith(primary: redJNE),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: redJNE, // button text color
        ),
      ),
    );
  }
}
