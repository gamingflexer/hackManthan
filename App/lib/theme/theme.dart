import 'package:flutter/material.dart';

class CustomTheme {
  static Color get bg => const Color(0xFFF9FAFF);

  static Color get card => const Color(0xFFFFFFFF);

  static Color get cardShadow => const Color(0xFFCCD4FF).withOpacity(0.3);

  static Color get onAccent => const Color(0xFFFFFFFF);

  static Color get accent => const Color(0xFF3F51B5);

  static Color get t1 => const Color(0xFF000000);

  static Color get t2 => const Color(0xFF898989);

  static Color get t3 => const Color(0xFFFFFFFF);

  static ThemeData getTheme(BuildContext context) {
    return ThemeData.from(
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Montserrat',
          ),
      colorScheme: const ColorScheme.light().copyWith(
          // primary: accent,
          // onPrimary: t1,
          // background: bg,
          // surface: card,
          ),
    );
  }
}
