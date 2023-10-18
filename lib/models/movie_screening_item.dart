import 'package:flutter_calendar_events/models/utils.dart';

class MovieScreeningItem {

  String id;
  String title;
  String imagePath;
  DateTime dateTime;
  MovieEventState state;

  MovieScreeningItem({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.imagePath,
    this.state = MovieEventState.initial,
  });

}