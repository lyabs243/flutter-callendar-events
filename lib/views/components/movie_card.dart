import 'package:flutter/material.dart';
import 'package:flutter_calendar_events/models/utils.dart';
import 'package:intl/intl.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();

}

class _MovieCardState extends State<MovieCard> {

  MovieEventState state = MovieEventState.initial;

  @override
  Widget build(BuildContext context) {

    state = MovieEventState.initial;

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
                image: const DecorationImage(
                  image: AssetImage('assets/images/adventure.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          const Text(
            'Movie Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            DateFormat(dateformat).format(DateTime.now()),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton.icon(
            onPressed: (state == MovieEventState.added)?
              null:
              () {

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
    switch (state) {
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
    switch (state) {
      case MovieEventState.added:
        return Colors.black12;
      case MovieEventState.loading:
      case MovieEventState.initial:
        return null;
    }
  }

  String get buttonText {
    switch (state) {
      case MovieEventState.added:
        return 'Added';
      case MovieEventState.loading:
        return 'Loading';
      case MovieEventState.initial:
        return 'Add to Calendar';
    }
  }

}