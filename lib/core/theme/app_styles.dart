import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppStyles {
  // Text Styles
  static TextStyle headingPrimary({double? fontSize , FontWeight fontWeight = FontWeight.w600, required BuildContext context,Color? color}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize:fontSize?? 20,
      fontFamily: "Montserrat",
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle descriptionPrimary({double fontSize = 16, FontWeight fontWeight = FontWeight.w400, required BuildContext context,Color? color, TextDecoration decoration = TextDecoration.none , Color? decorationColor}) {
    return TextStyle(
      fontFamily: 'Poppins',
      color:color?? Theme.of(context).colorScheme.onSurface,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      decorationColor: decorationColor,
    );
  }

  // Linear Gradients
  static Gradient appBarGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primaryContainer,
        Theme.of(context).colorScheme.primary,

      ],
    );
  }

  static const LinearGradient pinkPurple = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0XFFaa367c), Color(0XFF4a2fbd)],
  );

  static LinearGradient themeGradient(BuildContext context) => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withValues(alpha: 0.6)],
    // colors: [Color.fromRGBO(37, 146, 166, 1), ],
  );

  static const LinearGradient grayBlack = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0XFF2E2D36), Color(0XFF11101D)],
  );

  static const LinearGradient grayWhite = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF3F2FF)],
  );

  static LinearGradient chattingGradient= LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [const Color(0xFFDFFBFC) ,const Color(0xFFBFF5F7) ],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0XFF7DE7EB), Color(0XFF33BBCF)],
  );

  static LinearGradient contactGradient(BuildContext context) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Theme.of(context).colorScheme.onSurface, Theme.of(context).colorScheme.onSurface.withAlpha(150)],
  );

  // Box Shadows
  static final BoxShadow primaryColorShadow = BoxShadow(
    color: AppColors.primaryDark.withAlpha(100),
    blurRadius: 12.0,
    offset: const Offset(0.0, 0.0),
  );

  static final BoxShadow blackColorShadow = BoxShadow(
    color: Colors.black.withAlpha(100),
    blurRadius: 12.0,
    offset: const Offset(0.0, 0.0),
  );


}


extension AppTextExtension on BuildContext {

  /// Base TextStyle for the entire app
  TextStyle appTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    FontStyle? fontStyle,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextBaseline? textBaseline,
    Paint? foreground,
    Paint? background,
  }) {
    final theme = Theme.of(this);

    return TextStyle(
      fontSize: fontSize ,
      fontWeight: fontWeight ,
      fontStyle: fontStyle,
      color: color ?? theme.colorScheme.onSurface,
      fontFamily: fontFamily ?? 'Montserrat',
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      shadows: shadows,
      fontFeatures: fontFeatures,
      textBaseline: textBaseline,
      foreground: foreground,
      background: background,
    );
  }

// /// Reusable Text widget built on top of appTextStyle
// Text reusableText({
//   required String text,
//   required double fontSize,
//   required FontWeight fontWeight,
//   FontStyle? fontStyle,
//   Color? color,
//   String? fontFamily,
//   double? letterSpacing,
//   double? wordSpacing,
//   double? height,
//   TextDecoration? decoration,
//   Color? decorationColor,
//   TextDecorationStyle? decorationStyle,
//   double? decorationThickness,
//   List<Shadow>? shadows,
//   List<FontFeature>? fontFeatures,
//   bool isEllipsis = false,
//   int? maxLines,
//   TextAlign? textAlign,
//   TextOverflow? overflow,
//   TextDirection? textDirection,
//   Locale? locale,
//   StrutStyle? strutStyle,
//   TextWidthBasis? textWidthBasis,
//   TextHeightBehavior? textHeightBehavior,
//   Paint? foreground,
//   Paint? background,
// }) {
//   return Text(
//     text,
//     style: appTextStyle(
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       fontStyle: fontStyle,
//       color: color,
//       fontFamily: fontFamily,
//       letterSpacing: letterSpacing,
//       wordSpacing: wordSpacing,
//       height: height,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       decorationStyle: decorationStyle,
//       decorationThickness: decorationThickness,
//       shadows: shadows,
//       fontFeatures: fontFeatures,
//       foreground: foreground,
//       background: background,
//     ),
//     textAlign: textAlign,
//     overflow: overflow ?? (isEllipsis ? TextOverflow.ellipsis : null),
//     maxLines: isEllipsis ? (maxLines ?? 1) : maxLines,
//     textDirection: textDirection,
//     locale: locale,
//     strutStyle: strutStyle,
//     textWidthBasis: textWidthBasis,
//     textHeightBehavior: textHeightBehavior,
//   );
// }
}