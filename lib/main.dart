import 'package:audio_player/src/shared/app.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';

final constraintsProvider = StateProvider<BoxConstraints>((ref) {
  return const BoxConstraints(maxHeight: 100, maxWidth: 100);
});

final dynamicColorProvider =
StateProvider<({ColorScheme? darkDynamic, ColorScheme? lightDynamic})?>(
      (ref) => (
  lightDynamic: ColorScheme.fromSeed(seedColor: Colors.black, brightness: Brightness.light),
  darkDynamic: ColorScheme.fromSeed(seedColor: Colors.black, brightness: Brightness.dark),
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
    ProviderScope(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return LayoutBuilder(builder: (context, constraints) {
            Future.delayed(Duration.zero).then((_) {
              return ref
                  .watch(constraintsProvider.notifier)
                  .update((state) => constraints);
            });

            return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
              Future.delayed(Duration.zero).then((_) {
                return ref.watch(dynamicColorProvider.notifier).update(
                      (_) => (
                  lightDynamic: lightDynamic,
                  darkDynamic: darkDynamic
                  ),
                );
              });

              return const AppWidget();
            });
          });
        },
        // child: const AppWidget(),
      ),
    ),
  );
}
