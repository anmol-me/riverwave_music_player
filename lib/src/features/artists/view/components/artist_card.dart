import 'dart:math';

import 'package:audio_player/src/shared/classes/classes.dart';
import 'package:audio_player/src/shared/providers/providers.dart';
import 'package:audio_player/src/shared/views/outlined_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/views/hoverable_song_play_button.dart';

class ArtistCard extends ConsumerWidget {
  const ArtistCard({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(songsProvider).getSongsById(artist.id);
    final nowPlaying = song[Random().nextInt(song.length)];

    final textTheme = Theme.of(context).textTheme;

    return OutlinedCard(
      child: LayoutBuilder(
        builder: (context, dimens) {
          return Row(
            children: [
              SizedBox(
                width: dimens.maxWidth * 0.4,
                child: Image.asset(
                  artist.image.image,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artist.name,
                        style: textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        artist.bio,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelSmall,
                        maxLines: 3,
                      ),
                      if (dimens.maxHeight > 100)
                        Row(
                          children: [
                            HoverableSongPlayButton(
                              size: const Size(50, 50),
                              song: nowPlaying,
                              child: const Icon(
                                Icons.play_circle,
                              ),
                            ),
                            Text(
                              nowPlaying.title,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: textTheme.labelMedium,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}