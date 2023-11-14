import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:audio_player/src/shared/classes/classes.dart';
import 'package:audio_player/src/shared/classes/playback_state.dart';

final playbackProvider = NotifierProvider<PlaybackNotifier, PlaybackState>(() {
  return PlaybackNotifier();
});

class PlaybackNotifier extends Notifier<PlaybackState> {
  @override
  PlaybackState build() => PlaybackState.initial();

  void changeSong(Song song) {
    state = state.copyWith(
      isPlaying: true,
      songWithProgress: SongWithProgress(
        progress: const Duration(),
        song: song,
      ),
    );
    _resumePlayback();
  }

  void setVolume(double value) {
    state = state.copyWith(
      volume: value,
      isMuted: false,
      previousVolume: null,
    );
  }

  void toggleMute() {
    if (state.isMuted) {
      state = state.copyWith(
        isMuted: false,
        volume: state.previousVolume!,
        previousVolume: null,
      );
    } else {
      state = state.copyWith(
        isMuted: true,
        volume: 0,
        previousVolume: state.volume,
      );
    }
  }

  void moveToInSong(double percent) {
    _pausePlayback();

    final targetMilliseconds =
        state.songWithProgress!.song.length.inMilliseconds * percent;

    state = state.copyWith(
      isPlaying: false,
      songWithProgress: state.songWithProgress!.copyWith(
        progress: Duration(milliseconds: targetMilliseconds.toInt()),
      ),
    );
  }

  Timer? _playbackTimer;

  togglePlayPause() {
    if (state.isPlaying) {
      _pausePlayback();
    } else {
      _resumePlayback();
    }
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void _pausePlayback() => _playbackTimer?.cancel();

  void _resumePlayback() {
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Simulate playback progress, update the state accordingly
      final newProgress =
          state.songWithProgress!.progress + const Duration(seconds: 1);

      state = state.copyWith(
        songWithProgress:
            state.songWithProgress!.copyWith(progress: newProgress),
      );
    });
  }
}
