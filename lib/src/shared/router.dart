import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/src/features/artists/view/artists_screen.dart';
import '/src/features/playlists/view/playlist_home_screen.dart';
import '/src/features/artists/view/components/artist_screen.dart';
import '/src/features/home/view/home_screen.dart';
import '/src/features/playlists/view/playlist_screen.dart';
import '/src/shared/providers/providers.dart';
import '/src/shared/views/root_layout.dart';

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
      routes: [
        GoRoute(
          path: ':pid',
          pageBuilder: (context, state) {
            return MaterialPage<void>(
              key: state.pageKey,
              child: Consumer(
                builder: (context, ref, child) {
                  final playlist = ref
                      .read(playlistByIdProvider(state.pathParameters['pid']!));

                  return RootLayout(
                    key: _scaffoldKey,
                    currentIndex: 1,
                    child: PlaylistScreen(
                      playlist: playlist!,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
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
      routes: [
        GoRoute(
          path: ':aid',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: RootLayout(
              key: _scaffoldKey,
              currentIndex: 2,
              child: Consumer(
                builder: (context, ref, child) {
                  final artist = ref.read(artistProvider).getArtistById(state.pathParameters['aid']!);

                  return ArtistScreen(
                    artist: artist!,
                  );
                }
              ),
            ),
          ),
        ),
      ],
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
