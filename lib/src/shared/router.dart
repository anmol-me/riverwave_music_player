import 'package:audio_player/src/features/artists/view/artists_screen.dart';
import 'package:audio_player/src/features/playlists/view/playlist_home_screen.dart';
import 'package:audio_player/src/shared/views/root_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/home/view/home_screen.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

final appRouterProvider = Provider((ref) => appRouter);

final appRouter = GoRouter(
  routes: [
    // HomeScreen
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 0,
          child: HomeScreen(),
        ),
      ),
    ),

    // PlaylistHomeScreen
    GoRoute(
      path: '/playlists',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 1,
          child: PlaylistHomeScreen(),
        ),
      ),
    ),

    // ArtistsScreen
    GoRoute(
      path: '/artists',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 2,
          child: ArtistsScreen(),
        ),
      ),
    ),

    /// Automatically generates GoRoute for
    /// NavigationDestination added after 3 in destinations
    for (final destination in destinations.skip(3))
      GoRoute(
        path: destination.path,
        pageBuilder: (context, state) => MaterialPage(
          key: _pageKey,
          child: RootLayout(
            key: _scaffoldKey,
            currentIndex: destinations.indexOf(destination),
            child: const SizedBox(),
          ),
        ),
      ),
  ],
);

final List<NavigationDestination> destinations = [
  NavigationDestination(
    label: 'Home',
    icon: const Icon(Icons.home),
    path: '/',
  ),
  NavigationDestination(
    label: 'Playlists',
    icon: const Icon(Icons.playlist_add_check),
    path: '/playlists',
  ),
  NavigationDestination(
    label: 'Artists',
    icon: const Icon(Icons.people),
    path: '/artists',
  ),
];

class NavigationDestination {
  final String label;
  final Icon icon;
  final String path;
  final Widget? child;

  NavigationDestination({
    required this.label,
    required this.icon,
    required this.path,
    this.child,
  });
}
