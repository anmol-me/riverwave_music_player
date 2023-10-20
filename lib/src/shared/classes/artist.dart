import 'package:audio_player/src/shared/providers/songs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './classes.dart';
// import '../providers/providers.dart';

final artistSongsProvider = Provider.family<List<RankedSong>, String>((ref, id) {
  return ref.read(songsProvider).getSongs().where((song) => song.artist.id == id).toList();
});

class Artist {
  const Artist({
    required this.id,
    required this.name,
    required this.image,
    required this.bio,
    required this.events,
    this.updates = const [],
    this.news = const [],
  });

  final String id;
  final String name;
  final MyArtistImage image;
  final String bio;
  final List<Event> events;
  final List<String> updates;
  final List<News> news;

// List<RankedSong> get songs =>
//     SongsProvider.shared.songs.where((song) => song.artist.id == id).toList();
}
