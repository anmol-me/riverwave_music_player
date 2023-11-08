import 'package:flutter/material.dart';

import 'package:audio_player/src/shared/extensions.dart';
import '../../../../shared/classes/classes.dart';

class ArtistBio extends StatelessWidget {
  const ArtistBio({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Text(
      artist.bio,
      style: context.bodyLarge!.copyWith(
        fontSize: 16,
        color: context.colors.onSurface.withOpacity(
          0.87,
        ),
      ),
    );
  }
}
