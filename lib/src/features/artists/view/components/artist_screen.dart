import 'package:audio_player/src/features/artists/view/components/artist_ranked_songs.dart';
import 'package:audio_player/src/shared/providers/artists.dart';
import 'package:audio_player/src/shared/views/article_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/views/clipped_image.dart';
import 'artist_events.dart';
import 'artist_news.dart';

class ArtistScreen extends ConsumerWidget {
  const ArtistScreen({
    super.key,
    required this.artistId,
  });

  final String artistId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artist = ref.watch(artistProvider).getArtistById(artistId);

    return LayoutBuilder(
      builder: (context, constraints) {
        final colors = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;

        double headerHeight = constraints.maxWidth > 500 ? 300 : 400;

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => GoRouter.of(context).go('/artists'),
              ),
              title: Text('ARTIST - ${artist?.name}'),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight + headerHeight),
                child: Column(
                  children: [
                    ArticleContent(
                      child: Builder(
                        builder: (context) {
                          if (constraints.maxWidth > 500) {
                            return SizedBox(
                              height: headerHeight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClippedImage(
                                    artist!.image.image,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        artist.bio,
                                        style: textTheme.bodyLarge!.copyWith(
                                          color: colors.onSurface,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return SizedBox(
                            height: headerHeight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: ClippedImage(
                                    artist!.image.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      artist.bio,
                                      style: textTheme.bodyLarge!.copyWith(
                                        color: colors.onSurface,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const TabBar(
                      tabs: [
                        Tab(text: 'Songs'),
                        Tab(text: 'Events'),
                        Tab(text: 'News'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: ArtistRankedSongs(artist: artist!),
                ),
                SingleChildScrollView(child: ArtistEvents(artist: artist)),
                SingleChildScrollView(child: ArtistNews(artist: artist)),
              ],
            ),
          ),
        );
      },
    );
  }
}
