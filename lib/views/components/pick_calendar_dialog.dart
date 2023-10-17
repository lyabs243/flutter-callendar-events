import 'package:flutter/material.dart';

class PickCalendarDialog extends StatefulWidget {
  const PickCalendarDialog({Key? key}) : super(key: key);

  @override
  State<PickCalendarDialog> createState() => _PickCalendarDialogState();
}

class _PickCalendarDialogState extends State<PickCalendarDialog> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.3,
      child: (isLoading)? const Center(child: CircularProgressIndicator(),):
      ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: Text('Calendar $index'),
            onTap: () {
              Navigator.pop(context, index);
            },
          );
        },
      ),
    );

  }

}