import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/src/features/artists/view/view.dart';
import '/src/shared/classes/classes.dart';
import '/src/shared/extensions.dart';
import '/src/shared/views/views.dart';

class ArtistScreen extends ConsumerWidget {
  const ArtistScreen({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final colors = Theme.of(context).colorScheme;

        double headerHeight = constraints.maxWidth > 500 ? 300 : 400;

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => GoRouter.of(context).go('/artists'),
              ),
              title: Text('ARTIST - ${artist.name}'),
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
                                    artist.image.image,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: ArtistBio(artist: artist),
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
                                    artist.image.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      artist.bio,
                                      style: context.bodyLarge!.copyWith(
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
                        Tab(text: 'Updates'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(child: ArtistRankedSongs(artist: artist)),
                SingleChildScrollView(child: ArtistEvents(artist: artist)),
                SingleChildScrollView(child: ArtistNews(artist: artist)),
                SingleChildScrollView(child: ArtistUpdates(artist: artist)),
              ],
            ),
          ),
        );
      },
    );
  }
}
