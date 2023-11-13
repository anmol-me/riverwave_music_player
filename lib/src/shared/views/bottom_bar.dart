import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:audio_player/src/shared/playback/playback_notifier.dart';
import 'package:audio_player/src/shared/extensions.dart';
import '../classes/classes.dart';

class BottomBar extends ConsumerWidget implements PreferredSizeWidget {
  const BottomBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playbackProvider);
    final stateNotifier = ref.watch(playbackProvider.notifier);

    return _BottomBar(
      artist: state.songWithProgress?.song.artist,
      isMuted: state.isMuted,
      isPlaying: state.isPlaying,
      preferredSize: preferredSize,
      progress: state.songWithProgress?.progress,
      song: state.songWithProgress?.song,
      togglePlayPause: stateNotifier.togglePlayPause,
      volume: state.volume,
    );
  }
}

class _BottomBar extends ConsumerWidget {
  const _BottomBar({
    required this.artist,
    required this.isMuted,
    required this.isPlaying,
    required this.preferredSize,
    required this.progress,
    required this.song,
    required this.togglePlayPause,
    required this.volume,
  });

  final Artist? artist;
  final bool isMuted;
  final bool isPlaying;
  final Size preferredSize;
  final Duration? progress;
  final Song? song;
  final VoidCallback togglePlayPause;
  final double volume;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) => constraints.isTablet
          ? _buildDesktopBar(context, constraints)
          : _buildMobileBar(context, constraints),
    );
  }

  Widget _buildMobileBar(BuildContext context, BoxConstraints constraints) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox(
        height: kToolbarHeight,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: () {},
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 4,
                bottom: 0,
                child: LinearProgressIndicator(
                  value: songProgress.clamp(0, 1),
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
              Positioned(
                left: 4,
                bottom: 4,
                top: 4,
                right: 4,
                child: Row(
                  children: [
                    _AlbumArt(song: song),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song?.title ?? '',
                          style: context.labelMedium,
                        ),
                        Text(
                          song?.artist.name ?? '',
                          style: context.labelSmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: togglePlayPause,
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopBar(BuildContext context, BoxConstraints constraints) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox.fromSize(
        size: preferredSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                _AlbumArt(song: song),
                _SongDetails(
                  artist: artist,
                  song: song,
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  _PlaybackControls(
                    isPlaying: isPlaying,
                    togglePlayPause: togglePlayPause,
                  ),
                  Center(
                    child: _ProgressBar(
                      progress: progress,
                      song: song,
                    ),
                  ),
                ],
              ),
            ),
            if (constraints.isDesktop) ...[
              _VolumeBar(volume: volume, isMuted: isMuted),
            ],
            if (song != null)
              IconButton(
                icon: const Icon(Icons.fullscreen),
                onPressed: () {
                  final overlay = Overlay.of(context);
                  OverlayEntry? entry;
                  entry = OverlayEntry(
                    builder: (context) => Stack(
                      children: [
                        Positioned(
                          child: Container(),
                        ),
                      ],
                    ),
                  );
                  overlay.insert(entry);
                },
              ),
          ],
        ),
      ),
    );
  }

  double get songProgress => switch ((progress, song)) {
        (Duration progress, Song song) =>
          progress.inMilliseconds / song.length.inMilliseconds,
        _ => 0,
      };
}

class _AlbumArt extends StatelessWidget {
  const _AlbumArt({
    required this.song,
  });

  final Song? song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 70,
        height: 70,
        child: song != null
            ? Image.asset(song!.image.image)
            : Container(
                color: Colors.pink[100],
              ),
      ),
    );
  }
}

/// Desktop Widgets

class _PlaybackControls extends StatelessWidget {
  const _PlaybackControls({
    required this.isPlaying,
    required this.togglePlayPause,
  });

