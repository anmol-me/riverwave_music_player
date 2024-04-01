import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/src/features/artists/view/view.dart';
import '/src/shared/providers/providers.dart';

class ArtistsScreen extends ConsumerWidget {
  const ArtistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artists = ref.watch(artistProvider).getArtists();

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        primary: false,
        appBar: AppBar(
          title: const Text('ARTISTS'),
          toolbarHeight: kToolbarHeight * 2,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: artists.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: max(1, (constraints.maxWidth ~/ 400).toInt()),
            childAspectRatio: 2.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final artist = artists[index];
            return GestureDetector(
              child: ArtistCard(artist: artist),
              onTap: () => GoRouter.of(context).go('/artists/${artist.id}'),
            );
          },
        ),
      );
    });
  }
}
