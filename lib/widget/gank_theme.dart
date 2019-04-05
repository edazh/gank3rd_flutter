import 'package:flutter/material.dart';
import 'package:gank3rd/config/theme_config.dart';

class GankTheme {
  static ThemeData gankTheme = _buildGankTheme();

  static ThemeData _buildGankTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: ThemeConfig.accent,
      primaryColor: ThemeConfig.primary,
      primaryColorDark: ThemeConfig.primaryDark,
      primaryColorLight: ThemeConfig.primaryLight,
      dividerColor:ThemeConfig.divider,
      splashFactory: InkRipple.splashFactory,
    );
  }
}
