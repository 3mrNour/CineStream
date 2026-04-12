import 'package:cinestream/data/models/movie_model.dart';
import 'package:cinestream/providers/movies_provider.dart';
import 'package:cinestream/providers/navBar_provider.dart';
import 'package:cinestream/providers/search_provider.dart';
import 'package:cinestream/providers/favourite_provider.dart';
import 'package:cinestream/providers/user_provider.dart';
import 'package:cinestream/screens/FavouriteScreen.dart';
import 'package:cinestream/screens/HomeScreen.dart';
import 'package:cinestream/screens/LoginScreen.dart';
import 'package:cinestream/screens/MainScreen.dart';
import 'package:cinestream/screens/MovieScreen.dart';
import 'package:cinestream/screens/RegisterScreen.dart';
import 'package:cinestream/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: 'IBMPlexSansArabic'),
        home: SplashScreen(),
      ),
    );
  }
}
