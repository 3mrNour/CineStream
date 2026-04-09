import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/screens/MainScreen.dart';
import 'package:cinestream/screens/MovieScreen.dart';
import 'package:cinestream/screens/SplashScreen.dart';
import 'package:cinestream/screens/TestScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'IBMPlexSansArabic'),
      home: MainScreen(),
    );
  }
}

// داتا وهمية للتجربة
final Movie dummyMovie = Movie(
  adult: false,
  originalLanguage: 'en',
  originalTitle: "John Wick: Chapter 4",
  id: 603692,
  popularity: 150.0,
  video: false,
  voteCount: 1500,
  releaseDate: DateTime(2024),
  title: "John Wick: Chapter 4",
  overview:
      "John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.",
  posterPath: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
  backdropPath: "/7I6VUdPj6tQECNHdviJkUHD2u89.jpg",
  voteAverage: 7.8,
  genreIds: [28, 53, 80], // Action, Thriller, Crime
);
