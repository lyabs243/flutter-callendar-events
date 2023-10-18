import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';

class PickCalendarDialog extends StatefulWidget {

  final List<Calendar> calendars;

  const PickCalendarDialog({Key? key, required this.calendars}) : super(key: key);

  @override
  State<PickCalendarDialog> createState() => _PickCalendarDialogState();
}

class _PickCalendarDialogState extends State<PickCalendarDialog> {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: widget.calendars.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: Text(widget.calendars[index].name?? ''),
            onTap: () {
              Navigator.pop(context, widget.calendars[index]);
            },
          );
        },
      ),
    );

  }

}