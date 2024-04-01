import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/src/shared/providers/theme.dart';

class BrightnessToggle extends ConsumerWidget {
  const BrightnessToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      onPressed: () {
        final settings = ref.read(themeSettingsProvider);

        ref.read(themeSettingsProvider.notifier).update(
              (state) => ThemeSettings(
                sourceColor: settings.sourceColor,
                themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
              ),
            );
      },
      icon: isDark
          ? const Icon(Icons.brightness_7)
          : const Icon(Icons.brightness_3),
    );
  }
}
