import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/src/shared/extensions.dart';
import '/src/shared/playback/playback_notifier.dart';
import '/src/shared/classes/classes.dart';
import '/src/shared/providers/providers.dart';
import '/src/shared/views/views.dart';

class ArtistRankedSongs extends ConsumerWidget {
  const ArtistRankedSongs({
    super.key,
    required this.artist,
  });

  final Artist artist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songs = ref.watch(songsProvider).getSongsById(artist.id);

    return AdaptiveTable<RankedSong>(
      items: songs,
      breakpoint: 450,
      itemBuilder: (song, index) {
        return ListTile(
          leading: ClippedImage(song.image.image),
          title: Text(song.title),
          subtitle: Text(song.length.toHumanizedString()),
          trailing: Text(song.ranking.toString()),
          onTap: () {
            ref.read(playbackProvider.notifier).changeSong(song);
          },
        );
      },
      columns: const [
        DataColumn(
          label: Text(
            'Ranking',
          ),
          numeric: true,
        ),
        DataColumn(
          label: Text(
            'Title',
          ),
        ),
        DataColumn(
          label: Text(
            'Length',
          ),
        ),
      ],
      rowBuilder: (song, index) => DataRow.byIndex(index: index, cells: [
        DataCell(
          HoverableSongPlayButton(
            song: song,
            child: Center(
              child: Text(song.ranking.toString()),
            ),
          ),
        ),
        DataCell(
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: ClippedImage(song.image.image),
            ),
            const SizedBox(width: 5.0),
            Expanded(child: Text(song.title)),
          ]),
        ),
        DataCell(
          Text(song.length.toHumanizedString()),
        ),
      ]),
    );
  }
}
