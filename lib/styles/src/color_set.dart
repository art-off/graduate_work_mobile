import 'dart:ui';

import 'package:flutter/material.dart';

import 'rgb_color.dart';

// If needed we can give this manager custom colorSchema that
// we get from server
// (it's for constructor of applications)
class ColorSetManager {
  final ThemeMode themeMode;

  ColorSetManager(this.themeMode);

  ColorSet get colorSet => themeMode == ThemeMode.dark
      ? ColorSet.standardDark()
      : ColorSet.standardLight();
}

class ColorSet {
  static const staticClear = Color.fromARGB(0, 0, 0, 0);
  Color get clear => staticClear;

  final Color primary;

  final Color tabNavigation;
  final Color barNavigation;

  final Color separator;
  final Color shadow;

  final Color background;
  final Color content;
  final Color secondary;
  final Color secondary2;

  final Color primaryText;
  final Color secondaryText;

  /// Special colors
  final Color color2Gis;

  const ColorSet({
    required this.primary,
    required this.tabNavigation,
    required this.barNavigation,
    required this.separator,
    required this.shadow,
    required this.background,
    required this.content,
    required this.secondary,
    required this.secondary2,
    required this.primaryText,
    required this.secondaryText,
    required this.color2Gis,
  });

  ColorSet copyWith({Color? barNavigation, Color? primary}) => ColorSet(
        primary: primary ?? this.primary,
        tabNavigation: tabNavigation,
        barNavigation: barNavigation ?? this.barNavigation,
        separator: separator,
        shadow: shadow,
        background: background,
        content: content,
        secondary: secondary,
        secondary2: secondary2,
        primaryText: primaryText,
        secondaryText: secondaryText,
        color2Gis: color2Gis,
      );

  factory ColorSet.standardLight() => StandardColorSet.light;
  factory ColorSet.standardDark() => StandardColorSet.dark;
}

/// Standard color set
/// Use for define default colors, if from server noting came
class StandardColorSet {
  static const clear = Color.fromARGB(0, 0, 0, 0);
  static final black = RGBColor.fromHex('#000000');
  static final white = RGBColor.fromHex('#FFFFFF');
  static final universalGrey = RGBColor.fromHex('#f2f1f6');

  static final color2Gis = RGBColor.fromHex('#4b9229');

  static var light = ColorSet(
    primary: Colors.blue,
    tabNavigation: white,
    barNavigation: white,
    separator: universalGrey,
    shadow: black.withOpacity(0.2),
    background: RGBColor.fromHex('#EEEEEE'),
    content: white,
    secondary: RGBColor.fromHex('#DDDDDD'),
    secondary2: white,
    primaryText: black,
    secondaryText: black,
    color2Gis: color2Gis,
  );

  static var dark = ColorSet(
    primary: Colors.blue,
    tabNavigation: RGBColor.fromHex('#111111'),
    barNavigation: RGBColor.fromHex('#111111'),
    separator: universalGrey,
    shadow: clear,
    background: black,
    content: RGBColor.fromHex('#111111'),
    secondary: RGBColor.fromHex('#232323'),
    secondary2: RGBColor.fromHex('#616161'),
    primaryText: white,
    secondaryText: universalGrey,
    color2Gis: color2Gis,
  );
}
