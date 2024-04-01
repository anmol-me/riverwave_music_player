import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:adaptive_components/adaptive_components.dart';

import '/src/features/home/view/view.dart';
import '/src/features/playlists/view/components/playlist_songs.dart';
import '/src/shared/providers/providers.dart';
import '/src/shared/views/views.dart';
import '/src/shared/extensions.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.theme.textTheme;

    final artists = ref.read(artistProvider).getArtists();
    final topSongs = ref.read(topSongsProvider);
    final newReleases = ref.read(newReleasesProvider);
    final randomPlaylists = ref.read(randomPlaylistProvider);

    return LayoutBuilder(builder: (context, constraints) {
      /// Mobile
      if (constraints.isMobile) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: const Text('Good Morning'),
              actions: const [BrightnessToggle()],
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Home'),
                  Tab(text: 'Recently Played'),
                  Tab(text: 'New Releases'),
                  Tab(text: 'Top Songs'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const HomeHighlights(),
                      HomeArtists(artists: artists),
                    ],
                  ),
                ),
                HomeRecent(
                  playlists: randomPlaylists,
                  axis: Axis.vertical,
                ),
                PlaylistSongs(
                  playlist: newReleases,
                  constraints: constraints,
                ),
                PlaylistSongs(
                  playlist: topSongs,
                  constraints: constraints,
                ),
              ],
            ),
          ),
        );
      }

      /// Desktop
      return Scaffold(
        body: SingleChildScrollView(
          child: AdaptiveColumn(
            children: [
              AdaptiveContainer(
                columnSpan: 12,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Good Morning',
                          style: textTheme.displaySmall,
                        ),
                      ),
                      const BrightnessToggle(),
                    ],
                  ),
                ),
              ),
              AdaptiveContainer(
                columnSpan: 12,
                child: Column(
                  children: [
                    const HomeHighlights(),
                    HomeArtists(artists: artists),
                  ],
                ),
              ),
              AdaptiveContainer(
                columnSpan: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Text(
                        'Recently played',
                        style: textTheme.headlineSmall,
                      ),
                    ),
                    HomeRecent(playlists: randomPlaylists),
                  ],
                ),
              ),
              AdaptiveContainer(
                columnSpan: 12,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                'Top Songs Today',
                                style: textTheme.titleLarge,
                              ),
                            ),
                            PlaylistSongs(
                              playlist: topSongs,
                              constraints: constraints,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                'New Releases',
                                style: textTheme.titleLarge,
                              ),
                            ),
                            PlaylistSongs(
                              playlist: newReleases,
                              constraints: constraints,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
