import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_events/controllers/movie_screening_controller.dart';
import 'package:flutter_calendar_events/models/movie_screening_item.dart';
import 'package:flutter_calendar_events/models/utils.dart';
import 'package:flutter_calendar_events/views/components/pick_calendar_dialog.dart';
import 'package:intl/intl.dart';

class MovieCard extends StatefulWidget {

  final MovieScreeningController controller;
  final MovieScreeningItem item;

  const MovieCard({super.key, required this.item, required this.controller});

  @override
  State<MovieCard> createState() => _MovieCardState();

}

class _MovieCardState extends State<MovieCard> {

  late MovieScreeningItem item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(item.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            DateFormat(dateformat).format(item.dateTime),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton.icon(
            onPressed: (item.state == MovieEventState.added)?
              null:
              () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Pick a calendar'),
                      content: PickCalendarDialog(calendars: widget.controller.calendars),
                    );
                  },
                ).then((value) {
                  if (value is Calendar) {
                    setState(() {
                      item.state = MovieEventState.loading;
                    });

                    widget.controller.addToCalendar(value, item,).then((value) {

                      if (value) {
                        setState(() {
                          item.state = MovieEventState.added;
                        });
                      }
                      else {

                        // show error message in snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('An error occurred while adding to calendar'),
                          ),
                        );

                        setState(() {
                          item.state = MovieEventState.initial;
                        });
                      }

                    });
                  }
                });
              },
            icon: SizedBox(
              height: 20,
              width: 20,
              child: _loadingView,
            ),
            label: Text(buttonText),
          ),
        ],
      ),
    );

  }

  Widget get _loadingView {
    switch (item.state) {
      case MovieEventState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case MovieEventState.added:
        return const Center(
          child: Icon(Icons.check),
        );
      case MovieEventState.initial:
        return const Center(
          child: Icon(Icons.add),
        );
    }
  }

  Color? get buttonBackgroundColor {
    switch (item.state) {
      case MovieEventState.added:
        return Colors.black12;
      case MovieEventState.loading:
      case MovieEventState.initial:
        return null;
    }
  }

  String get buttonText {
    switch (item.state) {
      case MovieEventState.added:
        return 'Added';
      case MovieEventState.loading:
        return 'Loading';
      case MovieEventState.initial:
        return 'Add to Calendar';
    }
  }

}