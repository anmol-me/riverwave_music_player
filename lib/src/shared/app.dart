import 'package:audio_player/src/shared/providers/theme.dart';
import 'package:audio_player/src/shared/router.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeProvider);
    final themeSettings = ref.watch(themeSettingsProvider);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: theme.light(lightDynamic?.primary),
          darkTheme: theme.dark(darkDynamic?.primary),
          themeMode: themeSettings.themeMode,
        );
      }
    );
  }
}
