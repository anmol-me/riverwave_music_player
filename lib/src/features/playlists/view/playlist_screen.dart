import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:audio_player/src/shared/extensions.dart';
import '../../../shared/classes/classes.dart';
import '../../../shared/views/views.dart';
import 'view.dart';

class PlaylistScreen extends ConsumerWidget {
  const PlaylistScreen({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final colors = Theme.of(context).colorScheme;

        final double headerHeight = constraints.isMobile
            ? max(constraints.biggest.height * 0.5, 450)
            : max(constraints.biggest.height * 0.25, 250);

        if (constraints.isMobile) {
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => GoRouter.of(context).go('/playlists'),
              ),
              title: Text(playlist.title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.play_circle_fill),
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shuffle),
                ),
              ],
            ),
            body: ArticleContent(
              child: PlaylistSongs(
                playlist: playlist,
                constraints: constraints,
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
