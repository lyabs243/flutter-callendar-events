import 'package:flutter_calendar_events/models/utils.dart';

class MovieScreeningItem {

  final String title;
  final String imagePath;
  final DateTime dateTime;
  final MovieEventState state;

  MovieScreeningItem({
    required this.title,
    required this.dateTime,
    required this.imagePath,
    this.state = MovieEventState.initial,
  });

}