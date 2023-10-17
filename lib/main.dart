import 'package:flutter/material.dart';
import 'package:flutter_calendar_events/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Plus',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
