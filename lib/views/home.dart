import 'package:flutter/material.dart';
import 'package:flutter_calendar_events/views/components/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinema Plus'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Text(
                        'Welcome to Cinema Plus, add your favorite movies to calendar and never miss a showtime.',
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: (isLoading)? const Center(child: CircularProgressIndicator(),):
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return MovieCard(key: Key('movie-$index'),);
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}