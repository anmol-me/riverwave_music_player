import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:audio_player/src/shared/providers/providers.dart';
import 'package:audio_player/src/shared/classes/classes.dart';
import 'package:audio_player/src/shared/extensions.dart';

class HomeArtists extends ConsumerWidget {
  const HomeArtists({
    super.key,
    // required this.constraints,
  });

  // final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final constraints = ref.watch(constraintsProvider);
    final artists = ref.watch(artistProvider).artists;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: constraints!.isMobile
          ?

          /// Mobile
          Column(
              children: [
                for (final artist in artists) buildTile(context, artist!),
              ],
            )

          /// Desktop
          : Row(
              children: [
                for (final artist in artists)
                  Expanded(child: buildTile(context, artist!)),
              ],
            ),
    );
  }
}

Widget buildTile(BuildContext context, Artist artist) {
  final theme = Theme.of(context).textTheme;

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
