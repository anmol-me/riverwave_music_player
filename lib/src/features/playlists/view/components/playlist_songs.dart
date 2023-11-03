import 'package:audio_player/src/shared/extensions.dart';
import 'package:audio_player/src/shared/views/adaptive_table.dart';
import 'package:flutter/material.dart';

import '../../../../shared/classes/classes.dart';
import '../../../../shared/views/clipped_image.dart';

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
    return AdaptiveTable<Song>(
      items: playlist.songs,
      breakpoint: 450,
      itemBuilder: (song, index) {
        return ListTile(
          onTap: () {},
          leading: ClippedImage(song.image.image),
          title: Text(song.title),
          subtitle: Text(song.length.toHumanizedString()),
        );
      },
    );
  }
}
