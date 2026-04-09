import 'package:cinestream/data/api/constants.dart';
import 'package:cinestream/data/models/movie_model.dart';
import 'package:flutter/material.dart';

class ApiEndpoints {
  final upComingMovies = '/movie/upcoming?api_key=$API_KEY';
  final popularMovies = '/movie/popular?api_key=$API_KEY';
  final topRatedMovies = '/movie/top_rated?api_key=$API_KEY';
  String getRelatedShows(movie_id) {
    return 'https://api.themoviedb.org/3/movie/${movie_id}/similar?api_key=$API_KEY';
  }

  final ImageBaseUrl = 'https://image.tmdb.org/t/p/original/';
}
