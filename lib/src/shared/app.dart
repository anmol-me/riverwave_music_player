import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/src/shared/providers/theme.dart';
import '/src/shared/router.dart';

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
          title: "RiverWave Music Player",
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
