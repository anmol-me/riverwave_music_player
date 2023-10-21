import 'package:flutter/cupertino.dart';

extension DurationString on String {
  /// Assumes a string (roughly) of the format '\d{1,2}:\d{2}'
  Duration toDuration() => switch (split(':')) {
    [var minutes, var seconds] => Duration(
      minutes: int.parse(minutes.trim()),
      seconds: int.parse(seconds.trim()),
    ),
    [var hours, var minutes, var seconds] => Duration(
      hours: int.parse(hours.trim()),
      minutes: int.parse(minutes.trim()),
      seconds: int.parse(seconds.trim()),
    ),
    _ => throw Exception('Invalid duration string: $this'),
  };
}

extension BreakPointUtils on BoxConstraints {
  bool get isTablet => maxWidth > 730;
  bool get isDesktop => maxWidth > 1200;
  bool get isMobile => !isTablet && !isDesktop;
}