import 'package:audio_player/src/shared/extensions.dart';
import 'package:audio_player/src/shared/views/adaptive_table.dart';
import 'package:audio_player/src/shared/views/hoverable_song_play_button.dart';
import 'package:flutter/material.dart';

import '../../../../shared/classes/classes.dart';
import '../../../../shared/views/clipped_image.dart';
import '../../../../shared/views/hover_toggle.dart';

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
          return ListTile(
            onTap: () {},
            leading: ClippedImage(song.image.image),
            title: Text(song.title),
            subtitle: Text(song.length.toHumanizedString()),
          );
        },
      ),
    );
  }
}
