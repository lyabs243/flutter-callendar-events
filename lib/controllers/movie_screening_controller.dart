import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_events/models/movie_screening_item.dart';
import 'package:timezone/timezone.dart' as tz;

class MovieScreeningController {

  List<Calendar> calendars = [];
  List<MovieScreeningItem> movieScreenings = [];
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

  init() async {
    await initCalendars();
    initScreenings();
  }

  Future<bool> addToCalendar(Calendar calendar, MovieScreeningItem movieScreening) async {
    Event event = Event(
      calendar.id,
      eventId: movieScreening.id,
      title: movieScreening.title,
      start: tz.TZDateTime.from(movieScreening.dateTime, tz.local),
    );

    Result<String>? result = await _deviceCalendarPlugin.createOrUpdateEvent(event);

    for (ResultError error in result?.errors?? []) {
      debugPrint('======Error add event to calendar: ${error.errorCode} ${error.errorMessage}');
    }

    if (result?.isSuccess?? false) {
      return true;
    }

    return false;
  }

  Future initCalendars() async {
    Result result = await _deviceCalendarPlugin.retrieveCalendars();

    for (ResultError error in result.errors) {
      debugPrint('======Error init calendars: ${error.errorCode} ${error.errorMessage}');
    }

    if (result.isSuccess) {
      calendars = result.data;
    }
  }

  Future<bool> checkEventExist(MovieScreeningItem movieScreening) async {
    for (Calendar calendar in calendars) {
      Result<List<Event>>? result = await _deviceCalendarPlugin.retrieveEvents(calendar.id, RetrieveEventsParams(startDate: movieScreening.dateTime, endDate: movieScreening.dateTime.add(const Duration(hours: 2))));

      for (ResultError error in result.errors) {
        debugPrint('======Error check event exist: ${error.errorCode} ${error.errorMessage}');
      }

      if (result.isSuccess) {
        for (Event event in result.data?? []) {
          if (event.eventId == movieScreening.id) {
            return true;
          }
        }
      }
    }

    return false;
  }

  initScreenings() {
    movieScreenings = [
      MovieScreeningItem(
        id: 'movie-screening-1',
        title: 'The last samurai',
        imagePath: 'assets/images/adventure.jpg',
        dateTime: DateTime.now().add(const Duration(days: 1)),
      ),
      MovieScreeningItem(
        id: 'movie-screening-2',
        title: 'End of the world',
        imagePath: 'assets/images/explosion.jpg',
        dateTime: DateTime.now().add(const Duration(days: 3)),
      ),
      MovieScreeningItem(
        id: 'movie-screening-3',
        title: 'From zero to hero',
        imagePath: 'assets/images/jump.jpg',
        dateTime: DateTime.now().add(const Duration(days: 4)),
      ),
      MovieScreeningItem(
        id: 'movie-screening-4',
        title: 'Challenge accepted',
        imagePath: 'assets/images/moto.jpg',
        dateTime: DateTime.now().add(const Duration(days: 6)),
      ),
      MovieScreeningItem(
        id: 'movie-screening-5',
        title: 'Bad vacation day',
        imagePath: 'assets/images/nature.jpg',
        dateTime: DateTime.now().add(const Duration(days: 10)),
      ),
    ];
  }

}