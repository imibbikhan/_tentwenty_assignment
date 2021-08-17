import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ten_twenty_movie/providers/home_movie_provider.dart';
import 'package:ten_twenty_movie/providers/movie_detail_provider.dart';
import 'package:ten_twenty_movie/screens/home_movie_screen.dart';
import 'package:ten_twenty_movie/screens/movie_detail_screen.dart';
import 'package:ten_twenty_movie/screens/movie_ticket_booking_screen.dart';
import 'package:ten_twenty_movie/utils/get_it_locator.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeMovieProvider()),
        ChangeNotifierProvider(create: (context) => MovieDetailProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeMovieScreen(),
      ),
    );
  }
}
