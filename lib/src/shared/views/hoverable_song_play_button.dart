import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../playback/playback_notifier.dart';
import 'hover_toggle.dart';
import '../classes/classes.dart';

class HoverableSongPlayButton extends StatelessWidget {
  const HoverableSongPlayButton({
    super.key,
    required this.song,
    required this.child,
    this.size = const Size(50, 50),
    this.hoverMode = HoverMode.replace,
  });

  final Widget child;
  final Size size;
  final Song song;
  final HoverMode hoverMode;

  @override
  Widget build(BuildContext context) {
    return HoverToggle(
      hoverChild: Center(
        child: Consumer(builder: (context, ref, child) {
          return GestureDetector(
            child: const Icon(Icons.play_arrow),
            onTap: () {
              ref.read(playbackProvider.notifier).changeSong(song);
            },
          );
        }),
      ),
      mode: hoverMode,
      size: size,
      child: child,
    );
  }
}
