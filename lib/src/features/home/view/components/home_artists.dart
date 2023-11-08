import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:audio_player/src/shared/classes/classes.dart';
import 'package:audio_player/src/shared/extensions.dart';

class HomeArtists extends ConsumerWidget {
  const HomeArtists({
    super.key,
    required this.artists,
  });

  final List<Artist> artists;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.all(15),
      child: LayoutBuilder(builder: (context, constraints) {
        /// Mobile
        if (constraints.isMobile) {
          return Column(
            children: [
              for (final artist in artists) buildTile(context, artist),
            ],
          );
        }

        /// Desktop
        return Row(
          children: [
            for (final artist in artists)
              Expanded(child: buildTile(context, artist)),
          ],
        );
      }),
    );
  }
}

Widget buildTile(BuildContext context, Artist artist) {
  final theme = context.theme.textTheme;

  return ListTile(
    leading: CircleAvatar(
      backgroundImage: AssetImage(artist.image.image),
    ),
    title: Text(
      artist.updates.first,
      maxLines: 2,
      style: theme.labelLarge,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Text(artist.name, style: theme.labelMedium),
    ),
    onTap: () => GoRouter.of(context).go('/artists/${artist.id}'),
  );
}
