import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

final themeProvider = Provider((ref) => ThemeProvider(ref));

final themeSettingsProvider = StateProvider(
  (ref) => ThemeSettings(
    sourceColor: Colors.pink,
    themeMode: ThemeMode.system,
  ),
);

class ThemeSettings {
  ThemeSettings({
    required this.sourceColor,
    required this.themeMode,
  });

  final Color sourceColor;
  final ThemeMode themeMode;
}

class ThemeProvider {
  final Ref ref;

  ThemeProvider(this.ref);

  ThemeData light([Color? targetColor]) {
    final colorScheme = color(Brightness.light, targetColor);

    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: colorScheme,
      cardTheme: cardTheme(),
      appBarTheme: appBarTheme(colorScheme),
      bottomAppBarTheme: bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
      navigationRailTheme: navigationRailTheme(colorScheme),
      listTileTheme: listTileTheme(colorScheme),
      tabBarTheme: tabBarTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.background,
    );
  }

  ThemeData dark([Color? targetColor]) {
    final colorScheme = color(Brightness.dark, targetColor);

    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: colorScheme,
      cardTheme: cardTheme(),
      appBarTheme: appBarTheme(colorScheme),
      bottomAppBarTheme: bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
      navigationRailTheme: navigationRailTheme(colorScheme),
      listTileTheme: listTileTheme(colorScheme),
      tabBarTheme: tabBarTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.background,
    );
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return TabBarTheme(
      labelColor: colors.secondary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }

  DrawerThemeData drawerTheme(ColorScheme colors) {
    return DrawerThemeData(
      backgroundColor: colors.surface,
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return ListTileThemeData(
      shape: shapeMedium,
      selectedColor: colors.secondary,
    );
  }

  AppBarTheme appBarTheme(ColorScheme colors) {
    return AppBarTheme(
      elevation: 0,
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
    );
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return BottomAppBarTheme(
      color: colors.surface,
      elevation: 0,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.surfaceVariant,
      selectedItemColor: colors.onSurface,
      unselectedItemColor: colors.onSurfaceVariant,
      elevation: 0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }

  NavigationRailThemeData navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData();
  }

  ColorScheme color(Brightness brightness, Color? dynamicPrimary) {
    final settingsColor = ref.read(themeSettingsProvider).sourceColor;

    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? sourceColor(settingsColor),
      brightness: brightness,
    );
  }

  Color blend(Color targetColor) {
    final settings = ref.read(themeSettingsProvider);

    final harmonizedColor = Blend.harmonize(
      targetColor.value,
      settings.sourceColor.value,
    );
    return Color(harmonizedColor);
  }

  Color sourceColor(Color? target) {
    // Default value given
    Color source = ref.read(themeSettingsProvider).sourceColor;

    if (target != null) {
      source = blend(target);
    }

    return source;
  }

  ShapeBorder get shapeMedium => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      );

  CardTheme cardTheme() {
    return CardTheme(
      elevation: 0,
      shape: shapeMedium,
      clipBehavior: Clip.antiAlias,
    );
  }

  Color customColor(CustomColor customColor) {
    if (customColor.blend) {
      return blend(customColor.color);
    } else {
      return customColor.color;
    }
  }
}

class CustomColor {
  final String name;
  final Color color;
  final bool blend;

  CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });
}

final linkColor = CustomColor(
  name: 'Link Color',
  color: const Color(0xFF00B0FF),
);

Color randomColor() {
  return Color(Random().nextInt(0xFFFFFFFF));
}