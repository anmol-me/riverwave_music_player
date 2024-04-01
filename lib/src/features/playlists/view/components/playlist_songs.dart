import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/src/shared/extensions.dart';
import '/src/shared/views/adaptive_table.dart';
import '/src/shared/views/hoverable_song_play_button.dart';
import '/src/shared/classes/classes.dart';
import '/src/shared/playback/playback_notifier.dart';
import '/src/shared/views/clipped_image.dart';
import '/src/shared/views/hover_toggle.dart';

class PlaylistSongs extends StatelessWidget {
  const PlaylistSongs({
    super.key,
    required this.playlist,
    required this.constraints,
  });

  final Playlist playlist;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: AdaptiveTable<Song>(
        items: playlist.songs,
        breakpoint: 450,
        columns: const [
          DataColumn(
            label: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('#'),
            ),
          ),
          DataColumn(
            label: Text('Title'),
          ),
          DataColumn(
            label: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text('Length'),
            ),
          ),
        ],
        rowBuilder: (context, index) {
          return DataRow.byIndex(
            index: index,
            cells: [
              DataCell(
                HoverableSongPlayButton(
                  hoverMode: HoverMode.overlay,
                  song: playlist.songs[index],
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              DataCell(
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: ClippedImage(playlist.songs[index].image.image),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(playlist.songs[index].title)),
                  ],
                ),
              ),
              DataCell(
                Text(playlist.songs[index].length.toHumanizedString()),
              ),
            ],
          );
        },
        itemBuilder: (song, index) {
          return Consumer(
            builder: (context, ref, child) {
              return ListTile(
                onTap: () {
                  ref.read(playbackProvider.notifier).changeSong(song);
                },
                leading: ClippedImage(song.image.image),
                title: Text(song.title),
                subtitle: Text(song.length.toHumanizedString()),
              );
            }
          );
        },
      ),
    );
  }
}
