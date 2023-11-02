import 'package:audio_player/src/shared/app.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

final dynamicColorProvider =
    StateProvider<({ColorScheme? darkDynamic, ColorScheme? lightDynamic})?>(
  (ref) => (
    lightDynamic: ColorScheme.fromSeed(
        seedColor: Colors.black, brightness: Brightness.light),
    darkDynamic: ColorScheme.fromSeed(
        seedColor: Colors.black, brightness: Brightness.dark),
  ),
);

Future setDesktopWindow() async {
  await DesktopWindow.setMinWindowSize(const Size(400, 400));
  await DesktopWindow.setWindowSize(const Size(1300, 900));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isDesktop) {
    setDesktopWindow();
  }

  runApp(
    const ProviderScope(
      child: AppWidget(),
    ),
  );
}
