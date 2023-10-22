import 'package:audio_player/src/shared/providers/theme.dart';
import 'package:audio_player/src/shared/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppWidget extends ConsumerStatefulWidget {
  const AppWidget({super.key});

  @override
  ConsumerState createState() => _AppWidgetState();
}

class _AppWidgetState extends ConsumerState<AppWidget> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final theme = ref.watch(themeProvider);
    final themeSettings = ref.watch(themeSettingsProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: themeSettings.themeMode,
    );
  }
}
