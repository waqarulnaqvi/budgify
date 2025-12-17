import "package:flutter/material.dart";

import "app_colors.dart";

class MaterialTheme {
  // final TextTheme textTheme;

  const MaterialTheme(
    // this.textTheme,
  );

  static ColorScheme lightScheme() {
    return  ColorScheme(
      brightness: Brightness.light,
      primary:AppColors.themeLight,
      surfaceTint: Color(0xff535a92),
      onPrimary:Color.fromARGB(255, 119, 201, 196),
      primaryContainer: AppColors.primaryContainerLight,
      onPrimaryContainer: Color(0xff0d154b),
      secondary: Colors.grey.shade100,
      onSecondary:  AppColors.whiteColor,
      secondaryContainer: Color(0xffe0e0f9),
      onSecondaryContainer: Color(0xff181a2c),
      tertiary: Colors.white,
      onTertiary: Colors.white.withValues(alpha: 0.55),
      tertiaryContainer: Color(0xffffd7f0),
      onTertiaryContainer: Color(0xff35082e),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff46464f),
      outline: Color(0xff777680),
      outlineVariant: Color(0xffc7c5d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303036),
      inversePrimary: Color(0xffbcc2ff),
      primaryFixed: Color(0xffdfe0ff),
      onPrimaryFixed: Color(0xff0d154b),
      primaryFixedDim: Color(0xffbcc2ff),
      onPrimaryFixedVariant: Color(0xff3b4279),
      secondaryFixed: Color(0xffe0e0f9),
      onSecondaryFixed: Color(0xff181a2c),
      secondaryFixedDim: Color(0xffc4c5dd),
      onSecondaryFixedVariant: Color(0xff444559),
      tertiaryFixed: Color(0xffffd7f0),
      onTertiaryFixed: Color(0xff35082e),
      tertiaryFixedDim: Color(0xfff6b2e0),
      onTertiaryFixedVariant: Color(0xff68355c),
      surfaceDim: Color(0xffdbd9e0),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f2fa),
      surfaceContainer: Color(0xffefedf4),
      surfaceContainerHigh: Color(0xffeae7ef),
      surfaceContainerHighest: Color(0xffe4e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary:AppColors.themeLight,
      surfaceTint: Color(0xff535a92),
      onPrimary:Color.fromARGB(255, 119, 201, 196),
      primaryContainer: AppColors.primaryContainerLight,
      onPrimaryContainer: Color(0xffffffff),
      secondary: Colors.grey.shade100,
      onSecondary:  AppColors.whiteColor,
      secondaryContainer: Color(0xff727389),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Colors.white,
      onTertiary: Colors.white.withValues(alpha: 0.55),
      tertiaryContainer: Color(0xff9c628b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xff000000),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xff42424b),
      outline: Color(0xff5e5e67),
      outlineVariant: Color(0xff7a7a83),
      shadow: Color(0xff000000),
      scrim: Color(0xfffbf8ff),
      // scrim: Color(0xff000000),
      inverseSurface: Color(0xff303036),
      inversePrimary: Color(0xffbcc2ff),
      primaryFixed: Color(0xff6970aa),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff51588f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff727389),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff595a6f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9c628b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff804a72),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdbd9e0),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f2fa),
      surfaceContainer: Color(0xffefedf4),
      surfaceContainerHigh: Color(0xffeae7ef),
      surfaceContainerHighest: Color(0xffe4e1e9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return  ColorScheme(
      brightness: Brightness.light,
      primary:AppColors.themeLight,
      surfaceTint: Color(0xff535a92),
      onPrimary:Color.fromARGB(255, 119, 201, 196),
      primaryContainer: AppColors.primaryContainerLight,
      onPrimaryContainer: Color(0xffffffff),
      secondary: Colors.grey.shade100,
      onSecondary:  AppColors.whiteColor,
      secondaryContainer: Color(0xff727389),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Colors.white,
      onTertiary: Colors.white.withValues(alpha: 0.55),
      tertiaryContainer: Color(0xff643157),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff23232b),
      outline: Color(0xff42424b),
      outlineVariant: Color(0xff42424b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303036),
      inversePrimary: Color(0xffebeaff),
      primaryFixed: Color(0xff373e74),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff20285d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff404155),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff292b3e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff643157),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4a1a40),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdbd9e0),
      surfaceBright: Color(0xfffbf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f2fa),
      surfaceContainer: Color(0xffefedf4),
      surfaceContainerHigh: Color(0xffeae7ef),
      surfaceContainerHighest: Color(0xffe4e1e9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return  ColorScheme(
      brightness: Brightness.dark,
      primary:AppColors.themeDark,
      // primary:  Color.fromARGB(255, 119, 201, 196),
      surfaceTint: Color(0xffbcc2ff),
      onPrimary: Color.fromARGB(255, 52, 191, 138),
      primaryContainer: AppColors.primaryContainerDark,
      onPrimaryContainer: Color(0xffdfe0ff),
      secondary: Colors.grey.shade800,
      onSecondary: Colors.grey.shade800,
      secondaryContainer: Color(0xff727389),
      onSecondaryContainer: Color(0xffe0e0f9),
      tertiary: Colors.black,
      onTertiary:Colors.transparent,
      tertiaryContainer: Color(0xff68355c),
      onTertiaryContainer: Color(0xffffd7f0),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131318),
      onSurface: Color(0xffe4e1e9),
      onSurfaceVariant: Color(0xffc7c5d0),
      outline: Color(0xff90909a),
      outlineVariant: Color(0xff46464f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inversePrimary: Color(0xff535a92),
      primaryFixed: Color(0xffdfe0ff),
      onPrimaryFixed: Color(0xff0d154b),
      primaryFixedDim: Color(0xffbcc2ff),
      onPrimaryFixedVariant: Color(0xff3b4279),
      secondaryFixed: Color(0xffe0e0f9),
      onSecondaryFixed: Color(0xff181a2c),
      secondaryFixedDim: Color(0xffc4c5dd),
      onSecondaryFixedVariant: Color(0xff444559),
      tertiaryFixed: Color(0xffffd7f0),
      onTertiaryFixed: Color(0xff35082e),
      tertiaryFixedDim: Color(0xfff6b2e0),
      onTertiaryFixedVariant: Color(0xff68355c),
      surfaceDim: Color(0xff131318),
      surfaceBright: Color(0xff39393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1b1b21),
      surfaceContainer: Color(0xff1f1f25),
      surfaceContainerHigh: Color(0xff29292f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary:AppColors.themeDark,
      // primary: Color.fromARGB(255, 119, 201, 196),
      surfaceTint: Color(0xffbcc2ff),
      onPrimary: Color.fromARGB(255, 52, 191, 138),
      primaryContainer: AppColors.primaryContainerDark,
      onPrimaryContainer: Color(0xff000000),
      secondary: Colors.grey.shade800,
      onSecondary: Colors.grey.shade800,
      secondaryContainer:  Color(0xffffffff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Colors.black,
      onTertiary:Colors.transparent,
      tertiaryContainer: Color(0xffbb7da9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131318),
      onSurface: Color(0xfffdf9ff),
      onSurfaceVariant: Color(0xffcbc9d4),
      outline: Color(0xffa3a2ac),
      outlineVariant: Color(0xff83828c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inversePrimary: Color(0xff3c437a),
      primaryFixed: Color(0xffdfe0ff),
      onPrimaryFixed: Color(0xff020841),
      primaryFixedDim: Color(0xffbcc2ff),
      onPrimaryFixedVariant: Color(0xff2a3167),
      secondaryFixed: Color(0xffe0e0f9),
      onSecondaryFixed: Color(0xff0e1021),
      secondaryFixedDim: Color(0xffc4c5dd),
      onSecondaryFixedVariant: Color(0xff333548),
      tertiaryFixed: Color(0xffffd7f0),
      onTertiaryFixed: Color(0xff280022),
      tertiaryFixedDim: Color(0xfff6b2e0),
      onTertiaryFixedVariant: Color(0xff55244a),
      surfaceDim: Color(0xff131318),
      surfaceBright: Color(0xff39393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1b1b21),
      surfaceContainer: Color(0xff1f1f25),
      surfaceContainerHigh: Color(0xff29292f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary:AppColors.themeDark,
      // primary: Color.fromARGB(255, 119, 201, 196),
      surfaceTint: Color(0xffbcc2ff),
      onPrimary: Color.fromARGB(255, 52, 191, 138),
      primaryContainer: AppColors.primaryContainerDark,
      onPrimaryContainer: Color(0xff000000),
      secondary: Colors.grey.shade800,
      onSecondary: Colors.grey.shade800,
      secondaryContainer:  Color(0xffffffff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Colors.black,
      onTertiary:Colors.transparent,
      tertiaryContainer: Color(0xfffab6e5),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffdf9ff),
      outline: Color(0xffcbc9d4),
      outlineVariant: Color(0xffcbc9d4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e1e9),
      inversePrimary: Color(0xff1e255a),
      primaryFixed: Color(0xffe4e5ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffc1c7ff),
      onPrimaryFixedVariant: Color(0xff070f46),
      secondaryFixed: Color(0xffe5e5fe),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc8c9e1),
      onSecondaryFixedVariant: Color(0xff131526),
      tertiaryFixed: Color(0xffffdef1),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfffab6e5),
      onTertiaryFixedVariant: Color(0xff2f0328),
      surfaceDim: Color(0xff131318),
      surfaceBright: Color(0xff39393f),
      surfaceContainerLowest: Color(0xff0d0e13),
      surfaceContainerLow: Color(0xff1b1b21),
      surfaceContainer: Color(0xff1f1f25),
      surfaceContainerHigh: Color(0xff29292f),
      surfaceContainerHighest: Color(0xff34343a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    // textTheme: textTheme.apply(
    //   bodyColor: colorScheme.onSurface,
    //   displayColor: colorScheme.onSurface,
    // ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
