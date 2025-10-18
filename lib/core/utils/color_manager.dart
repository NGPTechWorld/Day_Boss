import 'package:flutter/material.dart';

abstract class ColorManager {
  // --- Primary Theme Colors (Golden & Navy) ---
  static const Color primaryColor = Color(0xFFFFC857); // ذهبي لامع
  static const Color lightPrimaryColor = Color(0xFFFFE5A5); // ذهبي فاتح
  static const Color primaryDark = Color(0xFF0D1B2A); // كحلي غامق للخلفية

  // --- Secondary Colors (Silver / Metallic) ---
  static const Color secColor = Color(0xFFADB5BD); // رمادي معدني
  static const Color secLightColor = Color(0xFFE9ECEF); // فضي فاتح

  // --- Card & Background Colors ---
  static const Color cardBackground = Color(0xFFF8F9FA);
  static const Color cardBack2 = Color(0xFFF1F3F5);
  static const Color cardBack3 = Color(0xFFE9ECEF);
  static const Color cardHead = Color(0xFF495057); // رمادي غامق أنيق

  // --- Accent Colors ---
  static const Color yello = Color(0xFFFFC300); // ذهبي مائل للأصفر
  static const Color orangeColor = Color(0xFFFFA500);
  static const Color greenColor = Color(0xFF43AA8B);
  static const Color redColor = Color(0xFFE63946);

  // --- Text & General Colors ---
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color textColor1 = Color(
    0xFFDEE2E6,
  ); // نص فاتح على الخلفية الكحلية
  static const Color grey = Color(0xFFE0E0E0);
  static const Color grey2 = Color(0xFFD9D9D9);
  static const Color grey3 = Color(0xFFADB5BD);

  // --- Transparent ---
  static const Color transparentColor = Colors.transparent;

  // --- Shades for Shimmer & Effects ---
  static Color shimmerBaseColor = Colors.grey.shade400;
  static Color shimmerHighlightColor = Colors.grey.shade100;
  static Color shimmerBaseColorDark = Colors.grey.shade700;
  static Color shimmerHighlightColorDark = Colors.grey.shade800;

  // --- Extra Gradients & Variations ---
  static const Color gradientStart = Color(0xFFFFC857);
  static const Color gradientEnd = Color(0xFFB8860B);
  static const Color navy = Color(0xFF14213D);

  static const Color secoundLightColor = Color(0xffDCE1FF);
  static const Color primary1Color = Color(0xffF8F9FB);
  static const Color primary2Color = Color(0xffE7ECF0);
  static const Color primary3Color = Color(0xffC5CDD2);
  static const Color primary4Color = Color(0xffA9B4BC);
  static const Color primary5Color = Color(0xff606D76);
  static const Color primary6Color = Color(0xff354349);
  static const Color primary7Color = Color(0xff1B262E);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff000000);
}
