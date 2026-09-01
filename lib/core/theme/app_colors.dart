import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary= Color.fromRGBO(37, 146, 166, 1);
  // static const Color themeLight=  Color(0xff49ad4d);
  // static const Color themeLight=  Color.fromARGB(255, 78, 64, 204);
  // static const Color skyBlueLight= Color.fromRGBO(37, 146, 166, 1);
  static const Color skyBlueLight= Color.fromARGB(255, 234, 251, 250);
  // static const Color themeLightLighter = Color.fromRGBO(92, 182, 197, 1);
  static const Color darkBlue = Color.fromRGBO(38, 18, 125, 1);
  // static const Color themeDark = Color(0xff66af66);
  static const Color primaryDark = Color.fromRGBO(92, 182, 197, 1);
  // static const Color themeDark = Color.fromRGBO(26, 131, 147, 1.0);
  // static const Color themeDark = Color(0xFF25D366);
  static const Color sendMessageColor = Color(0xffDCF8C6);

  // static const Color themeDark = Color(0xFF09FBD3);
  static const Color secondary= Color.fromRGBO(74, 171, 189, 1.0);
  static const Color secondaryDark = Color(0xFF26B8A1);
  static const Color secondaryColor = Color(0xFFFE53BB);

  static const Color textColor = Color(0xFF2B2B2B);
  static const Color lightGrayColor = Color(0x44948282);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF2B2B2B);

  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color lightTextColor =  Color(0xFF403930);
  static const Color darkBackgroundColor =  Color(0xFF2B2B2B);
  static const Color darkTextColor = Color(0xFFF3F2FF);
  static const Color babyBlue = Color(0xff81deea);
  static const Color lightRed =Color(0xFFFFCDD2);
  static const Color deepPurple = Color(0xFF673AB7);
  static const Color darkGreen = Color(0xFF26B8A1);

  ///Light Colors
  static const Color lightGreen3= Color(0xFFDBE6DB);
  static const Color lightGreen= Color(0xFFB6E7B8);
  static const Color lightGreen2 = Color(0xFF90D5C7);
  static const Color redPink = Color(0xfff48fb1);
  static const Color violet = Color(0xffcf94da);
  static const Color lightPurple = Color(0xFFB29BE3);
  static const Color redOrange = Color(0xffffab91);
  static const Color lightBlue = Color(0xFFBBDEFB);
  //Youtube Colors
  static const Color youtubeRed = Color.fromARGB(255, 255, 0, 0);
  static const Color youtubeRedDark = Color.fromARGB(255, 230, 0, 0);
  static const Color youtubeRedLight = Color.fromARGB(255, 179, 0, 0);


  /* =======================
   * Brand Colors
   * ======================= */

  ///Tertiary
  static const Color tertiary = Color(0xFFC9B7E3);

  static const Color tertiaryDark = tertiary;

  ///Background
  static const Color background = whiteColor;
  static const Color backgroundDark = blackColor;

  ///Surface
  static const Color surface = blackColor;
  static const Color surfaceDark = whiteColor;

  static const Color lightPillBg = Color(0xFFE9F3F2);

  static const Color blue = Color(0xFF3544FF);

  static const Color coolGrey = Color(0xFF2B2D33);

  static const Color footertext = Color(0xFF636670);

  /// Other Colors
  static const Color accent = Color(0xFFF59E0B);

  // Amber
  static const Color yellowColor = Color(0xFFD88A00); // Amber



  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textDisabled = Color(0xFF9CA3AF);

  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFFCBD5E1);
  static const Color textDisabledDark = Color(0xFF64748B);

  static const Color grayishBlue = Color(0x99E5E7EB);
  static const Color greyColor = Colors.grey;
  static const Color lightGreyColor = Color(0xffE5E7EB);

  /* =======================
   * Status / Feedback Colors
   * ======================= */
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);

  /* =======================
   * Border & Divider
   * ======================= */
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF334155);

  /* =======================
   * Utility
   * ======================= */
  static const Color transparent = Colors.transparent;

  // static const Color themeLight= Colors.green;
  static const Color themeLight = Color(0xFF0F61A4);

  // static const Color themeLightLighter = Color.fromRGBO(92, 182, 197, 1);
  static const Color themeDark = Color(0xFF3871df);

  // static const Color themeDark = Color.fromRGBO(26, 131, 147, 1.0);

  // static const Color themeDark = Color(0xFF09FBD3);
  static const Color primaryContainerLight = Color.fromRGBO(74, 171, 189, 1.0);
  static const Color primaryContainerDark = Color(0xFF26B8A1);


  /* =======================
   * LIGHT THEME
   * ======================= */
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF9FAFB);

  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  static const Color lightBorder = Color(0xFFE5E7EB);

  /* =======================
   * DARK THEME
   * ======================= */
  static const Color darkBackground = Color(
    0xFF0F172A,
  ); // deep dark (not pure black)
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF334155);

  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);

  static const Color darkBorder = Color(0xFF334155);

  static const List<Color> kConcernCategoryColors = [
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFF22C55E),
    Color(0xFF3B82F6),
    Color(0xFFEF4444),
    Color(0xFF16A34A),
    Color(0xFFF97316),
    Color(0xFF6366F1),
    Color(0xFF0EA5E9),
    Color(0xFFDB2777),
    Color(0xFFDC2626),
    Color(0xFF7C3AED),
  ];

  static const paper = Color(0xFFF6F4EC);
  static const ink = Color(0xFF1E2A3B);
  static const inkSoft = Color(0xFF5B6A7C);
  static const green = Color(0xFF2E7D5F);
  static const greenSoft = Color(0xFFDCEBE3);
  static const hairline = Color(0xFFE4E0D3);
  static const cardShadow = Color(0x14140F0A);
}
