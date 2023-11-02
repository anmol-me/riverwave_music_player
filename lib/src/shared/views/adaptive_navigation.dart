import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdaptiveNavigation extends ConsumerWidget {
  const AdaptiveNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final Widget child;
  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final void Function(int index) onDestinationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Desktop
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 600) {
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                extended: constraints.maxWidth >= 800,
                minExtendedWidth: 180,
                destinations: destinations
                    .map(
                      (e) => NavigationRailDestination(
                        icon: e.icon,
                        label: Text(e.label),
                      ),
                    )
                    .toList(),
                selectedIndex: selectedIndex,
                onDestinationSelected: onDestinationSelected,
              ),
              Expanded(child: child),
            ],
          ),
        );
      }

      /// Mobile
      return Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          destinations: destinations,
          onDestinationSelected: onDestinationSelected,
          selectedIndex: selectedIndex,
        ),
      );
    });
  }
}
