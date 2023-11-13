import 'package:audio_player/src/shared/playback/playback_notifier.dart';
import 'package:audio_player/src/shared/views/adaptive_navigation.dart';
import 'package:audio_player/src/shared/views/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:universal_platform/universal_platform.dart';
import '../router.dart' as router;

class RootLayout extends ConsumerWidget {
  static const _switcherKey = ValueKey('switcherKey');
  static const _navigationRailKey = ValueKey('navigationRailKey');

  const RootLayout({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  final int currentIndex;
  final Widget child;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(playbackProvider).songWithProgress;
    
    onSelected(int index) {
      final destination = router.destinations[index];

      GoRouter.of(context).go(destination.path);
    }

    return AdaptiveNavigation(
      key: _navigationRailKey,
      destinations: router.destinations
          .map(
            (e) => NavigationDestination(
              icon: e.icon,
              label: e.label,
            ),
          )
          .toList(),
      selectedIndex: currentIndex,
      onDestinationSelected: onSelected,
      child: Column(
        children: [
          Expanded(
            child: _Switcher(
              key: _switcherKey,
              child: child,
            ),
          ),
          if (current != null) const BottomBar(),
        ],
      ),
    );
  }
}

class _Switcher extends StatelessWidget {
  final Widget child;

  const _Switcher({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return UniversalPlatform.isDesktop
        ? child
        : AnimatedSwitcher(
            key: key,
            duration: const Duration(seconds: 2),
            switchInCurve: Curves.easeInQuint,
            switchOutCurve: Curves.easeInOutCubic,
            child: child,
          );
  }
}
