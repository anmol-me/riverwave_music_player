import '/src/shared/classes/song.dart';

class PlaybackState {
  final double volume;
  final double? previousVolume;
  final bool isMuted;
  final bool isPlaying;
  final SongWithProgress? songWithProgress;

  PlaybackState({
    required this.volume,
    required this.previousVolume,
    required this.isMuted,
    required this.isPlaying,
    required this.songWithProgress,
  });

  factory PlaybackState.initial() {
    return PlaybackState(
      volume: 0.5,
      previousVolume: null,
      isMuted: false,
      isPlaying: false,
      songWithProgress: null,
    );
  }

  PlaybackState copyWith({
    double? volume,
    double? previousVolume,
    bool? isMuted,
    bool? isPlaying,
    SongWithProgress? songWithProgress,
  }) {
    return PlaybackState(
      volume: volume ?? this.volume,
      previousVolume: previousVolume ?? this.previousVolume,
      isMuted: isMuted ?? this.isMuted,
      isPlaying: isPlaying ?? this.isPlaying,
      songWithProgress: songWithProgress ?? this.songWithProgress,
    );
  }
}

class SongWithProgress {
  final Duration progress;
  final Song song;

  SongWithProgress({
    required this.progress,
    required this.song,
  });

  SongWithProgress copyWith({
    Duration? progress,
    Song? song,
  }) {
    return SongWithProgress(
      progress: progress ?? this.progress,
      song: song ?? this.song,
    );
  }
}
