import 'package:audio_player/src/shared/extensions.dart';
import 'package:audio_player/src/shared/views/views.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:audio_player/src/shared/classes/classes.dart';

class HomeRecent extends ConsumerWidget {
  const HomeRecent({
    super.key,
    required this.playlists,
    this.axis = Axis.horizontal,
  });

  final List<Playlist> playlists;
  final Axis axis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// For Desktop
    if (axis == Axis.horizontal) {
      return SizedBox(
        height: 295,
        child: ListView.builder(
          scrollDirection: axis,
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlists[index];

            return Clickable(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: OutlinedCard(
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Image.asset(playlist.cover.image)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: buildDetails(context, playlist),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    /// For Mobile
    return ListView.builder(
      scrollDirection: axis,
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Clickable(
            onTap: () {},
            child: SizedBox(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClippedImage(
                    playlist.cover.image,
                    height: 200,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      child: buildDetails(context, playlist),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildDetails(BuildContext context, Playlist playlist) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Text(
          playlist.title,
          style: context.theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          playlist.description,
          overflow: TextOverflow.ellipsis,
          style: context.theme.textTheme.labelSmall,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