  final bool isPlaying;
  final VoidCallback togglePlayPause;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double iconSize = 24;
      double playIconSize = 32;
      double innerPadding = 16;
      double playPadding = 20;
      if (constraints.maxWidth < 500) {
        iconSize = 21;
        playIconSize = 28;
        innerPadding = 14;
        playPadding = 17;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, innerPadding, 0),
              child: Icon(Icons.shuffle, size: iconSize)),
          Icon(Icons.skip_previous, size: iconSize),
          Padding(
            padding: EdgeInsets.fromLTRB(playPadding, 0, innerPadding, 0),
            child: GestureDetector(
              onTap: togglePlayPause,
              child: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: playIconSize,
              ),
            ),
          ),
          Icon(Icons.skip_next, size: iconSize),
          Padding(
            padding: EdgeInsets.fromLTRB(innerPadding, 0, 0, 0),
            child: Icon(Icons.repeat, size: iconSize),
          ),
        ],
      );
    });
  }
}

class _SongDetails extends StatelessWidget {
  const _SongDetails({
    required this.artist,
    required this.song,
  });

  final Artist? artist;
  final Song? song;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song != null ? song!.title : '-',
              style: context.labelLarge!.copyWith(fontSize: 12),
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
            Text(
              artist != null ? artist!.name : '-',
              style: context.labelSmall!.copyWith(fontSize: 8),
              overflow: TextOverflow.clip,
            ),
          ],
        );
      },
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.progress,
    required this.song,
  });

  /// Current playback depth into user is into [song].
  final Duration? progress;

  final Song? song;

  double get songProgress => switch ((progress, song)) {
        (Duration progress, Song song) =>
          progress.inMilliseconds / song.length.inMilliseconds,
        _ => 0,
      };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        EdgeInsets padding = switch (constraints.maxWidth) {
          > 500 => const EdgeInsets.symmetric(horizontal: 50),
          > 350 => const EdgeInsets.symmetric(horizontal: 25),
          _ => const EdgeInsets.symmetric(horizontal: 20),
        };
        return Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                child: progress != null
                    ? Text(progress!.toHumanizedString(),
                        style: Theme.of(context).textTheme.bodySmall)
                    : const Text('-'),
              ),
              Expanded(
                child: Consumer(builder: (context, ref, child) {
                  return Slider(
                    value: songProgress.clamp(0, 1),
                    divisions: 1000,
                    onChanged: (percent) {
                      ref.read(playbackProvider.notifier).moveToInSong(percent);
                    },
                    onChangeEnd: (percent) {
                      final playbackNotifier =
                          ref.read(playbackProvider.notifier);

                      playbackNotifier.moveToInSong(percent);
                      // Because dragging pauses auto playback, resume playing
                      // once the user finishes dragging.
                      playbackNotifier.togglePlayPause();
                    },
                    activeColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                    inactiveColor: Theme.of(context).colorScheme.onSurface,
                  );
                }),
              ),
              SizedBox(
                child: song != null
                    ? Text(song!.length.toHumanizedString(),
                        style: Theme.of(context).textTheme.bodySmall)
                    : const Text('-'),
              ),
              const SizedBox(width: 10)
            ],
          ),
        );
      },
    );
  }
}

class _VolumeBar extends ConsumerWidget {
  const _VolumeBar({
    required this.volume,
    required this.isMuted,
  });

  /// The percentage, between 0 and 1, at which to render the volume slider.
  final double volume;

  /// True if the user has explicitly pressed the mute button. The value for
  /// [volume] can be zero without this also being `true`, but if this is `true`,
  /// then the value for [volume] will always be zero.
  final bool isMuted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                ref.read(playbackProvider.notifier).toggleMute();
              },
              child: Icon(!isMuted ? Icons.volume_mute : Icons.volume_off),
            ),
            Expanded(
              child: Slider(
                value: volume,
                min: 0,
                max: 1,
                divisions: 100,
                onChanged: (newValue) {
                  ref.read(playbackProvider.notifier).setVolume(newValue);
                },
                activeColor: Theme.of(context).colorScheme.onTertiaryContainer,
                inactiveColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
