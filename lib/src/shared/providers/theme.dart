import 'package:audio_player/main.dart';
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
    final targetColor = ref.read(themeSettingsProvider).sourceColor;
    final colorScheme = color(Brightness.light, targetColor);

    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: colorScheme,
    );
  }

  ThemeData dark([Color? targetColor]) {
    final targetColor = ref.read(themeSettingsProvider).sourceColor;
    final colorScheme = color(Brightness.dark, targetColor);

    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: colorScheme,
    );
  }

  ColorScheme color(Brightness brightness, Color? targetColor) {
    final dynamicColors = ref.read(dynamicColorProvider);

    final dynamicPrimary = brightness == Brightness.light
        ? dynamicColors!.lightDynamic?.primary
        : dynamicColors!.darkDynamic?.primary;

    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? sourceColor(targetColor),
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
