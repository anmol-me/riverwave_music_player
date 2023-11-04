import './classes.dart';

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
}
